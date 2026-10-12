from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from datetime import datetime, timedelta, time
from typing import List
from ..database import get_db
from ..models import NotificationItem, FollowUp
from ..schemas import NotificationResponse

router = APIRouter(prefix="/api/notifications", tags=["Notifications"])

@router.get("", response_model=List[NotificationResponse])
def get_notifications(db: Session = Depends(get_db)):
    return db.query(NotificationItem).order_by(NotificationItem.created_at.desc()).limit(30).all()

@router.post("/{notification_id}/read")
def mark_read(notification_id: int, db: Session = Depends(get_db)):
    notif = db.query(NotificationItem).filter(NotificationItem.id == notification_id).first()
    if notif:
        notif.is_read = True
        db.commit()
    return {"status": "ok"}

@router.post("/mark-all-read")
def mark_all_read(db: Session = Depends(get_db)):
    db.query(NotificationItem).update({NotificationItem.is_read: True})
    db.commit()
    return {"status": "ok"}

@router.get("/check-reminders")
def check_reminders(db: Session = Depends(get_db)):
    """
    Checks follow-ups and meetups that are scheduled for today or coming up in next 60 minutes
    and creates notification items if not already triggered.
    """
    now = datetime.utcnow()
    start_of_day = datetime.combine(now.date(), time.min)
    end_of_day = datetime.combine(now.date(), time.max)
    in_one_hour = now + timedelta(hours=1)

    today_followups = db.query(FollowUp).filter(
        FollowUp.scheduled_at >= start_of_day,
        FollowUp.scheduled_at <= end_of_day,
        FollowUp.status == "Pending",
        FollowUp.reminder_sent == False
    ).all()

    new_notifs_count = 0
    for f in today_followups:
        client_name = f.client.name if f.client else "Client"
        company = f"({f.client.company})" if (f.client and f.client.company) else ""
        time_str = f.scheduled_at.strftime("%I:%M %p")
        
        is_imminent = (f.scheduled_at <= in_one_hour and f.scheduled_at >= now)
        
        if is_imminent:
            title = f"⏰ Meetup Starting Soon: {client_name}"
            msg = f"{f.title} with {client_name} {company} starts in less than an hour at {time_str}!"
            ntype = "meetup_reminder"
        else:
            title = f"📅 Today's Follow-up: {client_name}"
            msg = f"Reminder: {f.title} scheduled for today at {time_str}."
            ntype = "today_followup"

        notif = NotificationItem(
            title=title,
            message=msg,
            type=ntype,
            client_id=f.client_id,
            followup_id=f.id,
            is_read=False
        )
        db.add(notif)
        f.reminder_sent = True
        new_notifs_count += 1

    if new_notifs_count > 0:
        db.commit()

    unread = db.query(NotificationItem).filter(NotificationItem.is_read == False).count()
    return {
        "status": "checked", 
        "new_notifications": new_notifs_count, 
        "unread_count": unread
    }
