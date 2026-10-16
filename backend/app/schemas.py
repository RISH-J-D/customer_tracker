from pydantic import BaseModel, ConfigDict
from typing import Optional, List
from datetime import datetime

# --- FollowUp Schemas ---
class FollowUpBase(BaseModel):
    title: str
    type: str = "Meetup"
    scheduled_at: datetime
    priority: str = "Medium"
    status: str = "Pending"
    is_positive_result: bool = False
    notes: Optional[str] = None
    location: Optional[str] = None
    meeting_link: Optional[str] = None

class FollowUpCreate(FollowUpBase):
    client_id: int

class FollowUpUpdate(BaseModel):
    title: Optional[str] = None
    type: Optional[str] = None
    scheduled_at: Optional[datetime] = None
    priority: Optional[str] = None
    status: Optional[str] = None
    is_positive_result: Optional[bool] = None
    notes: Optional[str] = None
    location: Optional[str] = None
    meeting_link: Optional[str] = None

class FollowUpResponse(FollowUpBase):
    id: int
    client_id: int
    reminder_sent: bool
    completed_at: Optional[datetime] = None
    created_at: datetime
    updated_at: datetime
    model_config = ConfigDict(from_attributes=True)

# --- Client Note Schemas ---
class ClientNoteCreate(BaseModel):
    content: str

class ClientNoteResponse(BaseModel):
    id: int
    client_id: int
    content: str
    author: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    model_config = ConfigDict(from_attributes=True)

# --- Client Schemas ---
class ClientBase(BaseModel):
    name: str
    company: Optional[str] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    company_email: Optional[str] = None
    company_phone: Optional[str] = None
    category: str = "Steel Detailing"
    status: str = "Prospect"
    is_lead: bool = False
    positive_approach: bool = False
    deal_value: float = 0.0
    position: Optional[str] = None
    city: Optional[str] = None
    state: Optional[str] = None
    country: Optional[str] = None
    notes: Optional[str] = None

class ClientCreate(ClientBase):
    pass

class ClientUpdate(BaseModel):
    name: Optional[str] = None
    company: Optional[str] = None
    email: Optional[str] = None
    phone: Optional[str] = None
    company_email: Optional[str] = None
    company_phone: Optional[str] = None
    category: Optional[str] = None
    status: Optional[str] = None
    is_lead: Optional[bool] = None
    positive_approach: Optional[bool] = None
    deal_value: Optional[float] = None
    position: Optional[str] = None
    city: Optional[str] = None
    state: Optional[str] = None
    country: Optional[str] = None
    notes: Optional[str] = None

class ClientResponse(ClientBase):
    id: int
    lead_converted_at: Optional[datetime] = None
    account_converted_at: Optional[datetime] = None
    marked_negative_at: Optional[datetime] = None
    prospect_marked_at: Optional[datetime] = None
    created_at: datetime
    updated_at: datetime
    model_config = ConfigDict(from_attributes=True)

class FollowUpWithClientInfo(FollowUpResponse):
    client_name: Optional[str] = None
    client_company: Optional[str] = None
    client_is_lead: Optional[bool] = False

class FollowUpLog(BaseModel):
    """'I followed up': what was discussed today, and when to follow up next"""
    note: Optional[str] = None
    next_followup_at: Optional[datetime] = None

class ClientWithDetails(ClientResponse):
    followups: List[FollowUpResponse] = []
    note_entries: List[ClientNoteResponse] = []
    total_followups: int = 0
    pending_followups: int = 0
    model_config = ConfigDict(from_attributes=True)

# --- Notification Schemas ---
class NotificationResponse(BaseModel):
    id: int
    title: str
    message: str
    type: str
    client_id: Optional[int] = None
    followup_id: Optional[int] = None
    is_read: bool
    created_at: datetime
    model_config = ConfigDict(from_attributes=True)

# --- Dashboard & Stats Schemas ---
class DashboardStats(BaseModel):
    total_clients: int
    total_leads: int
    total_accounts: int = 0
    total_prospects: int = 0
    overdue_followups_count: int = 0
    conversion_rate: float
    today_followups_count: int
    upcoming_meetups_count: int
    high_priority_count: int
    total_pipeline_value: float = 0.0
    total_followups_count: int = 0
    clients_with_positive_approach: int

# --- Account Schemas ---
class AccountBase(BaseModel):
    account_name: str
    company: str
    project_name: str
    client_representative: str
    rep_first_name: Optional[str] = None
    rep_last_name: Optional[str] = None
    rep_email: Optional[str] = None
    rep_phone: Optional[str] = None
    rep_designation: Optional[str] = None
    deal_value: float = 0.0
    steel_tonnage: Optional[float] = None
    status: str = "Active Project"
    city: Optional[str] = None
    state: Optional[str] = None
    country: Optional[str] = None
    notes: Optional[str] = None
    client_id: Optional[int] = None

class AccountCreate(AccountBase):
    pass

class AccountUpdate(BaseModel):
    account_name: Optional[str] = None
    company: Optional[str] = None
    project_name: Optional[str] = None
    client_representative: Optional[str] = None
    rep_first_name: Optional[str] = None
    rep_last_name: Optional[str] = None
    rep_email: Optional[str] = None
    rep_phone: Optional[str] = None
    rep_designation: Optional[str] = None
    deal_value: Optional[float] = None
    steel_tonnage: Optional[float] = None
    status: Optional[str] = None
    city: Optional[str] = None
    state: Optional[str] = None
    country: Optional[str] = None
    notes: Optional[str] = None
    client_id: Optional[int] = None

class AccountResponse(AccountBase):
    id: int
    created_at: datetime
    updated_at: datetime
    model_config = ConfigDict(from_attributes=True)

