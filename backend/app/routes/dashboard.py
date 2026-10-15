from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import func
from datetime import datetime, time
from typing import List
from ..database import get_db
from ..models import Client, FollowUp
from ..schemas import DashboardStats, FollowUpWithClientInfo

router = APIRouter(prefix="/api/dashboard", tags=["Dashboard"])

@router.get("/stats", response_model=DashboardStats)
def get_dashboard_stats(db: Session = Depends(get_db)):
    # Clients tab = everyone who is neither a lead nor converted to an account
    total_clients = db.query(Client).filter(Client.is_lead == False, Client.account_converted_at.is_(None)).count()
    total_leads = db.query(Client).filter(Client.is_lead == True).count()
    total_accounts = db.query(Client).filter(Client.account_converted_at.isnot(None)).count()
    total_prospects = db.query(Client).filter(
        Client.is_lead == False, Client.account_converted_at.is_(None), Client.prospect_marked_at.isnot(None)
    ).count()
    positive_clients = db.query(Client).filter(Client.positive_approach == True).count()

    # Share of all records that became accounts
    conversion_rate = 0.0
    all_records = db.query(Client).count()
    if all_records > 0:
        conversion_rate = round((total_accounts / all_records) * 100, 1)

    now = datetime.utcnow()
    start_of_day = datetime.combine(now.date(), time.min)
    end_of_day = datetime.combine(now.date(), time.max)

    today_followups = db.query(FollowUp).filter(
        FollowUp.scheduled_at >= start_of_day,
        FollowUp.scheduled_at <= end_of_day,
        FollowUp.status != "Cancelled"
    ).count()

    overdue_followups = db.query(FollowUp).filter(
        FollowUp.scheduled_at < start_of_day,
        FollowUp.status == "Pending"
    ).count()

    upcoming_meetups = db.query(FollowUp).filter(
        FollowUp.type.in_(["Meetup", "In-Person", "Demo"]),
        FollowUp.scheduled_at >= now,
        FollowUp.status == "Pending"
    ).count()

    high_priority = db.query(FollowUp).filter(
        FollowUp.priority == "High",
        FollowUp.status == "Pending"
    ).count()

    total_followups_count = db.query(FollowUp).count()

    return DashboardStats(
        total_clients=total_clients,
        total_leads=total_leads,
        total_accounts=total_accounts,
        total_prospects=total_prospects,
        overdue_followups_count=overdue_followups,
        conversion_rate=conversion_rate,
        today_followups_count=today_followups,
        upcoming_meetups_count=upcoming_meetups,
        high_priority_count=high_priority,
        total_pipeline_value=0.0,
        total_followups_count=total_followups_count,
        clients_with_positive_approach=positive_clients
    )

@router.get("/today", response_model=List[FollowUpWithClientInfo])
def get_today_schedule(db: Session = Depends(get_db)):
    now = datetime.utcnow()
    start_of_day = datetime.combine(now.date(), time.min)
    end_of_day = datetime.combine(now.date(), time.max)

    items = db.query(FollowUp).filter(
        FollowUp.scheduled_at >= start_of_day,
        FollowUp.scheduled_at <= end_of_day
    ).order_by(FollowUp.scheduled_at.asc()).all()

    result = []
    for f in items:
        f_info = FollowUpWithClientInfo.model_validate(f)
        if f.client:
            f_info.client_name = f.client.name
            f_info.client_company = f.client.company
            f_info.client_is_lead = f.client.is_lead
        result.append(f_info)

    return result
