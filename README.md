# ClientFlow Tracker: Client Follow-up & Reminder System

A reminder and client pipeline management system built with **React**, **Python FastAPI**, **SQLite**, and **Capacitor Android** for desktop and mobile APK deployment.

---

## 🌟 Core Features

- **Daily Follow-up & Meetup Reminders**:
  - Today's Action Center with alert badges for urgent meetups.
  - Interactive "Today's Agenda" popup with direct video meeting links and completion logs.
  - Periodic background reminder checks that dispatch system & in-app notifications.

- **Client Tracking & Positive Approach Management**:
  - Full client tracking directory with industry categories and estimated deal values.
  - **Positive Approach Flag**: Record enthusiastic responses and proposals.
  - **1-Click "Convert to Lead"**: Turn qualified clients into active high-priority Leads with confetti celebrations.

- **Comprehensive Interaction Scheduler**:
  - Schedule Online Video Meetups, In-Person Meetings, Demos, Calls, and Emails.
  - Priority indicators: High (Urgent), Medium, Low.
  - Log completion outcomes with automated lead conversion prompts.

- **Multi-Format Enterprise Exports**:
  - **Microsoft Excel (.xlsx)**: Multi-sheet workbook with styled headers, lead badges, and interaction logs.
  - **Printable Executive PDF (.pdf)**: High-resolution landscape summary report with KPI stat cards and client table.
  - **CSV Export (.csv)**: Clean data export for CRM/spreadsheet imports.

- **Excel Spreadsheet Import & Automatic Table Population**:
  - Drag-and-drop or browse `.xlsx`, `.xls`, or `.csv` files.
  - Automatically parses and validates column headers (Name, Company, Email, Phone, Category, Status, Is Lead?, Positive Approach?, Deal Value, Notes).
  - Bulk inserts imported customer records into the database with confetti celebration & live table reload.
  - Downloadable pre-formatted Excel starter template (`Client_Import_Template.xlsx`).

- **Professional Dark Mode**:
  - High-end dark theme (Linear / Stripe / Vercel midnight obsidian aesthetic).
  - Quick toggle button (Sun / Moon) in the top navigation bar with persistent preference in `localStorage`.
  - Contrast-optimized colors, glassmorphism modals, customized scrollbars, and styled data tables.

- **pgAdmin & PostgreSQL Controls**:
  - Native PostgreSQL support powered by SQLAlchemy and `psycopg2-binary`.
  - Seamlessly switch between default SQLite and PostgreSQL by configuring `DATABASE_URL`.
  - In-app Database Controls modal with instant pgAdmin 4 connection parameters (Host: `localhost`, Port: `5432`, DB: `tracker_db`).

- **Modular Login & Authentication Page**:
  - Dedicated modern SaaS Sign In screen with work email, password show/hide, remember device option, and demo guest bypass.
  - Ready for custom OAuth / JWT authentication provider integration.

- **Dual Platform Support**:
  - **Web Application**: Accessible on desktop and mobile browsers at `http://localhost:5173`.
  - **Android APK**: Native mobile application generated with Capacitor and Gradle at `apks/clientflow-tracker.apk`.


---

## 🚀 Quick Start

### 1. Run Web Application & Backend Server

Simply run the unified startup script:

```bash
./start.sh
```

- **React Web App**: [http://localhost:5173](http://localhost:5173)
- **Backend API**: [http://localhost:8000](http://localhost:8000)
- **Interactive API Docs (Swagger UI)**: [http://localhost:8000/docs](http://localhost:8000/docs)

### 2. Build or Rebuild the Android APK

To recompile the Android mobile APK with updated code:

```bash
./build-apk.sh
```

The compiled APK will be generated at:
```bash
apks/clientflow-tracker.apk
```

To install on a connected Android phone or emulator:
```bash
adb install apks/clientflow-tracker.apk
```

---

## 🏗 Architecture & Tech Stack

- **Frontend**: React 18, Vite, Lucide Icons, Date-fns, Canvas Confetti.
- **Backend**: Python 3.12, FastAPI, SQLAlchemy 2.0, SQLite with WAL mode.
- **Reports & Exporting**: OpenPyXL (Excel), ReportLab (PDF), Pandas.
- **Mobile Packaging**: Capacitor Android, Gradle 8.14, Android SDK Platform 34.
