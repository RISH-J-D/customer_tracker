import os
import sys
import openpyxl
from datetime import datetime, timedelta
import random

# Add backend directory to sys.path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app.database import SessionLocal, engine
from app.models import Client, Account, FollowUp, ActivityLog
from sqlalchemy import text

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

    # Pre-fetch existing client companies to avoid duplicate duplicates if desired
    existing_companies = set(r[0] for r in db.query(Client.company).all() if r[0])
    print(f"Existing client companies in DB: {len(existing_companies)}")

    inserted_clients = 0
    inserted_accounts = 0

    # Seed random for repeatable values
    random.seed(42)

    clients_to_add = []
    
    # Process rows
    for i, row in enumerate(data_rows, 1):
        acc_name = str(row[col_acc]).strip() if row[col_acc] else f"Company #{i}"
        contact = str(row[col_contact]).strip() if row[col_contact] else ""
        position = str(row[col_pos]).strip() if row[col_pos] else ""
        phone = str(row[col_phone]).strip() if row[col_phone] else None
        email = str(row[col_email]).strip() if row[col_email] else None
        country = str(row[col_country]).strip() if row[col_country] else ""
        state = str(row[col_state]).strip() if row[col_state] else ""
        city = str(row[col_city]).strip() if row[col_city] else ""
        raw_status = str(row[col_status]).strip() if row[col_status] else "Prospect"

        # Determine Representative Name
        rep_full_name = contact if contact else f"{acc_name} Contact"
        name_parts = rep_full_name.split()
        first_name = name_parts[0] if name_parts else "Representative"
        last_name = " ".join(name_parts[1:]) if len(name_parts) > 1 else ""

        # Location text
        loc_parts = [p for p in [city, state, country] if p]
        location_str = ", ".join(loc_parts) if loc_parts else "United States"

        # Map status
        is_lead = raw_status in ['Accepted', 'Lead', 'New Lead', 'Active']
        positive_approach = raw_status in ['Accepted', 'Lead', 'Active']

        if raw_status in ['Accepted', 'Active']:
            acc_status = 'Active Project'
            deal_val = float(random.randint(45, 95) * 1000)
            tonnage = float(random.randint(280, 580))
        elif raw_status in ['Lead', 'New Lead']:
            acc_status = 'In Detailing'
            deal_val = float(random.randint(30, 70) * 1000)
            tonnage = float(random.randint(180, 420))
        elif raw_status == 'FollowUp':
            acc_status = 'Fabrication Review'
            deal_val = float(random.randint(20, 45) * 1000)
            tonnage = float(random.randint(120, 260))
        elif raw_status == 'Completed':
            acc_status = 'Completed'
            deal_val = float(random.randint(35, 60) * 1000)
            tonnage = float(random.randint(200, 350))
        else: # Voicemail, No Need
            acc_status = 'On Hold'
            deal_val = 0.0
            tonnage = 0.0

        client_status = 'Lead' if is_lead else ('FollowUp' if raw_status == 'FollowUp' else 'Prospect')

        # Notes
        notes = f"Location: {location_str}"
        if position:
            notes += f" | Position: {position}"
        notes += f" | Original CRM Status: {raw_status}"

        # 1. Create Client
        client = Client(
            name=rep_full_name[:245],
            company=acc_name[:245],
            email=email[:245] if email else None,
            phone=phone[:245] if phone else None,
            category="Steel Detailing",
            status=client_status,
            is_lead=is_lead,
            positive_approach=positive_approach,
            deal_value=deal_val,
            notes=notes,
            created_at=datetime.utcnow() - timedelta(days=random.randint(1, 90))
        )
        db.add(client)
        db.flush() # assign client.id
        inserted_clients += 1

        # Project name
        pos_title = position if position else "Structural"
        project_name = f"{acc_name} {pos_title} Detailing Package"[:245]
        account_title = f"{acc_name} - Steel Detailing Project"[:245]

        # 2. Create Account
        account = Account(
            client_id=client.id,
            account_name=account_title,
            company=acc_name[:245],
            project_name=project_name,
            client_representative=rep_full_name[:245],
            rep_first_name=first_name[:115],
            rep_last_name=last_name[:115],
            rep_email=email[:245] if email else None,
            rep_phone=phone[:245] if phone else None,
            rep_designation=position[:245] if position else "Client Representative",
            deal_value=deal_val,
            steel_tonnage=tonnage if tonnage > 0 else None,
            status=acc_status,
            notes=f"Scope: Connection design & 3D Tekla modeling. {notes}",
            created_at=client.created_at,
            updated_at=datetime.utcnow()
        )
        db.add(account)
        inserted_accounts += 1

        if i % 250 == 0:
            db.commit()
            print(f"Committed {i}/{len(data_rows)} records...")

    db.commit()
    print(f"\nSUCCESS! Loaded {inserted_clients} clients and {inserted_accounts} accounts into PostgreSQL tracker_db.")

    # Record Activity Log for the bulk import
    log = ActivityLog(
        user_name="Admin",
        user_username="admin",
        action="IMPORT_EXCEL",
        entity_type="Account",
        entity_name="Accounts_Export.xlsx",
        description=f"Imported {inserted_accounts} accounts and corporate clients from Accounts_Export.xlsx",
        changes=f'{{"total_rows": {len(data_rows)}, "imported_accounts": {inserted_accounts}, "imported_clients": {inserted_clients}}}',
        created_at=datetime.utcnow()
    )
    db.add(log)
    db.commit()
    db.close()

if __name__ == "__main__":
    file_path = "/home/rish/pROJECTS/tracker/Accounts_Export.xlsx"
    load_accounts_from_excel(file_path)
