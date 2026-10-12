from fastapi import APIRouter, Depends, HTTPException, Query, Header
from sqlalchemy.orm import Session
from sqlalchemy import or_
from typing import List, Optional
from datetime import datetime
from ..database import get_db
from ..models import Client, FollowUp, NotificationItem
from ..schemas import ClientCreate, ClientUpdate, ClientResponse, ClientWithDetails
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
    query = db.query(Client)

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
                Client.notes.ilike(search_fmt)
            )
        )

    clients = query.order_by(Client.updated_at.desc()).all()
    
    # Enrich with counts
    result = []
    for client in clients:
        c_dict = ClientWithDetails.model_validate(client)
        c_dict.total_followups = len(client.followups)
        c_dict.pending_followups = sum(1 for f in client.followups if f.status == "Pending")
        result.append(c_dict)

    return result

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
        description=f"Promoted prospect '{client.name}' to Qualified Lead (Deal Value: ${client.deal_value:,.2f})",
        changes={"is_lead": True, "status": "Lead", "positive_approach": True},
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
