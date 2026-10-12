from fastapi import APIRouter, Depends, HTTPException, Query, Header
from sqlalchemy.orm import Session
from sqlalchemy import or_, func
from typing import List, Optional
from datetime import datetime

from ..database import get_db
from ..models import Account, Client, NotificationItem
from ..schemas import AccountCreate, AccountUpdate, AccountResponse
from ..activity_logger import log_activity

router = APIRouter(prefix="/api/accounts", tags=["Accounts & Projects"])

@router.get("", response_model=List[AccountResponse])
def get_accounts(
    company: Optional[str] = Query(None),
    client_id: Optional[int] = Query(None),
    status: Optional[str] = Query(None),
    search: Optional[str] = Query(None),
    db: Session = Depends(get_db)
):
    query = db.query(Account)

    if company:
        query = query.filter(Account.company.ilike(f"%{company.strip()}%"))
    if client_id is not None:
        query = query.filter(Account.client_id == client_id)
    if status:
        query = query.filter(Account.status == status)
    if search:
        search_fmt = f"%{search.strip()}%"
        query = query.filter(
            or_(
                Account.account_name.ilike(search_fmt),
                Account.company.ilike(search_fmt),
                Account.project_name.ilike(search_fmt),
                Account.client_representative.ilike(search_fmt),
                Account.rep_email.ilike(search_fmt),
                Account.notes.ilike(search_fmt)
            )
        )

    return query.order_by(Account.updated_at.desc()).all()

@router.get("/stats")
def get_account_stats(db: Session = Depends(get_db)):
    """Aggregate statistics for Steel Detailing accounts and active projects"""
    accounts = db.query(Account).all()
    total_accounts = len(accounts)
    total_contract_value = sum(a.deal_value for a in accounts)
    unique_companies = len(set(a.company.lower() for a in accounts if a.company))
    active_projects = sum(1 for a in accounts if a.status in ["Active Project", "In Detailing", "Fabrication"])
    total_tonnage = sum(a.steel_tonnage or 0.0 for a in accounts)

    return {
        "total_accounts": total_accounts,
        "total_contract_value": total_contract_value,
        "unique_companies": unique_companies,
        "active_projects": active_projects,
        "total_tonnage": total_tonnage
    }

@router.post("", response_model=AccountResponse)
def create_account(
    account_in: AccountCreate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    account = Account(**account_in.model_dump())
    db.add(account)
    db.commit()
    db.refresh(account)

    # Activity log
    is_from_client = account.client_id is not None
    action_type = "CONVERT_LEAD_TO_ACCOUNT" if is_from_client else "CREATE_ACCOUNT"
    description = (
        f"Created Account '{account.account_name}' under company '{account.company}' "
        f"for project '{account.project_name}' (Rep: {account.client_representative}, Value: ${account.deal_value:,.2f})"
    )

    log_activity(
        db=db,
        action=action_type,
        entity_type="Account",
        entity_id=account.id,
        entity_name=f"{account.account_name} - {account.project_name}",
        description=description,
        changes={
            "company": account.company,
            "project_name": account.project_name,
            "client_representative": account.client_representative,
            "deal_value": account.deal_value,
            "status": account.status,
            "steel_tonnage": account.steel_tonnage
        },
        user_name=x_user_name,
        user_username=x_user_username
    )

    # Notify
    notif = NotificationItem(
        title=f"🏢 New Account / Project: {account.project_name}",
        message=f"Account '{account.account_name}' created for {account.company} with Rep {account.client_representative}.",
        type="account_created",
        client_id=account.client_id
    )
    db.add(notif)
    db.commit()

    return account

@router.get("/{account_id}", response_model=AccountResponse)
def get_account(account_id: int, db: Session = Depends(get_db)):
    account = db.query(Account).filter(Account.id == account_id).first()
    if not account:
        raise HTTPException(status_code=404, detail="Account not found")
    return account

@router.put("/{account_id}", response_model=AccountResponse)
def update_account(
    account_id: int,
    account_update: AccountUpdate,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    account = db.query(Account).filter(Account.id == account_id).first()
    if not account:
        raise HTTPException(status_code=404, detail="Account not found")

    update_data = account_update.model_dump(exclude_unset=True)
    diffs = {}
    for field, new_val in update_data.items():
        old_val = getattr(account, field, None)
        if str(old_val) != str(new_val):
            diffs[field] = {"old": old_val, "new": new_val}

    for field, val in update_data.items():
        setattr(account, field, val)

    account.updated_at = datetime.utcnow()
    db.commit()
    db.refresh(account)

    if diffs:
        log_activity(
            db=db,
            action="UPDATE_ACCOUNT",
            entity_type="Account",
            entity_id=account.id,
            entity_name=f"{account.account_name} ({account.company})",
            description=f"Updated Account '{account.account_name}': {list(diffs.keys())}",
            changes=diffs,
            user_name=x_user_name,
            user_username=x_user_username
        )

    return account

@router.delete("/{account_id}")
def delete_account(
    account_id: int,
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    account = db.query(Account).filter(Account.id == account_id).first()
    if not account:
        raise HTTPException(status_code=404, detail="Account not found")

    acc_name = account.account_name
    proj_name = account.project_name
    company = account.company

    db.delete(account)
    db.commit()

    log_activity(
        db=db,
        action="DELETE_ACCOUNT",
        entity_type="Account",
        entity_id=account_id,
        entity_name=f"{acc_name} ({company})",
        description=f"Deleted Account '{acc_name}' - Project '{proj_name}' ({company})",
        user_name=x_user_name,
        user_username=x_user_username
    )

    return {"message": "Account deleted successfully", "id": account_id}
