from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
from .database import engine, Base, SessionLocal
from .seed_data import seed_initial_data, seed_users_and_logs, seed_accounts
from .routes import clients, followups, dashboard, notifications, export, auth, logs, accounts

@asynccontextmanager
async def lifespan(app: FastAPI):
    # Initialize DB tables
    Base.metadata.create_all(bind=engine)
    # Seed initial test clients, follow-up reminders, users, and accounts
    db = SessionLocal()
    try:
        seed_initial_data(db)
        seed_users_and_logs(db)
        seed_accounts(db)
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
app.include_router(accounts.router)

from .database import engine, Base, SessionLocal, get_db_info

@app.get("/")
def root():
    return {
        "status": "online",
        "service": "Customer Tracker & Detailing Accounts API",
        "version": "1.0.0",
        "docs": "/docs",
        "health": "/api/health"
    }

@app.get("/api/health")
def health_check():
    return {"status": "healthy", "service": "client-reminder-backend", "version": "1.0.0"}

@app.get("/api/db-status")
def database_status():
    return get_db_info()
