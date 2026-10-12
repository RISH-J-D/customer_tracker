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

@app.get("/api/health")
def health_check():
    return {"status": "healthy", "service": "client-reminder-backend", "version": "1.0.0"}

@app.get("/api/db-status")
def database_status():
    return get_db_info()

# Static files & React SPA serving for Hugging Face Spaces & single-container deployment
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse

STATIC_DIR = os.getenv("STATIC_DIR", "")
if not STATIC_DIR or not os.path.isdir(STATIC_DIR):
    possible_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "frontend_dist")
    if os.path.isdir(possible_dir):
        STATIC_DIR = possible_dir

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
