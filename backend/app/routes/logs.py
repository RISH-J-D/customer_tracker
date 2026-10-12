from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from sqlalchemy import or_
from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime
from ..database import get_db
from ..models import ActivityLog

router = APIRouter(prefix="/api/logs", tags=["Activity Logs"])

class LogResponse(BaseModel):
    id: int
    user_name: Optional[str] = "Admin"
    user_username: Optional[str] = "admin"
    action: str
    entity_type: str
    entity_id: Optional[int] = None
    entity_name: Optional[str] = None
    description: str
    changes: Optional[str] = None
    created_at: datetime

    class Config:
        from_attributes = True

@router.get("", response_model=List[LogResponse])
def get_activity_logs(
    limit: int = Query(100, ge=1, le=500),
    action: Optional[str] = Query(None),
    entity_type: Optional[str] = Query(None),
    user: Optional[str] = Query(None),
    search: Optional[str] = Query(None),
    db: Session = Depends(get_db)
):
    """
    Fetch all tracked modifications, status changes, follow-up events, and imports.
    """
    query = db.query(ActivityLog)

    if action:
        query = query.filter(ActivityLog.action == action)
    if entity_type:
        query = query.filter(ActivityLog.entity_type == entity_type)
    if user:
        query = query.filter(
            or_(
                ActivityLog.user_username.ilike(f"%{user}%"),
                ActivityLog.user_name.ilike(f"%{user}%")
            )
        )
    if search:
        search_fmt = f"%{search.strip()}%"
        query = query.filter(
            or_(
                ActivityLog.description.ilike(search_fmt),
                ActivityLog.entity_name.ilike(search_fmt),
                ActivityLog.action.ilike(search_fmt),
                ActivityLog.user_name.ilike(search_fmt)
            )
        )

    return query.order_by(ActivityLog.created_at.desc()).limit(limit).all()

@router.get("/stats")
def get_log_stats(db: Session = Depends(get_db)):
    """Summary counts for the logs tab"""
    total = db.query(ActivityLog).count()
    users_active = db.query(ActivityLog.user_name).distinct().count()
    recent = db.query(ActivityLog).order_by(ActivityLog.created_at.desc()).limit(5).all()
    
    return {
        "total_logs": total,
        "active_users_count": users_active,
        "recent_entries": [
            {
                "id": r.id,
                "user": r.user_name,
                "action": r.action,
                "description": r.description,
                "time": r.created_at.isoformat()
            } for r in recent
        ]
    }
