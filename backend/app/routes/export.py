import io
from fastapi import APIRouter, Depends, Query, Response, UploadFile, File, HTTPException, Header
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from datetime import datetime
from typing import Optional
import pandas as pd
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from reportlab.lib import colors
from reportlab.lib.pagesizes import letter, landscape
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle

from ..database import get_db
from ..models import Client, FollowUp, NotificationItem
from ..activity_logger import log_activity

router = APIRouter(prefix="/api/export", tags=["Export"])

@router.get("/excel")
def export_clients_excel(db: Session = Depends(get_db)):
    """Export all client records, active leads, and follow-ups to a multi-sheet styled Excel workbook"""
    clients = db.query(Client).order_by(Client.name.asc()).all()
    followups = db.query(FollowUp).order_by(FollowUp.scheduled_at.desc()).all()

    wb = openpyxl.Workbook()
    # Sheet 1: All Clients
    ws_clients = wb.active
    ws_clients.title = "Clients & Leads"

    # Header style
    header_fill = PatternFill(start_color="1E293B", end_color="1E293B", fill_type="solid")
    header_font = Font(color="FFFFFF", bold=True, size=11)
    center_align = Alignment(horizontal="center", vertical="center")
    left_align = Alignment(horizontal="left", vertical="center")
    thin_border = Border(
        left=Side(style='thin', color='E2E8F0'),
        right=Side(style='thin', color='E2E8F0'),
        top=Side(style='thin', color='E2E8F0'),
        bottom=Side(style='thin', color='E2E8F0')
    )

    client_headers = ["ID", "Name", "Company", "Email", "Phone", "Category", "Status", "Is Lead?", "Positive Approach?", "Follow-up Touchpoints", "Created Date", "Notes"]
    ws_clients.append(client_headers)

    for col_idx in range(1, len(client_headers) + 1):
        cell = ws_clients.cell(row=1, column=col_idx)
        cell.fill = header_fill
        cell.font = header_font
        cell.alignment = center_align
        cell.border = thin_border

    lead_fill = PatternFill(start_color="DCFCE7", end_color="DCFCE7", fill_type="solid")
    pos_fill = PatternFill(start_color="FEF3C7", end_color="FEF3C7", fill_type="solid")

    for row_idx, c in enumerate(clients, start=2):
        row_data = [
            c.id,
            c.name,
            c.company or "N/A",
            c.email or "N/A",
            c.phone or "N/A",
            c.category,
            c.status,
            "YES (Lead)" if c.is_lead else "No",
            "YES" if c.positive_approach else "No",
            f"{len(c.followups)} touchpoints",
            c.created_at.strftime("%Y-%m-%d %H:%M") if c.created_at else "",
            c.notes or ""
        ]
        ws_clients.append(row_data)

        # Highlight leads and positive approaches
        if c.is_lead:
            ws_clients.cell(row=row_idx, column=8).fill = lead_fill
        if c.positive_approach:
            ws_clients.cell(row=row_idx, column=9).fill = pos_fill

        for col_idx in range(1, len(client_headers) + 1):
            cell = ws_clients.cell(row=row_idx, column=col_idx)
            cell.border = thin_border
            if col_idx in [1, 8, 9, 11]:
                cell.alignment = center_align
            elif col_idx == 10:
                cell.alignment = Alignment(horizontal="right", vertical="center")
            else:
                cell.alignment = left_align

    # Sheet 2: Follow-ups & Meetups
    ws_followups = wb.create_sheet(title="Follow-ups & Meetups")
    followup_headers = ["ID", "Client", "Company", "Title", "Type", "Scheduled Date/Time", "Priority", "Status", "Positive Outcome?", "Location / Link", "Notes"]
    ws_followups.append(followup_headers)

    for col_idx in range(1, len(followup_headers) + 1):
        cell = ws_followups.cell(row=1, column=col_idx)
        cell.fill = header_fill
        cell.font = header_font
        cell.alignment = center_align
        cell.border = thin_border

    for row_idx, f in enumerate(followups, start=2):
        row_data = [
            f.id,
            f.client.name if f.client else "N/A",
            f.client.company if f.client else "N/A",
            f.title,
            f.type,
            f.scheduled_at.strftime("%Y-%m-%d %H:%M") if f.scheduled_at else "",
            f.priority,
            f.status,
            "YES" if f.is_positive_result else "No",
            f.meeting_link or f.location or "N/A",
            f.notes or ""
        ]
        ws_followups.append(row_data)
        for col_idx in range(1, len(followup_headers) + 1):
            cell = ws_followups.cell(row=row_idx, column=col_idx)
            cell.border = thin_border
            if col_idx in [1, 5, 6, 7, 8, 9]:
                cell.alignment = center_align
            else:
                cell.alignment = left_align

    # Auto-adjust column widths
    for sheet in [ws_clients, ws_followups]:
        for col in sheet.columns:
            max_len = 0
            col_letter = col[0].column_letter
            for cell in col:
                val_str = str(cell.value or "")
                max_len = max(max_len, len(val_str))
            sheet.column_dimensions[col_letter].width = min(max(max_len + 3, 12), 40)

    output = io.BytesIO()
    wb.save(output)
    output.seek(0)

    filename = f"Client_Followups_Tracker_{datetime.utcnow().strftime('%Y%m%d_%H%M')}.xlsx"
    headers = {
        'Content-Disposition': f'attachment; filename="{filename}"'
    }
    return StreamingResponse(
        output,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers=headers
    )

@router.get("/pdf")
def export_clients_pdf(db: Session = Depends(get_db)):
    """Export formatted printable PDF report with client metrics, leads, and upcoming meetups"""
    clients = db.query(Client).order_by(Client.is_lead.desc(), Client.name.asc()).all()
    total_clients = len(clients)
    total_leads = sum(1 for c in clients if c.is_lead)
    positive_count = sum(1 for c in clients if c.positive_approach)
    total_pipeline = sum(c.deal_value for c in clients)

    buffer = io.BytesIO()
    doc = SimpleDocTemplate(
        buffer,
        pagesize=landscape(letter),
        rightMargin=30,
        leftMargin=30,
        topMargin=30,
        bottomMargin=30
    )

    styles = getSampleStyleSheet()
    title_style = ParagraphStyle(
        'DocTitle',
        parent=styles['Heading1'],
        fontSize=20,
        leading=24,
        textColor=colors.HexColor('#0F172A'),
        spaceAfter=6
    )
    subtitle_style = ParagraphStyle(
        'DocSubtitle',
        parent=styles['Normal'],
        fontSize=10,
        leading=14,
        textColor=colors.HexColor('#64748B'),
        spaceAfter=15
    )
    cell_style = ParagraphStyle(
        'Cell',
        parent=styles['Normal'],
        fontSize=8,
        leading=10,
        textColor=colors.HexColor('#1E293B')
    )
    cell_bold = ParagraphStyle(
        'CellBold',
        parent=styles['Normal'],
        fontSize=8,
        leading=10,
        textColor=colors.HexColor('#0F172A'),
        fontName='Helvetica-Bold'
    )

    elements = []

    # Title & Subtitle
    elements.append(Paragraph("Client Follow-Up & Lead Pipeline Report", title_style))
    elements.append(Paragraph(f"Generated on {datetime.utcnow().strftime('%B %d, %Y at %I:%M %p UTC')} | Client Flow CRM & Reminder System", subtitle_style))

    # Executive Summary Box
    summary_data = [
        [
            Paragraph("<b>Total Tracked Clients:</b>", cell_style),
            Paragraph(str(total_clients), cell_bold),
            Paragraph("<b>Active Leads:</b>", cell_style),
            Paragraph(f"{total_leads} ({round(total_leads / max(total_clients, 1) * 100, 1)}%)", cell_bold),
            Paragraph("<b>Positive Approach:</b>", cell_style),
            Paragraph(str(positive_count), cell_bold),
            Paragraph("<b>Total Touchpoints:</b>", cell_style),
            Paragraph(str(sum(len(c.followups) for c in clients)), cell_bold)
        ]
    ]
    summary_table = Table(summary_data, colWidths=[100, 50, 70, 70, 90, 50, 90, 70])
    summary_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, -1), colors.HexColor('#F8FAFC')),
        ('BOX', (0, 0), (-1, -1), 1, colors.HexColor('#CBD5E1')),
        ('PADDING', (0, 0), (-1, -1), 6),
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
    ]))
    elements.append(summary_table)
    elements.append(Spacer(1, 15))

    # Clients Table
    table_headers = [
        Paragraph("<b>Client Name</b>", cell_bold),
        Paragraph("<b>Company</b>", cell_bold),
        Paragraph("<b>Contact (Email/Phone)</b>", cell_bold),
        Paragraph("<b>Category</b>", cell_bold),
        Paragraph("<b>Status</b>", cell_bold),
        Paragraph("<b>Lead?</b>", cell_bold),
        Paragraph("<b>Positive?</b>", cell_bold),
        Paragraph("<b>Touchpoints</b>", cell_bold),
        Paragraph("<b>Follow-up Notes</b>", cell_bold)
    ]
    table_data = [table_headers]

    for c in clients:
        contact_str = f"{c.email or ''}<br/>{c.phone or ''}".strip("<br/>")
        is_lead_badge = "<font color='#16A34A'><b>YES (LEAD)</b></font>" if c.is_lead else "Prospect"
        pos_badge = "<font color='#D97706'><b>YES</b></font>" if c.positive_approach else "No"
        notes_snippet = (c.notes[:90] + "...") if c.notes and len(c.notes) > 90 else (c.notes or "-")

        table_data.append([
            Paragraph(c.name, cell_bold),
            Paragraph(c.company or "N/A", cell_style),
            Paragraph(contact_str or "N/A", cell_style),
            Paragraph(c.category, cell_style),
            Paragraph(c.status, cell_style),
            Paragraph(is_lead_badge, cell_style),
            Paragraph(pos_badge, cell_style),
            Paragraph(f"{len(c.followups)} touchpoints", cell_style),
            Paragraph(notes_snippet, cell_style)
        ])

    col_widths = [90, 85, 110, 60, 75, 60, 50, 55, 160]
    client_table = Table(table_data, colWidths=col_widths, repeatRows=1)
    client_table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.HexColor('#1E293B')),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.white),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 5),
        ('TOPPADDING', (0, 0), (-1, -1), 5),
        ('LEFTPADDING', (0, 0), (-1, -1), 4),
        ('RIGHTPADDING', (0, 0), (-1, -1), 4),
        ('GRID', (0, 0), (-1, -1), 0.5, colors.HexColor('#E2E8F0')),
        ('ROWBACKGROUNDS', (0, 1), (-1, -1), [colors.white, colors.HexColor('#F8FAFC')]),
    ]))

    elements.append(client_table)
    doc.build(elements)
    buffer.seek(0)

    filename = f"Client_Pipeline_Report_{datetime.utcnow().strftime('%Y%m%d_%H%M')}.pdf"
    headers = {
        'Content-Disposition': f'attachment; filename="{filename}"'
    }
    return StreamingResponse(
        buffer,
        media_type="application/pdf",
        headers=headers
    )

@router.get("/csv")
def export_clients_csv(db: Session = Depends(get_db)):
    """Export client list to CSV"""
    clients = db.query(Client).order_by(Client.name.asc()).all()
    rows = []
    for c in clients:
        rows.append({
            "Client ID": c.id,
            "Name": c.name,
            "Company": c.company or "",
            "Email": c.email or "",
            "Phone": c.phone or "",
            "Category": c.category,
            "Status": c.status,
            "Is Lead": "YES" if c.is_lead else "NO",
            "Positive Approach": "YES" if c.positive_approach else "NO",
            "Follow-up Touchpoints": len(c.followups),
            "Notes": c.notes or "",
            "Created Date": c.created_at.strftime("%Y-%m-%d %H:%M:%S") if c.created_at else ""
        })
    df = pd.DataFrame(rows)
    stream = io.StringIO()
    df.to_csv(stream, index=False)
    
    filename = f"clients_export_{datetime.utcnow().strftime('%Y%m%d')}.csv"
    return Response(
        content=stream.getvalue(),
        media_type="text/csv",
        headers={"Content-Disposition": f'attachment; filename="{filename}"'}
    )

@router.post("/import-excel")
async def import_clients_excel(
    file: UploadFile = File(...), 
    x_user_name: Optional[str] = Header(None),
    x_user_username: Optional[str] = Header(None),
    db: Session = Depends(get_db)
):
    """Upload an Excel (.xlsx, .xls) or CSV file and insert records into the clients table"""
    filename = file.filename or ""
    if not (filename.endswith(".xlsx") or filename.endswith(".xls") or filename.endswith(".csv")):
        raise HTTPException(status_code=400, detail="Invalid file format. Please upload an .xlsx, .xls, or .csv file.")

    contents = await file.read()
    try:
        if filename.endswith(".csv"):
            df = pd.read_csv(io.BytesIO(contents))
        else:
            df = pd.read_excel(io.BytesIO(contents))
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Failed to parse file: {str(e)}")

    if df.empty:
        raise HTTPException(status_code=400, detail="The uploaded spreadsheet contains no data rows.")

    # Normalize column names: lower-cased and stripped of spaces/special chars
    col_map = {}
    for col in df.columns:
        clean = str(col).strip().lower().replace("_", "").replace(" ", "").replace("?", "").replace("(", "").replace(")", "").replace("$", "")
        col_map[col] = clean

    imported_clients = []
    skipped_rows = 0
    errors = []

    for index, row in df.iterrows():
        # Find cell values by flexible matching
        row_dict = {}
        for original_col, clean_col in col_map.items():
            val = row[original_col]
            if pd.isna(val):
                val = None
            row_dict[clean_col] = val

        # Resolve fields
        name = (row_dict.get("name") or row_dict.get("clientname") or row_dict.get("fullname") or row_dict.get("client"))
        if not name or str(name).strip() == "" or str(name).strip().lower() == "nan":
            skipped_rows += 1
            continue

        name = str(name).strip()
        company = str(row_dict.get("company") or row_dict.get("organization") or row_dict.get("business") or "").strip() or None
        email = str(row_dict.get("email") or row_dict.get("emailaddress") or "").strip() or None
        phone = str(row_dict.get("phone") or row_dict.get("phonenumber") or row_dict.get("mobile") or "").strip() or None
        category = "Steel Detailing"
        status = str(row_dict.get("status") or "Prospect").strip() or "Prospect"
        
        # Parse boolean flags
        is_lead_raw = row_dict.get("islead") or row_dict.get("lead")
        is_lead = False
        if is_lead_raw is not None:
            is_lead_str = str(is_lead_raw).strip().lower()
            is_lead = is_lead_str in ["yes", "true", "1", "y", "lead"]

        pos_raw = row_dict.get("positiveapproach") or row_dict.get("positive")
        positive_approach = False
        if pos_raw is not None:
            pos_str = str(pos_raw).strip().lower()
            positive_approach = pos_str in ["yes", "true", "1", "y"]

        # Deal value
        deal_val_raw = row_dict.get("dealvalue") or row_dict.get("estdealvalue") or row_dict.get("value") or 0.0
        deal_value = 0.0
        if deal_val_raw is not None:
            try:
                cleaned_val = str(deal_val_raw).replace("$", "").replace(",", "").strip()
                deal_value = float(cleaned_val)
            except (ValueError, TypeError):
                deal_value = 0.0

        notes = str(row_dict.get("notes") or row_dict.get("comments") or row_dict.get("description") or "").strip() or None

        try:
            client = Client(
                name=name,
                company=company,
                email=email,
                phone=phone,
                category=category,
                status="Qualified Lead" if is_lead else status,
                is_lead=is_lead,
                positive_approach=positive_approach,
                lead_converted_at=datetime.utcnow() if is_lead else None,
                deal_value=deal_value,
                notes=notes
            )
            db.add(client)
            imported_clients.append(name)
        except Exception as e:
            errors.append(f"Row {index + 2}: {str(e)}")

    db.commit()

    # Create notification item
    if imported_clients:
        notif = NotificationItem(
            title=f"Imported {len(imported_clients)} Steel Detailing Clients",
            message=f"Successfully imported {len(imported_clients)} client(s) from Excel file '{filename}'.",
            type="import_success"
        )
        db.add(notif)
        db.commit()

        log_activity(
            db=db,
            action="IMPORT_EXCEL",
            entity_type="Excel",
            entity_name=filename,
            description=f"Imported {len(imported_clients)} steel detailing clients from file '{filename}' ({skipped_rows} skipped, {len(errors)} errors)",
            changes={
                "filename": filename,
                "count": len(imported_clients),
                "sample_clients": imported_clients[:5]
            },
            user_name=x_user_name,
            user_username=x_user_username
        )

    return {
        "status": "success",
        "imported_count": len(imported_clients),
        "skipped_count": skipped_rows,
        "errors": errors,
        "message": f"Successfully imported {len(imported_clients)} client(s) into database."
    }

@router.get("/template")
def download_excel_template():
    """Download an Excel template formatted for importing steel detailing clients"""
    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = "Import Clients"

    header_fill = PatternFill(start_color="1E293B", end_color="1E293B", fill_type="solid")
    header_font = Font(color="FFFFFF", bold=True, size=11)
    center_align = Alignment(horizontal="center", vertical="center")
    thin_border = Border(
        left=Side(style='thin', color='CBD5E1'),
        right=Side(style='thin', color='CBD5E1'),
        top=Side(style='thin', color='CBD5E1'),
        bottom=Side(style='thin', color='CBD5E1')
    )

    headers = [
        "Name", "Company", "Email", "Phone",
        "Status", "Is Lead?", "Positive Approach?", "Est Deal Value ($)", "Notes"
    ]
    ws.append(headers)

    for col_idx in range(1, len(headers) + 1):
        cell = ws.cell(row=1, column=col_idx)
        cell.fill = header_fill
        cell.font = header_font
        cell.alignment = center_align
        cell.border = thin_border

    sample_rows = [
        ["Marcus Vance", "Apex Steel Fabricators", "marcus@apexsteel.com", "+1 555-019-2834", "Demo Scheduled", "YES", "YES", 32000, "Structural steel detailing project (commercial warehouse)"],
        ["David Miller", "Summit Ironworks & Detailing", "dmiller@summitiron.com", "+1 555-482-1940", "Prospect", "NO", "YES", 18500, "Positive response to initial outreach for stair/railing misc steel"],
        ["Elena Rostova", "Alliance Structural Detailing", "elena@alliancesteel.com", "+1 555-938-2011", "Proposal Sent", "YES", "YES", 45000, "Commercial high-rise steel detailing quote requested"]
    ]


    for row_idx, r in enumerate(sample_rows, start=2):
        ws.append(r)
        for col_idx in range(1, len(headers) + 1):
            cell = ws.cell(row=row_idx, column=col_idx)
            cell.border = thin_border

    for col in ws.columns:
        max_len = max(len(str(cell.value or "")) for cell in col)
        col_letter = col[0].column_letter
        ws.column_dimensions[col_letter].width = max(max_len + 4, 15)

    output = io.BytesIO()
    wb.save(output)
    output.seek(0)

    filename = "Client_Import_Template.xlsx"
    return StreamingResponse(
        output,
        media_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        headers={'Content-Disposition': f'attachment; filename="{filename}"'}
    )

