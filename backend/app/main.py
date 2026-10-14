import re
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from sqlalchemy import inspect, text
from .database import engine, Base, SessionLocal
from .seed_data import seed_initial_data, seed_users_and_logs
from .routes import clients, followups, dashboard, notifications, export, auth, logs

def migrate_client_columns():
    """Add columns introduced after the clients table was first created (create_all won't alter existing tables)."""
    existing = {c["name"] for c in inspect(engine).get_columns("clients")}
    if "account_converted_at" not in existing:
        with engine.begin() as conn:
            conn.execute(text("ALTER TABLE clients ADD COLUMN account_converted_at TIMESTAMP"))
            # Leads imported with CRM status Accepted/Active were the ones converted to accounts
            # (the accounts table can't be used here: bulk imports linked it to almost every client)
            conn.execute(text(
                "UPDATE clients SET account_converted_at = COALESCE(lead_converted_at, created_at) "
                "WHERE is_lead = TRUE AND status IN ('Accepted', 'Active')"
            ))

IMPORT_NOTE_FIELD = re.compile(r"^(Position|Location|Original CRM Status):")

def strip_import_generated_notes():
    """Remove the 'Position: … | Location: … | Original CRM Status: …' text the Excel loader wrote into notes.
    Those values already live in the position / city / state / country / status columns."""
    with engine.begin() as conn:
        rows = conn.execute(text("SELECT id, notes FROM clients WHERE notes LIKE '%Original CRM Status:%'")).all()
        for client_id, notes in rows:
            kept = [p.strip() for p in notes.split("|") if p.strip() and not IMPORT_NOTE_FIELD.match(p.strip())]
            conn.execute(
                text("UPDATE clients SET notes = :notes WHERE id = :id"),
                {"notes": " | ".join(kept) or None, "id": client_id}
            )

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Initialize DB tables
    Base.metadata.create_all(bind=engine)
    migrate_client_columns()
    strip_import_generated_notes()
    # Seed initial test clients, follow-up reminders, and users
    db = SessionLocal()
    try:
        seed_initial_data(db)
        seed_users_and_logs(db)
    finally:
        db.close()
    yield

app = FastAPI(
    title="Client Follow-up & Reminder API",
    description="Backend API for tracking clients, follow-ups, meetups, reminders, and lead conversion.",
    version="1.0.0",
    lifespan=lifespan
)

import os

cors_env = os.getenv("CORS_ORIGINS", "*").strip()
if cors_env and cors_env != "*":
    allowed_origins = [o.strip() for o in cors_env.split(",") if o.strip()]
else:
    allowed_origins = ["*"]

# Enable CORS for React frontend (Vite port 5173, Vercel deployments, capacitor, and configurable origins)
app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(clients.router)
app.include_router(followups.router)
app.include_router(dashboard.router)
app.include_router(notifications.router)
app.include_router(export.router)
app.include_router(auth.router)
app.include_router(logs.router)

from .database import engine, Base, SessionLocal, get_db_info

@app.get("/api/health")
def health_check():
    return {"status": "healthy", "service": "client-reminder-backend", "version": "1.0.1"}

@app.get("/api/db-status")
def database_status():
    return get_db_info()

# Static files & React SPA serving for Hugging Face Spaces & single-container deployment
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse

STATIC_DIR = os.getenv("STATIC_DIR", "")
if not STATIC_DIR or not os.path.isdir(STATIC_DIR):
    for candidate in [
        os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "frontend_dist"),
        os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "frontend_dist"),
        os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))), "frontend", "dist")
    ]:
        if candidate and os.path.isdir(candidate):
            STATIC_DIR = candidate
            break

if STATIC_DIR and os.path.exists(os.path.join(STATIC_DIR, "index.html")):
    assets_dir = os.path.join(STATIC_DIR, "assets")
    if os.path.isdir(assets_dir):
        app.mount("/assets", StaticFiles(directory=assets_dir), name="assets")

    @app.get("/{full_path:path}")
    async def serve_spa(full_path: str):
        if full_path.startswith("api/") or full_path in ["docs", "redoc", "openapi.json"]:
            return {"detail": "Not Found"}
        target = os.path.join(STATIC_DIR, full_path)
        if full_path and os.path.exists(target) and os.path.isfile(target):
            return FileResponse(target)
        return FileResponse(os.path.join(STATIC_DIR, "index.html"))
else:
    @app.get("/")
    def root():
        return {
            "status": "online",
            "service": "Customer Tracker & Detailing Accounts API",
            "version": "1.0.0",
            "docs": "/docs",
            "health": "/api/health"
        }
