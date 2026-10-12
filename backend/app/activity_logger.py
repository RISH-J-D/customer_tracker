import json
from datetime import datetime
from typing import Optional, Dict, Any
from sqlalchemy.orm import Session
from .models import ActivityLog

def log_activity(
    db: Session,
    action: str,
    entity_type: str,
    description: str,
    entity_id: Optional[int] = None,
    entity_name: Optional[str] = None,
    changes: Optional[Dict[str, Any]] = None,
    user_name: Optional[str] = None,
    user_username: Optional[str] = None
):
    """
    Record an audit/activity log entry in PostgreSQL / SQLite.
    All changes (small or large) get stored permanently.
    """
    try:
        changes_json = json.dumps(changes, default=str) if changes else None
        
        # Default user attribution
        uname = user_name or "Admin"
        uuser = user_username or "admin"

        log_item = ActivityLog(
            user_name=uname,
            user_username=uuser,
            action=action,
            entity_type=entity_type,
            entity_id=entity_id,
            entity_name=entity_name,
            description=description,
            changes=changes_json,
            created_at=datetime.utcnow()
        )
        db.add(log_item)
        db.commit()
        db.refresh(log_item)
        return log_item
    except Exception as e:
        print(f"Warning: Failed to record activity log: {e}")
        try:
            db.rollback()
        except:
            pass
        return None
