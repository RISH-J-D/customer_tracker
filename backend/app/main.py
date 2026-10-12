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

# Enable CORS for React frontend (Vite port 5173, mobile capacitor, and any origin in dev)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
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

@app.get("/api/health")
def health_check():
    return {"status": "healthy", "service": "client-reminder-backend", "version": "1.0.0"}

@app.get("/api/db-status")
def database_status():
    return get_db_info()
