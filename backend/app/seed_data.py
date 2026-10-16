from datetime import datetime
from sqlalchemy.orm import Session

def seed_users(db: Session):
    from .models import User

    users_data = [
        {"username": "abarna.s", "password": "abarna@2026", "name": "Abarna S", "role": "Steel Detailing Executive"},
        {"username": "girish.j", "password": "girish@2026", "name": "Girish J", "role": "Steel Detailing Executive"},
        {"username": "admin", "password": "admin@123", "name": "Admin", "role": "System Administrator"},
    ]

    for u in users_data:
        existing = db.query(User).filter(User.username == u["username"]).first()
        if not existing:
            db.add(User(
                username=u["username"],
                password=u["password"],
                name=u["name"],
                role=u["role"],
                created_at=datetime.utcnow()
            ))
        else:
            existing.password = u["password"]
            existing.name = u["name"]
            existing.role = u["role"]
    db.commit()
