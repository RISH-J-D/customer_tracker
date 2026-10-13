#!/usr/bin/env python3
"""
migrate_to_render.py
--------------------
Self-contained migration: exports local SQLite → Render PostgreSQL.
Creates all tables from scratch using raw SQL (no backend imports needed).

Usage:
    RENDER_DB_URL="postgresql://..." python3 migrate_to_render.py
"""

import sqlite3
import os
import sys

def get_pg_url():
    url = os.getenv("RENDER_DB_URL", "").strip()
    if not url:
        print("ERROR: Set the RENDER_DB_URL environment variable.")
        sys.exit(1)
    return url.replace("postgres://", "postgresql://", 1) if url.startswith("postgres://") else url

CREATE_TABLES_SQL = """
CREATE TABLE IF NOT EXISTS clients (
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(255) NOT NULL,
    company             VARCHAR(255),
    email               VARCHAR(255),
    phone               VARCHAR(255),
    category            VARCHAR(50)  DEFAULT 'Steel Detailing',
    status              VARCHAR(50)  DEFAULT 'Prospect',
    is_lead             BOOLEAN      DEFAULT FALSE,
    positive_approach   BOOLEAN      DEFAULT FALSE,
    lead_converted_at   TIMESTAMP,
    deal_value          FLOAT        DEFAULT 0.0,
    position            TEXT,
    city                TEXT,
    state               TEXT,
    country             TEXT,
    notes               TEXT,
    created_at          TIMESTAMP    DEFAULT NOW(),
    updated_at          TIMESTAMP    DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS followups (
    id                  SERIAL PRIMARY KEY,
    client_id           INTEGER REFERENCES clients(id) ON DELETE CASCADE,
    title               VARCHAR(200) NOT NULL,
    type                VARCHAR(50)  DEFAULT 'Meetup',
    scheduled_at        TIMESTAMP    NOT NULL,
    priority            VARCHAR(20)  DEFAULT 'Medium',
    status              VARCHAR(30)  DEFAULT 'Pending',
    is_positive_result  BOOLEAN      DEFAULT FALSE,
    notes               TEXT,
    location            VARCHAR(200),
    meeting_link        VARCHAR(255),
    reminder_sent       BOOLEAN      DEFAULT FALSE,
    created_at          TIMESTAMP    DEFAULT NOW(),
    updated_at          TIMESTAMP    DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS notifications (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(150) NOT NULL,
    message     TEXT NOT NULL,
    type        VARCHAR(50)  DEFAULT 'today_followup',
    client_id   INTEGER REFERENCES clients(id) ON DELETE SET NULL,
    followup_id INTEGER REFERENCES followups(id) ON DELETE SET NULL,
    is_read     BOOLEAN      DEFAULT FALSE,
    created_at  TIMESTAMP    DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS users (
    id          SERIAL PRIMARY KEY,
    username    VARCHAR(60)  UNIQUE NOT NULL,
    name        VARCHAR(100) NOT NULL,
    password    VARCHAR(200) NOT NULL,
    role        VARCHAR(50)  DEFAULT 'Steel Detailing Executive',
    avatar      VARCHAR(200),
    created_at  TIMESTAMP    DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS activity_logs (
    id              SERIAL PRIMARY KEY,
    user_name       VARCHAR(100) DEFAULT 'Admin',
    user_username   VARCHAR(60)  DEFAULT 'admin',
    action          VARCHAR(50)  NOT NULL,
    entity_type     VARCHAR(50)  NOT NULL,
    entity_id       INTEGER,
    entity_name     VARCHAR(200),
    description     TEXT         NOT NULL,
    changes         TEXT,
    created_at      TIMESTAMP    DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS accounts (
    id                    SERIAL PRIMARY KEY,
    client_id             INTEGER REFERENCES clients(id) ON DELETE SET NULL,
    account_name          VARCHAR(255) NOT NULL,
    company               VARCHAR(255) NOT NULL,
    project_name          VARCHAR(255) NOT NULL,
    client_representative VARCHAR(255) NOT NULL,
    rep_first_name        VARCHAR(120),
    rep_last_name         VARCHAR(120),
    rep_email             VARCHAR(160),
    rep_phone             VARCHAR(255),
    rep_designation       VARCHAR(255),
    deal_value            FLOAT        DEFAULT 0.0,
    steel_tonnage         FLOAT,
    status                VARCHAR(60)  DEFAULT 'Active Project',
    city                  TEXT,
    state                 TEXT,
    country               TEXT,
    notes                 TEXT,
    created_at            TIMESTAMP    DEFAULT NOW(),
    updated_at            TIMESTAMP    DEFAULT NOW()
);
"""

def main():
    pg_url = get_pg_url()

    try:
        import psycopg2
    except ImportError:
        print("psycopg2 not found. Install it in your venv: pip install psycopg2-binary")
        sys.exit(1)

    sqlite_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "backend", "app", "tracker.db")
    if not os.path.exists(sqlite_path):
        print(f"ERROR: SQLite DB not found at {sqlite_path}")
        sys.exit(1)

    print(f"📂 SQLite source: {sqlite_path}")
    sq = sqlite3.connect(sqlite_path)
    sq.row_factory = sqlite3.Row

    print(f"🔌 Connecting to Render PostgreSQL...")
    pg = psycopg2.connect(pg_url)
    pg.autocommit = False
    cur = pg.cursor()
    print("   ✓ Connected!\n")

    # Create all tables
    print("🏗  Creating tables...")
    cur.execute(CREATE_TABLES_SQL)
    pg.commit()
    print("   ✓ Tables ready\n")

    # Clear existing data in FK-safe order
    print("🗑  Clearing existing data...")
    for tbl in ["notifications", "followups", "activity_logs", "accounts", "clients", "users"]:
        cur.execute(f"DELETE FROM {tbl}")
    pg.commit()
    print("   ✓ Cleared\n")

    # ----------------------------------------------------------------- clients
    clients = sq.execute("SELECT * FROM clients").fetchall()
    print(f"👥 Migrating {len(clients)} clients...")
    for r in clients:
        cur.execute("""
            INSERT INTO clients
              (id, name, company, email, phone, category, status, is_lead,
               positive_approach, lead_converted_at, deal_value, notes,
               created_at, updated_at)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """, (
            r["id"], r["name"], r["company"], r["email"], r["phone"],
            r["category"], r["status"], bool(r["is_lead"]),
            bool(r["positive_approach"]), r["lead_converted_at"],
            r["deal_value"], r["notes"], r["created_at"], r["updated_at"]
        ))
    cur.execute("SELECT setval('clients_id_seq', (SELECT COALESCE(MAX(id),1) FROM clients))")
    pg.commit()
    print(f"   ✓ {len(clients)} clients inserted")

    # --------------------------------------------------------------- followups
    followups = sq.execute("SELECT * FROM followups").fetchall()
    print(f"📅 Migrating {len(followups)} followups...")
    for r in followups:
        cur.execute("""
            INSERT INTO followups
              (id, client_id, title, type, scheduled_at, priority, status,
               is_positive_result, notes, location, meeting_link,
               reminder_sent, created_at, updated_at)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """, (
            r["id"], r["client_id"], r["title"], r["type"],
            r["scheduled_at"], r["priority"], r["status"],
            bool(r["is_positive_result"]), r["notes"], r["location"],
            r["meeting_link"], bool(r["reminder_sent"]),
            r["created_at"], r["updated_at"]
        ))
    cur.execute("SELECT setval('followups_id_seq', (SELECT COALESCE(MAX(id),1) FROM followups))")
    pg.commit()
    print(f"   ✓ {len(followups)} followups inserted")

    # ------------------------------------------------------------ notifications
    notifications = sq.execute("SELECT * FROM notifications").fetchall()
    print(f"🔔 Migrating {len(notifications)} notifications...")
    for r in notifications:
        cur.execute("""
            INSERT INTO notifications
              (id, title, message, type, client_id, followup_id, is_read, created_at)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
        """, (
            r["id"], r["title"], r["message"], r["type"],
            r["client_id"], r["followup_id"], bool(r["is_read"]),
            r["created_at"]
        ))
    cur.execute("SELECT setval('notifications_id_seq', (SELECT COALESCE(MAX(id),1) FROM notifications))")
    pg.commit()
    print(f"   ✓ {len(notifications)} notifications inserted")

    # --------------------------------------------------------------- finalize
    sq.close()
    pg.close()
    print(f"""
✅ Migration complete!
   → {len(clients)} clients
   → {len(followups)} followups
   → {len(notifications)} notifications

Next: Go to Render dashboard → your web service → Manual Deploy (or it will auto-deploy).
The seed won't run again because the clients table is now populated.
""")

if __name__ == "__main__":
    main()
