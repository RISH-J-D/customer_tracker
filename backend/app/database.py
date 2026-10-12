from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
import re

DB_DIR = os.path.dirname(os.path.abspath(__file__))

# Load .env file if present
for env_path in [
    os.path.join(os.path.dirname(DB_DIR), ".env"),
    os.path.join(os.path.dirname(os.path.dirname(DB_DIR)), ".env")
]:
    if os.path.exists(env_path):
        with open(env_path) as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    k, v = line.split("=", 1)
                    os.environ.setdefault(k.strip(), v.strip())

# Database URL from environment variable (for PostgreSQL / pgAdmin) or local SQLite fallback
DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    DATABASE_URL = f"sqlite:///{os.path.join(DB_DIR, 'tracker.db')}"


# SQLAlchemy 2.0 / psycopg compatibility: convert postgres:// to postgresql://
if DATABASE_URL.startswith("postgres://"):
    DATABASE_URL = DATABASE_URL.replace("postgres://", "postgresql://", 1)

IS_SQLITE = DATABASE_URL.startswith("sqlite")
IS_POSTGRES = DATABASE_URL.startswith("postgresql")


if IS_SQLITE:
    engine = create_engine(
        DATABASE_URL,
        connect_args={"check_same_thread": False}
    )
    # Enable SQLite foreign keys & WAL mode for durability and speed
    try:
        with engine.connect() as connection:
            connection.exec_driver_sql("PRAGMA foreign_keys = ON;")
            connection.exec_driver_sql("PRAGMA journal_mode = WAL;")
    except Exception as e:
        print(f"Notice: SQLite pragma configuration: {e}")
else:
    # PostgreSQL configuration (pgAdmin compatible)
    engine = create_engine(
        DATABASE_URL,
        pool_pre_ping=True,
        pool_size=10,
        max_overflow=20
    )

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

def get_db_info():
    """Return database engine details for UI status and pgAdmin connection info"""
    return {
        "engine": "postgresql" if IS_POSTGRES else "sqlite",
        "url_masked": re.sub(r':([^@]+)@', ':****@', DATABASE_URL) if '@' in DATABASE_URL else DATABASE_URL,
        "is_postgres": IS_POSTGRES,
        "is_sqlite": IS_SQLITE
    }

