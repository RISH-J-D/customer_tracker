from fastapi import APIRouter, Depends, HTTPException, Query, Header
from sqlalchemy.orm import Session
from typing import List, Optional
from datetime import datetime, time
from ..database import get_db
from ..models import FollowUp, Client, NotificationItem
from ..schemas import FollowUpCreate, FollowUpUpdate, FollowUpResponse, FollowUpWithClientInfo
from ..activity_logger import log_activity

router = APIRouter(prefix="/api/followups", tags=["Follow-ups & Meetups"])

@router.get("", response_model=List[FollowUpWithClientInfo])
def get_followups(
    today_only: Optional[bool] = Query(False),
    upcoming_only: Optional[bool] = Query(False),
    client_id: Optional[int] = Query(None),
    type: Optional[str] = Query(None),
    status: Optional[str] = Query(None),
    priority: Optional[str] = Query(None),
    db: Session = Depends(get_db)
):
    query = db.query(FollowUp)

    now = datetime.utcnow()

    if today_only:
        start_of_day = datetime.combine(now.date(), time.min)
        end_of_day = datetime.combine(now.date(), time.max)
        query = query.filter(FollowUp.scheduled_at >= start_of_day, FollowUp.scheduled_at <= end_of_day)
    elif upcoming_only:
        query = query.filter(FollowUp.scheduled_at >= now, FollowUp.status != "Completed")

    if client_id is not None:
        query = query.filter(FollowUp.client_id == client_id)
    if type:
        query = query.filter(FollowUp.type == type)
    if status:
        query = query.filter(FollowUp.status == status)
    if priority:
        query = query.filter(FollowUp.priority == priority)

    followups = query.order_by(FollowUp.scheduled_at.asc()).all()

    result = []
    for f in followups:
        f_info = FollowUpWithClientInfo.model_validate(f)
        if f.client:
            f_info.client_name = f.client.name
            f_info.client_company = f.client.company
            f_info.client_is_lead = f.client.is_lead
        result.append(f_info)

    return result

@router.post("", response_model=FollowUpWithClientInfo)
def create_followup(
    followup_in: FollowUpCreate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    client = db.query(Client).filter(Client.id == followup_in.client_id).first()
    if not client:
        raise HTTPException(status_code=404, detail="Client not found")

    followup = FollowUp(**followup_in.model_dump())
    db.add(followup)
    
    # If followup is marked positive, update client positive_approach
    if followup.is_positive_result and not client.positive_approach:
        client.positive_approach = True
        if not client.is_lead:
            client.status = "Positive Response"

    db.commit()
    db.refresh(followup)

    # Schedule notification item
    notif = NotificationItem(
        title=f"New {followup.type} Scheduled: {client.name}",
        message=f"{followup.title} scheduled for {followup.scheduled_at.strftime('%b %d, %H:%M UTC')}.",
        type="meetup_reminder" if followup.type == "Meetup" else "today_followup",
        client_id=client.id,
        followup_id=followup.id
    )
    db.add(notif)
    db.commit()

    # Log activity
    log_activity(
        db=db,
        action="SCHEDULE_FOLLOWUP",
        entity_type="FollowUp",
        entity_id=followup.id,
        entity_name=f"{followup.title} ({client.name})",
        description=f"Scheduled {followup.type} '{followup.title}' with {client.name} for {followup.scheduled_at.strftime('%Y-%m-%d %H:%M')} (Priority: {followup.priority})",
        changes={
            "client_name": client.name,
            "type": followup.type,
            "title": followup.title,
            "scheduled_at": str(followup.scheduled_at),
            "priority": followup.priority
        },
        user_name=x_user_name,
        user_username=x_user_username
    )

    f_info = FollowUpWithClientInfo.model_validate(followup)
    f_info.client_name = client.name
    f_info.client_company = client.company
    f_info.client_is_lead = client.is_lead
    return f_info

@router.put("/{followup_id}", response_model=FollowUpWithClientInfo)
def update_followup(
    followup_id: int, 
    followup_update: FollowUpUpdate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    followup = db.query(FollowUp).filter(FollowUp.id == followup_id).first()
    if not followup:
        raise HTTPException(status_code=404, detail="Follow-up not found")

    update_data = followup_update.model_dump(exclude_unset=True)
    diffs = {}
    for field, new_val in update_data.items():
        old_val = getattr(followup, field, None)
        if str(old_val) != str(new_val):
            diffs[field] = {"old": str(old_val), "new": str(new_val)}

    for field, val in update_data.items():
        setattr(followup, field, val)

    followup.updated_at = datetime.utcnow()

    # If positive result logged, update client positive approach
    if followup.is_positive_result and followup.client:
        followup.client.positive_approach = True
        if not followup.client.is_lead:
            followup.client.status = "Positive Response"

    db.commit()
    db.refresh(followup)

    if diffs:
        client_name = followup.client.name if followup.client else "Unknown"
        log_activity(
            db=db,
            action="UPDATE_FOLLOWUP",
            entity_type="FollowUp",
            entity_id=followup.id,
            entity_name=f"{followup.title} ({client_name})",
            description=f"Updated follow-up '{followup.title}': {list(diffs.keys())}",
            changes=diffs,
            user_name=x_user_name,
            user_username=x_user_username
        )

    f_info = FollowUpWithClientInfo.model_validate(followup)
    if followup.client:
        f_info.client_name = followup.client.name
        f_info.client_company = followup.client.company
        f_info.client_is_lead = followup.client.is_lead
    return f_info

@router.patch("/{followup_id}/complete", response_model=FollowUpWithClientInfo)
def complete_followup(
    followup_id: int, 
    is_positive: bool = Query(False), 
    convert_to_lead: bool = Query(False),
    notes: Optional[str] = Query(None),
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    followup = db.query(FollowUp).filter(FollowUp.id == followup_id).first()
    if not followup:
        raise HTTPException(status_code=404, detail="Follow-up not found")

    followup.status = "Completed"
    followup.completed_at = datetime.utcnow()
    followup.is_positive_result = is_positive
    if notes:
        existing = followup.notes or ""
        followup.notes = f"{existing}\n[Completed Outcome]: {notes}".strip()
    followup.updated_at = datetime.utcnow()

    # Handle positive client interaction / lead promotion
    client = followup.client
    if is_positive and client:
        client.positive_approach = True
        if convert_to_lead or not client.is_lead:
            if convert_to_lead:
                client.is_lead = True
                client.status = "Lead"
                client.lead_converted_at = datetime.utcnow()
                notif = NotificationItem(
                    title="🎉 Client Promoted to Lead!",
                    message=f"{client.name} became a Lead following positive {followup.type}: {followup.title}",
                    type="lead_promoted",
                    client_id=client.id,
                    followup_id=followup.id
                )
                db.add(notif)
            else:
                client.status = "Positive Response"

    db.commit()
    db.refresh(followup)

    client_name = client.name if client else "Unknown"
    log_activity(
        db=db,
        action="COMPLETE_FOLLOWUP",
        entity_type="FollowUp",
        entity_id=followup.id,
        entity_name=f"{followup.title} ({client_name})",
        description=f"Completed {followup.type} '{followup.title}' with {client_name}. (Outcome: {'Positive Response' if is_positive else 'Neutral'}, Promoted to Lead: {'Yes' if convert_to_lead else 'No'})",
        changes={
            "status": "Completed",
            "is_positive": is_positive,
            "convert_to_lead": convert_to_lead,
            "outcome_notes": notes
        },
        user_name=x_user_name,
        user_username=x_user_username
    )

    f_info = FollowUpWithClientInfo.model_validate(followup)
    if client:
        f_info.client_name = client.name
        f_info.client_company = client.company
        f_info.client_is_lead = client.is_lead
    return f_info

@router.delete("/{followup_id}")
def delete_followup(
    followup_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    followup = db.query(FollowUp).filter(FollowUp.id == followup_id).first()
    if not followup:
        raise HTTPException(status_code=404, detail="Follow-up not found")
    
    title = followup.title
    client_name = followup.client.name if followup.client else "Unknown"

    db.delete(followup)
    db.commit()

    log_activity(
        db=db,
        action="DELETE_FOLLOWUP",
        entity_type="FollowUp",
        entity_id=followup_id,
        entity_name=f"{title} ({client_name})",
        description=f"Deleted follow-up '{title}' for {client_name}",
        user_name=x_user_name,
        user_username=x_user_username
    )

    return {"message": "Follow-up deleted successfully", "id": followup_id}
