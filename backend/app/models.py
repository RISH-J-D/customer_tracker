from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, ForeignKey, Float
from sqlalchemy.orm import relationship
from datetime import datetime
from .database import Base

class Client(Base):
    __tablename__ = "clients"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(120), nullable=False, index=True)
    company = Column(String(120), nullable=True, index=True)
    email = Column(String(120), nullable=True)
    phone = Column(String(50), nullable=True)
    category = Column(String(50), default="Steel Detailing")
    status = Column(String(50), default="Prospect", index=True)
    is_lead = Column(Boolean, default=False, index=True)
    positive_approach = Column(Boolean, default=False, index=True)
    lead_converted_at = Column(DateTime, nullable=True)
    deal_value = Column(Float, default=0.0)
    notes = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    followups = relationship("FollowUp", back_populates="client", cascade="all, delete-orphan", order_by="desc(FollowUp.scheduled_at)")
    accounts = relationship("Account", back_populates="client", cascade="all, delete-orphan", order_by="desc(Account.created_at)")

class FollowUp(Base):
    __tablename__ = "followups"

    id = Column(Integer, primary_key=True, index=True)
    client_id = Column(Integer, ForeignKey("clients.id", ondelete="CASCADE"), nullable=False, index=True)
    title = Column(String(200), nullable=False)
    type = Column(String(50), default="Meetup", index=True) # Meetup, Call, Email, Demo, In-Person
    scheduled_at = Column(DateTime, nullable=False, index=True)
    priority = Column(String(20), default="Medium") # High, Medium, Low
    status = Column(String(30), default="Pending", index=True) # Pending, Completed, Rescheduled, Cancelled
    is_positive_result = Column(Boolean, default=False)
    notes = Column(Text, nullable=True)
    location = Column(String(200), nullable=True)
    meeting_link = Column(String(255), nullable=True)
    reminder_sent = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationship
    client = relationship("Client", back_populates="followups")

class NotificationItem(Base):
    __tablename__ = "notifications"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(150), nullable=False)
    message = Column(Text, nullable=False)
    type = Column(String(50), default="today_followup") # today_followup, meetup_reminder, lead_promoted, overdue_alert
    client_id = Column(Integer, ForeignKey("clients.id", ondelete="SET NULL"), nullable=True)
    followup_id = Column(Integer, ForeignKey("followups.id", ondelete="SET NULL"), nullable=True)
    is_read = Column(Boolean, default=False, index=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(60), unique=True, nullable=False, index=True)
    name = Column(String(100), nullable=False)
    password = Column(String(200), nullable=False)
    role = Column(String(50), default="Steel Detailing Executive")
    avatar = Column(String(200), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

class ActivityLog(Base):
    __tablename__ = "activity_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_name = Column(String(100), nullable=True, default="Admin")
    user_username = Column(String(60), nullable=True, default="admin")
    action = Column(String(50), nullable=False, index=True)  # CREATE, UPDATE, DELETE, CONVERT_LEAD, REVERT_CLIENT, COMPLETE_FOLLOWUP, SCHEDULE_FOLLOWUP, IMPORT_EXCEL, LOGIN
    entity_type = Column(String(50), nullable=False, index=True)  # Client, Lead, FollowUp, Excel, User, Auth, Account
    entity_id = Column(Integer, nullable=True)
    entity_name = Column(String(200), nullable=True)
    description = Column(Text, nullable=False)
    changes = Column(Text, nullable=True)  # JSON formatted diff or details
    created_at = Column(DateTime, default=datetime.utcnow, index=True)

class Account(Base):
    __tablename__ = "accounts"

    id = Column(Integer, primary_key=True, index=True)
    client_id = Column(Integer, ForeignKey("clients.id", ondelete="SET NULL"), nullable=True, index=True)
    account_name = Column(String(160), nullable=False, index=True)
    company = Column(String(140), nullable=False, index=True)
    project_name = Column(String(200), nullable=False, index=True)
    client_representative = Column(String(120), nullable=False)
    rep_first_name = Column(String(60), nullable=True)
    rep_last_name = Column(String(60), nullable=True)
    rep_email = Column(String(120), nullable=True)
    rep_phone = Column(String(50), nullable=True)
    rep_designation = Column(String(100), nullable=True)
    deal_value = Column(Float, default=0.0)
    steel_tonnage = Column(Float, nullable=True)
    status = Column(String(50), default="Active Project", index=True) # Active Project, In Detailing, Review / Approval, Fabrication, Completed, On Hold
    notes = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationship
    client = relationship("Client", back_populates="accounts")


