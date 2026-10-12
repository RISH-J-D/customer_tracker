from datetime import datetime, timedelta
from sqlalchemy.orm import Session
from .models import Client, FollowUp, NotificationItem

def seed_initial_data(db: Session):
    # Only seed if no clients exist
    if db.query(Client).first():
        return

    now = datetime.utcnow()
    # Today's hours for instant testing of today's reminders
    today_morning = now.replace(hour=10, minute=0, second=0, microsecond=0)
    today_afternoon = now.replace(hour=14, minute=30, second=0, microsecond=0)
    today_evening = now.replace(hour=17, minute=0, second=0, microsecond=0)
    tomorrow = now + timedelta(days=1)
    in_three_days = now + timedelta(days=3)

    sample_clients = [
        Client(
            name="Alexander Wright",
            company="Apex Global Logistics",
            email="alexander@apexlogistics.com",
            phone="+1 (555) 234-8901",
            category="Enterprise",
            status="Positive Response",
            is_lead=False,
            positive_approach=True,
            deal_value=48500.0,
            notes="Very impressed by our automated shipment tracking workflow during the intro call. Requested a formal pricing proposal and contract terms.",
            created_at=now - timedelta(days=12)
        ),
        Client(
            name="Elena Rostova",
            company="Novus Fintech Solutions",
            email="elena.r@novusfintech.io",
            phone="+1 (555) 492-7711",
            category="Finance",
            status="Lead",
            is_lead=True,
            positive_approach=True,
            lead_converted_at=now - timedelta(days=2),
            deal_value=62000.0,
            notes="Converted to active high-priority Lead. Budget approved for Q4 enterprise rollout. Board meeting scheduled next week.",
            created_at=now - timedelta(days=20)
        ),
        Client(
            name="Marcus Chen",
            company="BioSphere Healthcare",
            email="m.chen@biospherehealth.org",
            phone="+1 (555) 819-3042",
            category="Healthcare",
            status="Meeting Scheduled",
            is_lead=False,
            positive_approach=False,
            deal_value=35000.0,
            notes="Interested in patient check-in reminders and HIPAA compliant messaging. Initial exploratory phase.",
            created_at=now - timedelta(days=5)
        ),
        Client(
            name="Sarah Jenkins",
            company="Summit Digital Media",
            email="s.jenkins@summitmedia.agency",
            phone="+1 (555) 304-9821",
            category="Marketing",
            status="Positive Response",
            is_lead=False,
            positive_approach=True,
            deal_value=27500.0,
            notes="Client praised our pitch deck. Wants to onboard 15 account managers by end of month.",
            created_at=now - timedelta(days=8)
        ),
        Client(
            name="David Miller",
            company="Kinetix Robotics",
            email="david.miller@kinetix.tech",
            phone="+1 (555) 671-4450",
            category="Tech",
            status="In Discussion",
            is_lead=False,
            positive_approach=False,
            deal_value=85000.0,
            notes="Evaluating integration options with their internal ERP system.",
            created_at=now - timedelta(days=15)
        ),
        Client(
            name="Sophia Patel",
            company="Aura Retail Group",
            email="spatel@auraretail.com",
            phone="+1 (555) 912-3344",
            category="Retail",
            status="Lead",
            is_lead=True,
            positive_approach=True,
            lead_converted_at=now - timedelta(days=7),
            deal_value=54000.0,
            notes="Signed pilot agreement for 3 flagship stores. Follow up on store manager orientation.",
            created_at=now - timedelta(days=25)
        ),
    ]

    for c in sample_clients:
        db.add(c)
    db.commit()

    # Re-query with IDs
    c_alex = db.query(Client).filter_by(name="Alexander Wright").first()
    c_elena = db.query(Client).filter_by(name="Elena Rostova").first()
    c_marcus = db.query(Client).filter_by(name="Marcus Chen").first()
    c_sarah = db.query(Client).filter_by(name="Sarah Jenkins").first()
    c_david = db.query(Client).filter_by(name="David Miller").first()
    c_sophia = db.query(Client).filter_by(name="Sophia Patel").first()

    sample_followups = [
        FollowUp(
            client_id=c_alex.id,
            title="Executive Meetup: Final Contract & SLA Review",
            type="Meetup",
            scheduled_at=today_morning,
            priority="High",
            status="Pending",
            is_positive_result=True,
            notes="Discuss proposed billing schedule, review SLA metrics, and confirm go-live milestone dates.",
            location="Google Meet",
            meeting_link="https://meet.google.com/xyz-tracker-apex"
        ),
        FollowUp(
            client_id=c_sarah.id,
            title="Product Demo & Client Onboarding Discussion",
            type="Demo",
            scheduled_at=today_afternoon,
            priority="High",
            status="Pending",
            is_positive_result=True,
            notes="Walk through account manager dashboard and permissions. If positive, promote to Lead immediately!",
            location="Zoom",
            meeting_link="https://zoom.us/j/9876543210"
        ),
        FollowUp(
            client_id=c_marcus.id,
            title="Discovery Call: Compliance & Security Requirements",
            type="Call",
            scheduled_at=today_evening,
            priority="Medium",
            status="Pending",
            is_positive_result=False,
            notes="Clarify HIPAA certification and server encryption architecture.",
            location="Phone Call"
        ),
        FollowUp(
            client_id=c_elena.id,
            title="Quarterly Strategy In-Person Lunch Meetup",
            type="In-Person",
            scheduled_at=tomorrow.replace(hour=12, minute=30),
            priority="High",
            status="Pending",
            is_positive_result=True,
            notes="Celebrate kickoff and meet CFO regarding additional branch expansion.",
            location="Grand Bistro Downtown, Private Room 3"
        ),
        FollowUp(
            client_id=c_david.id,
            title="Technical Follow-up: API Architecture Q&A",
            type="Meetup",
            scheduled_at=in_three_days.replace(hour=15, minute=0),
            priority="Medium",
            status="Pending",
            is_positive_result=False,
            notes="Provide sandbox keys and guide engineering team through webhook test endpoints.",
            location="Microsoft Teams",
            meeting_link="https://teams.microsoft.com/l/meetup-join/kinetix"
        ),
    ]

    for f in sample_followups:
        db.add(f)
    db.commit()

    # Add initial notification
    notif = NotificationItem(
        title="Today's Follow-up Reminder",
        message="You have 3 critical client follow-ups & meetups scheduled for today (Apex Logistics, Summit Media, BioSphere).",
        type="today_followup",
        client_id=c_alex.id,
        is_read=False
    )
    db.add(notif)
    db.commit()

def seed_users_and_logs(db: Session):
    from .models import User, ActivityLog
    import json

    users_data = [
        {"username": "abarna.s", "password": "abarna@2026", "name": "Abarna S", "role": "Steel Detailing Executive"},
        {"username": "girish.j", "password": "girish@2026", "name": "Girish J", "role": "Steel Detailing Executive"},
        {"username": "admin", "password": "admin@123", "name": "Admin", "role": "System Administrator"},
    ]

    for u in users_data:
        existing = db.query(User).filter(User.username == u["username"]).first()
        if not existing:
            db.add(User(
                username=u["username"],
                password=u["password"],
                name=u["name"],
                role=u["role"],
                created_at=datetime.utcnow()
            ))
        else:
            existing.password = u["password"]
            existing.name = u["name"]
            existing.role = u["role"]
    db.commit()

    # Seed initial activity logs if none exist
    if not db.query(ActivityLog).first():
        now = datetime.utcnow()
        sample_logs = [
            ActivityLog(
                user_name="Admin",
                user_username="admin",
                action="INITIALIZE",
                entity_type="Database",
                entity_name="tracker_db (PostgreSQL)",
                description="Initialized PostgreSQL tracker_db cluster with Steel Detailing schema and pgAdmin controls",
                created_at=now - timedelta(hours=3)
            ),
            ActivityLog(
                user_name="Abarna S",
                user_username="abarna.s",
                action="CREATE_CLIENT",
                entity_type="Client",
                entity_name="Apex Global Logistics",
                description="Created new Client: 'Apex Global Logistics' with status 'Positive Response'",
                changes=json.dumps({"category": "Steel Detailing", "status": "Positive Response", "deal_value": 48500}),
                created_at=now - timedelta(hours=2, minutes=15)
            ),
            ActivityLog(
                user_name="Girish J",
                user_username="girish.j",
                action="CONVERT_LEAD",
                entity_type="Lead",
                entity_name="Novus Fintech Solutions",
                description="Promoted prospect 'Novus Fintech Solutions' to Qualified Lead (Deal Value: $62,000.00)",
                changes=json.dumps({"is_lead": True, "deal_value": 62000, "status": "Lead"}),
                created_at=now - timedelta(hours=1, minutes=45)
            ),
            ActivityLog(
                user_name="Abarna S",
                user_username="abarna.s",
                action="SCHEDULE_FOLLOWUP",
                entity_type="FollowUp",
                entity_name="Executive Meetup: Final Contract Review",
                description="Scheduled Meetup 'Executive Meetup: Final Contract Review' with Alexander Wright",
                changes=json.dumps({"type": "Meetup", "priority": "High"}),
                created_at=now - timedelta(minutes=50)
            ),
            ActivityLog(
                user_name="Admin",
                user_username="admin",
                action="LOGIN",
                entity_type="Auth",
                entity_name="Admin",
                description="User Admin (admin) logged in to ClientFlow",
                created_at=now - timedelta(minutes=15)
            )
        ]
        for log_item in sample_logs:
            db.add(log_item)
        db.commit()

def seed_accounts(db: Session):
    from .models import Account, Client

    if db.query(Account).first():
        return

    c_elena = db.query(Client).filter_by(name="Elena Rostova").first()
    c_sophia = db.query(Client).filter_by(name="Sophia Patel").first()
    c_alex = db.query(Client).filter_by(name="Alexander Wright").first()

    now = datetime.utcnow()
    sample_accounts = [
        # Multiple accounts for Novus Fintech Solutions under different client representatives
        Account(
            client_id=c_elena.id if c_elena else None,
            account_name="Novus HQ Tower - Core Structural Detailing",
            company="Novus Fintech Solutions",
            project_name="Novus 28-Story Commercial Tower Core",
            client_representative="Elena Rostova",
            rep_designation="Operations Vice President",
            rep_email="elena.r@novusfintech.io",
            rep_phone="+1 (555) 492-7711",
            deal_value=62000.0,
            steel_tonnage=480.0,
            status="In Detailing",
            notes="3D Tekla modeling of core shear trusses, moment connections, and anchor bolt plans per AISC 360-16.",
            created_at=now - timedelta(days=1)
        ),
        Account(
            client_id=c_elena.id if c_elena else None,
            account_name="Novus Data Center - Heavy Equipment Mezzanine",
            company="Novus Fintech Solutions",
            project_name="Data Center Annex Phase 2",
            client_representative="Marcus Sterling",
            rep_designation="Senior Structural Engineer",
            rep_email="m.sterling@novusfintech.io",
            rep_phone="+1 (555) 492-8822",
            deal_value=45000.0,
            steel_tonnage=320.0,
            status="Active Project",
            notes="Heavy equipment platforms and vibration-resistant connection detailing. Fast-track delivery.",
            created_at=now - timedelta(hours=18)
        ),
        # Multiple accounts for Aura Retail Group under different client representatives
        Account(
            client_id=c_sophia.id if c_sophia else None,
            account_name="Aura Flagship Plaza - Long-Span Roof Trusses",
            company="Aura Retail Group",
            project_name="Aura Metro Center Flagship Store",
            client_representative="Sophia Patel",
            rep_designation="VP of Store Development",
            rep_email="spatel@auraretail.com",
            rep_phone="+1 (555) 912-3344",
            deal_value=54000.0,
            steel_tonnage=390.0,
            status="Fabrication Review",
            notes="Long-span curved architectural canopy and structural roof truss shop drawings.",
            created_at=now - timedelta(days=3)
        ),
        Account(
            client_id=c_sophia.id if c_sophia else None,
            account_name="Aura Regional Logistics - Automated Conveyor Steel",
            company="Aura Retail Group",
            project_name="Midwest Fulfillment Center Steel Framing",
            client_representative="David K. Cho",
            rep_designation="Head of Facilities Construction",
            rep_email="d.cho@auraretail.com",
            rep_phone="+1 (555) 912-5566",
            deal_value=38500.0,
            steel_tonnage=245.0,
            status="Active Project",
            notes="Elevated walkways, maintenance ladders, and automated sorting conveyor structural supports.",
            created_at=now - timedelta(hours=8)
        ),
        # Account under Apex Global Logistics
        Account(
            client_id=c_alex.id if c_alex else None,
            account_name="Apex Intermodal Hub - High-Bay Rack Detailing",
            company="Apex Global Logistics",
            project_name="Port Intermodal Logistics Warehouse",
            client_representative="Alexander Wright",
            rep_designation="Director of Infrastructure",
            rep_email="alexander@apexlogistics.com",
            rep_phone="+1 (555) 234-8901",
            deal_value=48500.0,
            steel_tonnage=350.0,
            status="Active Project",
            notes="High-bay racking connection drawings, gantry crane rail girders, and seismic bracing.",
            created_at=now - timedelta(hours=4)
        )
    ]

    for acc in sample_accounts:
        db.add(acc)
    db.commit()


