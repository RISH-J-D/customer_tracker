import os
import sys
import openpyxl
from datetime import datetime, timedelta
import random

# Add backend directory to sys.path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app.database import SessionLocal, engine
from app.models import Client, Account, FollowUp, NotificationItem, ActivityLog
from sqlalchemy import text

def clean_str(val):
    if val is None:
        return None
    s = str(val).strip()
    return s if s and s.lower() != 'nan' else None

def load_accounts_from_excel(file_path: str):
    print(f"Loading data from {file_path}...")
    wb = openpyxl.load_workbook(file_path, read_only=True)
    ws = wb['Accounts']
    rows = list(ws.iter_rows(values_only=True))
    headers = [str(h).strip() if h else "" for h in rows[0]]
    data_rows = rows[1:]

    print(f"Found {len(data_rows)} rows in sheet 'Accounts'")
    print(f"Headers: {headers}")

    col_acc = headers.index('Account Name')
    col_contact = headers.index('Contact Person')
    col_pos = headers.index('Position')
    col_phone = headers.index('Phone')
    col_email = headers.index('Email')
    col_country = headers.index('Country')
    col_state = headers.index('State')
    col_city = headers.index('City')
    col_status = headers.index('Status')

    db = SessionLocal()

    # 1. Reset deal_value on any seed clients where is_lead=False to 0.0
    db.execute(text("UPDATE clients SET deal_value = 0.0 WHERE is_lead = False;"))
    db.commit()

    # 2. Clear previous batch import (clients with id > 7 and accounts with id > 7)
    print("Clearing previous bulk import from database...")
    db.execute(text("DELETE FROM accounts WHERE id > 7;"))
    db.execute(text("DELETE FROM clients WHERE id > 7;"))
    db.commit()

    print(f"Existing base clients preserved: {db.query(Client).count()}")
    print(f"Existing base accounts preserved: {db.query(Account).count()}")

    random.seed(42)

    inserted_clients = 0
    inserted_leads = 0
    inserted_prospects = 0
    inserted_accounts = 0

    total_pipeline_val = 0.0
    total_active_val = 0.0

    for i, row in enumerate(data_rows, 1):
        acc_name = clean_str(row[col_acc]) or f"Fabricator #{i}"
        contact = clean_str(row[col_contact])
        position = clean_str(row[col_pos])
        phone = clean_str(row[col_phone])
        email = clean_str(row[col_email])
        country = clean_str(row[col_country])
        state = clean_str(row[col_state])
        city = clean_str(row[col_city])
        raw_status = clean_str(row[col_status]) or "Prospect"

        # Representative Name Parsing
        if contact:
            rep_full_name = contact
            parts = contact.split()
            first_name = parts[0]
            last_name = " ".join(parts[1:]) if len(parts) > 1 else ""
        else:
            rep_full_name = f"{acc_name} Contact"
            parts = acc_name.split()
            first_name = parts[0] if parts else "Representative"
            last_name = "Principal"

        # Location details
        loc_parts = [p for p in [city, state, country] if p]
        location_str = ", ".join(loc_parts) if loc_parts else "USA"

        # Notes summary
        notes_parts = []
        if position:
            notes_parts.append(f"Position: {position}")
        if location_str:
            notes_parts.append(f"Location: {location_str}")
        notes_parts.append(f"Original CRM Status: {raw_status}")
        notes = " | ".join(notes_parts)

        # Categorize into Leads vs Clients
        if raw_status in ['Accepted', 'Active']:
            # Converted / Accepted Lead & Corporate Account
            is_lead = True
            positive_approach = True
            client_status = raw_status
            deal_val = float(random.randint(45, 95) * 1000)
            tonnage = float(random.randint(280, 580))
            is_account = True
            acc_status = 'Active Project'
        elif raw_status in ['Lead', 'New Lead']:
            # Active Qualified Lead in Detailing Pipeline
            is_lead = True
            positive_approach = True
            client_status = raw_status
            deal_val = float(random.randint(25, 65) * 1000)
            tonnage = float(random.randint(180, 420))
            is_account = False
            acc_status = None
        else:
            # Outreach Client / Cold Prospect (FollowUp, No Need, Voicemail)
            # CRITICAL USER RULE: Estimated value is ONLY added for leads, NOT for clients!
            is_lead = False
            positive_approach = False
            client_status = raw_status
            deal_val = 0.0  # Zero estimated value for clients!
            tonnage = 0.0
            is_account = False
            acc_status = None

        # 1. Insert Client
        client = Client(
            name=rep_full_name,
            company=acc_name,
            email=email,
            phone=phone,
            category="Steel Detailing",
            status=client_status,
            is_lead=is_lead,
            positive_approach=positive_approach,
            deal_value=deal_val,
            position=position,
            city=city,
            state=state,
            country=country,
            notes=notes,
            lead_converted_at=datetime.utcnow() - timedelta(days=random.randint(1, 45)) if is_lead else None,
            created_at=datetime.utcnow() - timedelta(days=random.randint(15, 120))
        )
        db.add(client)
        db.flush()
        inserted_clients += 1

        if is_lead:
            inserted_leads += 1
            total_pipeline_val += deal_val
        else:
            inserted_prospects += 1

        # 2. Insert Account (Only for Accepted and Active converted accounts)
        if is_account:
            pos_title = position if position else "Structural"
            project_name = f"{acc_name} {pos_title} Detailing Package"
            account_title = f"{acc_name} - Steel Detailing Project"

            account = Account(
                client_id=client.id,
                account_name=account_title,
                company=acc_name,
                project_name=project_name,
                client_representative=rep_full_name,
                rep_first_name=first_name,
                rep_last_name=last_name,
                rep_email=email,
                rep_phone=phone,
                rep_designation=position or "Project Manager",
                deal_value=deal_val,
                steel_tonnage=tonnage,
                status=acc_status,
                city=city,
                state=state,
                country=country,
                notes=f"Scope: Connection design & 3D Tekla modeling. {notes}",
                created_at=client.created_at,
                updated_at=datetime.utcnow()
            )
            db.add(account)
            inserted_accounts += 1
            total_active_val += deal_val

        if i % 250 == 0:
            db.commit()
            print(f"Processed {i}/{len(data_rows)} rows...")

    db.commit()

    print("\n" + "="*60)
    print("DATA LOADING & ANALYSIS COMPLETE:")
    print(f"Total Rows Processed: {len(data_rows)}")
    print(f"Total Clients in Database: {db.query(Client).count()}")
    print(f"  - Non-lead Clients (deal_value = $0.0): {db.query(Client).filter(Client.is_lead == False).count()}")
    print(f"  - Qualified Leads (deal_value > $0.0): {db.query(Client).filter(Client.is_lead == True).count()}")
    print(f"Total Accounts in Database: {db.query(Account).count()}")
    print(f"Total Leads Pipeline Value: ${total_pipeline_val:,.2f}")
    print(f"Total Active Accounts Contract Value: ${total_active_val:,.2f}")
    print("="*60)

    # Activity log
    log = ActivityLog(
        user_name="Admin",
        user_username="admin",
        action="IMPORT_EXCEL",
        entity_type="Client",
        entity_name="Accounts_Export.xlsx",
        description=f"Loaded {inserted_clients} records: {inserted_leads} leads (with est. value), {inserted_prospects} clients ($0 est. value), and {inserted_accounts} converted accounts.",
        changes=f'{{"total_rows": {len(data_rows)}, "leads": {inserted_leads}, "clients": {inserted_prospects}, "accounts": {inserted_accounts}}}',
        created_at=datetime.utcnow()
    )
    db.add(log)
    db.commit()
    db.close()

if __name__ == "__main__":
    file_path = "/home/rish/pROJECTS/tracker/Accounts_Export.xlsx"
    load_accounts_from_excel(file_path)
