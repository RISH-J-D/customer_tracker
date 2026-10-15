from fastapi import APIRouter, Depends, HTTPException, Query, Header
from sqlalchemy.orm import Session, selectinload
from sqlalchemy import or_
from typing import List, Optional
from datetime import datetime, timezone
from ..database import get_db
from ..models import Client, ClientNote, FollowUp, NotificationItem
from ..schemas import ClientCreate, ClientUpdate, ClientResponse, ClientWithDetails, ClientNoteCreate, ClientNoteResponse, FollowUpLog
from ..activity_logger import log_activity

router = APIRouter(prefix="/api/clients", tags=["Clients"])

@router.get("", response_model=List[ClientWithDetails])
def get_clients(
    is_lead: Optional[bool] = Query(None),
    status: Optional[str] = Query(None),
    category: Optional[str] = Query(None),
    positive_only: Optional[bool] = Query(None),
    search: Optional[str] = Query(None),
    db: Session = Depends(get_db)
):
    query = db.query(Client).options(selectinload(Client.followups), selectinload(Client.note_entries))

    if is_lead is not None:
        query = query.filter(Client.is_lead == is_lead)
    if status:
        query = query.filter(Client.status == status)
    if category:
        query = query.filter(Client.category == category)
    if positive_only:
        query = query.filter(Client.positive_approach == True)
    if search:
        search_fmt = f"%{search.strip()}%"
        query = query.filter(
            or_(
                Client.name.ilike(search_fmt),
                Client.company.ilike(search_fmt),
                Client.email.ilike(search_fmt),
                Client.phone.ilike(search_fmt),
                Client.company_email.ilike(search_fmt),
                Client.company_phone.ilike(search_fmt),
                Client.notes.ilike(search_fmt),
                Client.note_entries.any(ClientNote.content.ilike(search_fmt))
            )
        )

    clients = query.order_by(Client.updated_at.desc()).all()
    
    return [_with_details(client) for client in clients]

def _with_details(client: Client) -> ClientWithDetails:
    c_dict = ClientWithDetails.model_validate(client)
    c_dict.total_followups = len(client.followups)
    c_dict.pending_followups = sum(1 for f in client.followups if f.status == "Pending")
    return c_dict

@router.post("", response_model=ClientResponse)
def create_client(
    client_in: ClientCreate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    client = Client(**client_in.model_dump())
    if client.is_lead:
        client.lead_converted_at = datetime.utcnow()
        if not client.status or client.status == "Prospect":
            client.status = "Lead"
    else:
        # Estimated value should only be added for leads, not for clients!
        client.deal_value = 0.0
        if client.positive_approach:
            client.status = "Positive Response"
        
    db.add(client)
    db.commit()
    db.refresh(client)

    # Log activity
    entity_label = "Lead" if client.is_lead else "Client"
    log_activity(
        db=db,
        action="CREATE_LEAD" if client.is_lead else "CREATE_CLIENT",
        entity_type="Lead" if client.is_lead else "Client",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"Created new {entity_label}: '{client.name}' with status '{client.status}'",
        changes={
            "name": client.name,
            "company": client.company,
            "status": client.status,
            "deal_value": client.deal_value,
            "is_lead": client.is_lead,
            "phone": client.phone,
            "email": client.email
        },
        user_name=x_user_name,
        user_username=x_user_username
    )

    # If created as lead or positive approach, generate notification
    if client.is_lead or client.positive_approach:
        notif = NotificationItem(
            title=f"New Lead / Positive Client: {client.name}",
            message=f"{client.company or client.name} was added with positive approach.",
            type="lead_promoted",
            client_id=client.id
        )
        db.add(notif)
        db.commit()

    return client

@router.get("/{client_id}", response_model=ClientWithDetails)
def get_client(client_id: int, db: Session = Depends(get_db)):
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    
    c_dict = ClientWithDetails.model_validate(client)
    c_dict.total_followups = len(client.followups)
    c_dict.pending_followups = sum(1 for f in client.followups if f.status == "Pending")
    return c_dict

@router.put("/{client_id}", response_model=ClientResponse)
def update_client(
    client_id: int, 
    client_update: ClientUpdate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    
    update_data = client_update.model_dump(exclude_unset=True)
    
    # Track changed fields for detailed logging
    diffs = {}
    for field, new_val in update_data.items():
        old_val = getattr(client, field, None)
        if old_val != new_val:
            diffs[field] = {"old": old_val, "new": new_val}

    # If is_lead changed to True
    if update_data.get("is_lead") is True and not client.is_lead:
        client.lead_converted_at = datetime.utcnow()
        if not update_data.get("status"):
            update_data["status"] = "Lead"
        update_data["positive_approach"] = True
    elif update_data.get("is_lead") is False or (not client.is_lead and not update_data.get("is_lead")):
        # Estimated value should only be added for leads, not for clients!
        update_data["deal_value"] = 0.0

    for field, val in update_data.items():
        setattr(client, field, val)
        
    client.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(client)

    # Log the update with all changes
    if diffs:
        summary_parts = []
        for f, d in diffs.items():
            summary_parts.append(f"{f}: '{d['old']}' -> '{d['new']}'")
        change_desc = f"Updated {client.name}: " + ", ".join(summary_parts[:3])
        if len(summary_parts) > 3:
            change_desc += f" (+{len(summary_parts)-3} more fields)"

        log_activity(
            db=db,
            action="UPDATE_CLIENT",
            entity_type="Lead" if client.is_lead else "Client",
            entity_id=client.id,
            entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
            description=change_desc,
            changes=diffs,
            user_name=x_user_name,
            user_username=x_user_username
        )

    return client

@router.delete("/{client_id}")
def delete_client(
    client_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    
    client_name = client.name
    client_company = client.company or "Steel Detailing"
    was_lead = client.is_lead

    db.delete(client)
    db.commit()

    log_activity(
        db=db,
        action="DELETE_CLIENT",
        entity_type="Lead" if was_lead else "Client",
        entity_id=client_id,
        entity_name=f"{client_name} ({client_company})",
        description=f"Deleted {'Lead' if was_lead else 'Client'} '{client_name}' and all associated followups",
        user_name=x_user_name,
        user_username=x_user_username
    )

    return {"message": "Client deleted successfully", "id": client_id}

def _get_note_or_404(db: Session, client_id: int, note_id: int) -> ClientNote:
    note = db.query(ClientNote).filter(ClientNote.id == note_id, ClientNote.client_id == client_id).first()
    if not note:
        raise HTTPException(status_code=404, detail="Note not found")
    return note

@router.post("/{client_id}/notes", response_model=ClientNoteResponse)
def add_client_note(
    client_id: int,
    note_in: ClientNoteCreate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    content = note_in.content.strip()
    if not content:
        raise HTTPException(status_code=400, detail="Note cannot be empty")

    note = ClientNote(client_id=client_id, content=content, author=x_user_name)
    db.add(note)
    client.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(note)

    log_activity(
        db=db,
        action="ADD_NOTE",
        entity_type="Lead" if client.is_lead else "Client",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"Added note to {client.name}: '{content[:80]}'",
        user_name=x_user_name,
        user_username=x_user_username
    )
    return note

@router.put("/{client_id}/notes/{note_id}", response_model=ClientNoteResponse)
def update_client_note(
    client_id: int,
    note_id: int,
    note_in: ClientNoteCreate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    note = _get_note_or_404(db, client_id, note_id)
    content = note_in.content.strip()
    if not content:
        raise HTTPException(status_code=400, detail="Note cannot be empty")
    old_content = note.content
    note.content = content
    db.commit()
    db.refresh(note)

    log_activity(
        db=db,
        action="UPDATE_NOTE",
        entity_type="Note",
        entity_id=note.id,
        entity_name=f"Note on client #{client_id}",
        description=f"Edited note: '{content[:80]}'",
        changes={"content": {"old": old_content, "new": content}},
        user_name=x_user_name,
        user_username=x_user_username
    )
    return note

@router.delete("/{client_id}/notes/{note_id}")
def delete_client_note(
    client_id: int,
    note_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    note = _get_note_or_404(db, client_id, note_id)
    old_content = note.content
    db.delete(note)
    db.commit()

    log_activity(
        db=db,
        action="DELETE_NOTE",
        entity_type="Note",
        entity_id=note_id,
        entity_name=f"Note on client #{client_id}",
        description=f"Deleted note: '{old_content[:80]}'",
        user_name=x_user_name,
        user_username=x_user_username
    )
    return {"message": "Note deleted", "id": note_id}

@router.patch("/{client_id}/promote-to-lead", response_model=ClientResponse)
def promote_client_to_lead(
    client_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    """Convert client to Lead after a positive approach or successful meetup"""
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    
    client.is_lead = True
    client.status = "Lead"
    client.positive_approach = True
    client.lead_converted_at = datetime.utcnow()
    client.updated_at = datetime.utcnow()
    
    # Create high-visibility notification
    notif = NotificationItem(
        title="🌟 Client Converted to Lead!",
        message=f"{client.name} ({client.company or 'Individual'}) has been upgraded to an Active Lead following a positive approach!",
        type="lead_promoted",
        client_id=client.id
    )
    db.add(notif)
    db.commit()
    db.refresh(client)

    log_activity(
        db=db,
        action="CONVERT_LEAD",
        entity_type="Lead",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"Promoted prospect '{client.name}' to Qualified Lead",
        changes={"is_lead": True, "status": "Lead", "positive_approach": True},
        user_name=x_user_name,
        user_username=x_user_username
    )

    return client

@router.patch("/{client_id}/toggle-account", response_model=ClientResponse)
def toggle_account_conversion(
    client_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    """Mark a lead as converted to an account, or undo that"""
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")

    was_converted = client.account_converted_at is not None
    client.account_converted_at = None if was_converted else datetime.utcnow()
    if not was_converted:
        client.marked_negative_at = None  # an account can't also be marked negative
    client.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(client)

    log_activity(
        db=db,
        action="UPDATE_CLIENT",
        entity_type="Lead" if client.is_lead else "Client",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"{'Reverted account conversion for' if was_converted else 'Converted to account:'} '{client.name}'",
        changes={"account_converted": {"old": was_converted, "new": not was_converted}},
        user_name=x_user_name,
        user_username=x_user_username
    )

    return client

@router.patch("/{client_id}/toggle-prospect", response_model=ClientResponse)
def toggle_prospect(
    client_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    """Flag a client as a hot prospect (row highlighted on the Clients page), or undo that"""
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")

    was_prospect = client.prospect_marked_at is not None
    client.prospect_marked_at = None if was_prospect else datetime.utcnow()
    client.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(client)

    log_activity(
        db=db,
        action="UPDATE_CLIENT",
        entity_type="Lead" if client.is_lead else "Client",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"{'Removed prospect flag from' if was_prospect else 'Marked as prospect:'} '{client.name}'",
        changes={"prospect": {"old": was_prospect, "new": not was_prospect}},
        user_name=x_user_name,
        user_username=x_user_username
    )

    return client

@router.post("/{client_id}/log-followup", response_model=ClientWithDetails)
def log_followup(
    client_id: int,
    log_in: FollowUpLog,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    """'I followed up': save today's conversation as a dated note, close the pending
    follow-ups, and optionally schedule the next one"""
    client = db.query(Client).options(selectinload(Client.followups), selectinload(Client.note_entries)).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")

    now = datetime.utcnow()
    note = (log_in.note or "").strip()
    if note:
        db.add(ClientNote(client_id=client.id, content=note, author=x_user_name))

    completed = 0
    for f in client.followups:
        if f.status == "Pending":
            f.status = "Completed"
            f.updated_at = now
            if note:
                f.notes = f"{f.notes or ''}\n[Completed Outcome]: {note}".strip()
            completed += 1

    next_at = log_in.next_followup_at
    if next_at is not None and next_at.tzinfo is not None:
        next_at = next_at.astimezone(timezone.utc).replace(tzinfo=None)  # stored as naive UTC
    if next_at is not None:
        db.add(FollowUp(
            client_id=client.id,
            title=f"Follow-up with {client.name}",
            type="Call",
            scheduled_at=next_at,
            priority="Medium",
            status="Pending"
        ))

    client.updated_at = now
    db.commit()
    db.expire(client)
    client = db.query(Client).options(selectinload(Client.followups), selectinload(Client.note_entries)).filter(Client.id == client_id).first()

    next_text = f"next follow-up {next_at.strftime('%Y-%m-%d')}" if next_at else "no next follow-up"
    log_activity(
        db=db,
        action="COMPLETE_FOLLOWUP",
        entity_type="Lead" if client.is_lead else "Client",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"Followed up with {client.name}; {next_text}",
        changes={"note": note or None, "completed_followups": completed, "next_followup_at": str(next_at) if next_at else None},
        user_name=x_user_name,
        user_username=x_user_username
    )

    return _with_details(client)

@router.patch("/{client_id}/toggle-negative", response_model=ClientResponse)
def toggle_negative(
    client_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    """Mark a lead as not feasible / not contactable / negative (row turns red), or undo that"""
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")

    was_negative = client.marked_negative_at is not None
    client.marked_negative_at = None if was_negative else datetime.utcnow()
    if not was_negative:
        client.account_converted_at = None  # a negative lead can't also be an account
    client.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(client)

    log_activity(
        db=db,
        action="UPDATE_CLIENT",
        entity_type="Lead" if client.is_lead else "Client",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"{'Cleared negative mark for' if was_negative else 'Marked as not feasible / negative:'} '{client.name}'",
        changes={"marked_negative": {"old": was_negative, "new": not was_negative}},
        user_name=x_user_name,
        user_username=x_user_username
    )

    return client

@router.patch("/{client_id}/toggle-positive", response_model=ClientResponse)
def toggle_positive_approach(
    client_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    """Toggle positive approach status on client"""
    client = db.query(Client).filter(Client.id == client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")
    
    old_status = client.positive_approach
    client.positive_approach = not client.positive_approach
    if client.positive_approach and client.status == "Prospect":
        client.status = "Positive Response"
        
    client.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(client)

    log_activity(
        db=db,
        action="UPDATE_CLIENT",
        entity_type="Lead" if client.is_lead else "Client",
        entity_id=client.id,
        entity_name=f"{client.name} ({client.company or 'Steel Detailing'})",
        description=f"Toggled positive response flag for '{client.name}' from {old_status} to {client.positive_approach}",
        changes={"positive_approach": {"old": old_status, "new": client.positive_approach}},
        user_name=x_user_name,
        user_username=x_user_username
    )

    return client
