from fastapi import APIRouter, Depends, HTTPException, Header
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime
from ..database import get_db
from ..models import User
from ..activity_logger import log_activity

router = APIRouter(prefix="/api/auth", tags=["Authentication & Users"])

class LoginRequest(BaseModel):
    username: str
    password: str

class UserResponse(BaseModel):
    id: int
    username: str
    name: str
    role: str
    avatar: Optional[str] = None
    created_at: Optional[datetime] = None

    class Config:
        from_attributes = True

@router.post("/login")
def login(creds: LoginRequest, db: Session = Depends(get_db)):
    clean_username = creds.username.strip().lower()
    clean_password = creds.password.strip()

    # Search user by username or email prefix
    user = db.query(User).filter(
        (User.username.ilike(clean_username)) | 
        (User.username == clean_username.split('@')[0])
    ).first()

    if not user or user.password != clean_password:
        # Also log failed attempt
        log_activity(
            db=db,
            action="LOGIN_FAILED",
            entity_type="Auth",
            description=f"Failed login attempt for username '{clean_username}'",
            user_name="Guest",
            user_username=clean_username
        )
        raise HTTPException(status_code=401, detail="Invalid username or password")

    # Log successful login
    log_activity(
        db=db,
        action="LOGIN",
        entity_type="Auth",
        description=f"User {user.name} ({user.username}) logged in to ClientFlow",
        entity_id=user.id,
        entity_name=user.name,
        user_name=user.name,
        user_username=user.username
    )

    return {
        "status": "success",
        "user": {
            "id": user.id,
            "username": user.username,
            "name": user.name,
            "role": user.role,
            "avatar": user.avatar
        }
    }

@router.get("/users", response_model=List[UserResponse])
def get_all_users(db: Session = Depends(get_db)):
    return db.query(User).order_by(User.id.asc()).all()

@router.get("/me")
def get_current_user(
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    if not x_user_username:
        # Default to admin
        x_user_username = "admin"
    
    user = db.query(User).filter(User.username.ilike(x_user_username.strip())).first()
    if not user:
        user = db.query(User).filter(User.username == "admin").first()
    
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
        
    return {
        "id": user.id,
        "username": user.username,
        "name": user.name,
        "role": user.role,
        "avatar": user.avatar
    }
