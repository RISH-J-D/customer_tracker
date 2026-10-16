"""One-time replacement of all tracker data with the leads in data/Client_Details.xlsx.

Runs at startup (see main.py). The AppMeta key below records that the import has been applied,
so later restarts never wipe data entered through the app. To re-run it, delete that app_meta row.
"""
import os
from datetime import datetime

import openpyxl
from sqlalchemy import text

from .database import IS_POSTGRES
from .models import AppMeta, ActivityLog, Client

# Bump the version to wipe and reload again
IMPORT_KEY = "client_details_import_v2"
DATA_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "data", "Client_Details.xlsx")

# Child tables first so the SQLite DELETE path doesn't trip foreign keys
WIPE_TABLES = ["notifications", "followups", "client_notes", "accounts", "clients", "activity_logs"]


def clean(val):
    if val is None:
        return None
    s = str(val).strip()
    return s if s and s.lower() not in ("nan", "none", "null") else None


def parse_date(val):
    s = clean(val)
    if not s:
        return None
    # e.g. '2022-09-20 20:06:17+00' — stored as naive UTC like the rest of the app
    s = s.replace("+00", "")
    try:
        return datetime.strptime(s[:19], "%Y-%m-%d %H:%M:%S")
    except ValueError:
        return None


def read_sheet(wb, name):
    rows = list(wb[name].iter_rows(values_only=True))
    headers = [str(h).strip() if h else "" for h in rows[0]]
    return [dict(zip(headers, r)) for r in rows[1:] if any(v is not None for v in r)]


def lead_row(**fields):
    created = fields.pop("created_at", None) or datetime.utcnow()
    return {
        "category": "Steel Detailing",
        "status": "Lead",
        "is_lead": True,
        "positive_approach": False,
        "deal_value": 0.0,
        "notes": None,
        "lead_converted_at": created,
        "created_at": created,
        "updated_at": created,
        **fields,
    }


def crm_client_to_lead(r):
    company = clean(r.get("Company Name"))
    contact = clean(r.get("Contact Person 1 Name"))
    return lead_row(
        name=contact or company or "Unknown",
        company=company,
        position=clean(r.get("Contact Person 1 Position")),
        email=clean(r.get("Contact Person 1 Email")),
        phone=clean(r.get("Contact Person 1 Mobile")),
        company_email=clean(r.get("Email")),
        company_phone=clean(r.get("Phone")) or clean(r.get("Mobile")),
        city=clean(r.get("City")),
        state=clean(r.get("State")),
        country=clean(r.get("Country")),
        created_at=parse_date(r.get("Created Date")),
    )


def account_client_to_lead(r):
    company = clean(r.get("Company Full Name"))
    contact = clean(r.get("Contact Name"))
    return lead_row(
        name=contact or company or "Unknown",
        company=company,
        # "Primary Contact" holds the contact's designation in this sheet
        position=clean(r.get("Primary Contact")),
        email=None,
        phone=None,
        company_email=None,
        company_phone=clean(r.get("Telephone")),
        city=clean(r.get("City")),
        state=clean(r.get("State")),
        country=clean(r.get("Country")),
        created_at=parse_date(r.get("Updated Time")),
    )


def ensure_client_details_imported(db):
    if db.get(AppMeta, IMPORT_KEY) or not os.path.exists(DATA_FILE):
        return

    wb = openpyxl.load_workbook(DATA_FILE, read_only=True)
    leads = [crm_client_to_lead(r) for r in read_sheet(wb, "CRM Clients")]
    leads += [account_client_to_lead(r) for r in read_sheet(wb, "Accounts Client Management")]
    wb.close()

    if IS_POSTGRES:
        db.execute(text(f"TRUNCATE {', '.join(WIPE_TABLES)} RESTART IDENTITY CASCADE"))
    else:
        for table in WIPE_TABLES:
            db.execute(text(f"DELETE FROM {table}"))

    db.execute(Client.__table__.insert(), leads)
    db.add(ActivityLog(
        user_name="Admin",
        user_username="admin",
        action="IMPORT_EXCEL",
        entity_type="Lead",
        entity_name="Client_Details.xlsx",
        description=f"Replaced all data with {len(leads)} leads from Client_Details.xlsx",
    ))
    db.add(AppMeta(key=IMPORT_KEY, value=f"{len(leads)} leads"))
    db.commit()
    print(f"Imported {len(leads)} leads from Client_Details.xlsx (all previous data removed)")
