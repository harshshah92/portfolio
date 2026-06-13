from reportlab.lib.pagesizes import A4
from reportlab.lib.units import mm, cm
from reportlab.lib.colors import HexColor, white, black
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle, PageBreak, HRFlowable
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.enums import TA_LEFT, TA_CENTER, TA_JUSTIFY
from reportlab.pdfgen import canvas
from reportlab.platypus.doctemplate import PageTemplate, BaseDocTemplate, Frame
from reportlab.platypus.flowables import Flowable
import os

# Colors
PRIMARY = HexColor("#1a1a2e")
ACCENT = HexColor("#16213e")
HIGHLIGHT = HexColor("#0f3460")
GOLD = HexColor("#e94560")
LIGHT_BG = HexColor("#f8f9fa")
DARK_TEXT = HexColor("#2d2d2d")
SUBTLE = HexColor("#6c757d")
TECH_BG = HexColor("#e8f4f8")
TECH_BORDER = HexColor("#0f3460")

WIDTH, HEIGHT = A4

class ColorBar(Flowable):
    def __init__(self, width, height, color):
        Flowable.__init__(self)
        self.width = width
        self.height = height
        self.color = color

    def draw(self):
        self.canv.setFillColor(self.color)
        self.canv.roundRect(0, 0, self.width, self.height, 3, fill=1, stroke=0)

class SkillBar(Flowable):
    def __init__(self, label, percentage, width=140*mm):
        Flowable.__init__(self)
        self.label = label
        self.percentage = percentage
        self.width = width
        self.height = 18

    def draw(self):
        self.canv.setFont("Helvetica", 8)
        self.canv.setFillColor(DARK_TEXT)
        self.canv.drawString(0, 5, self.label)
        bar_x = 55*mm
        bar_w = self.width - 60*mm
        # Background bar
        self.canv.setFillColor(HexColor("#e9ecef"))
        self.canv.roundRect(bar_x, 2, bar_w, 10, 4, fill=1, stroke=0)
        # Filled bar
        self.canv.setFillColor(HIGHLIGHT)
        self.canv.roundRect(bar_x, 2, bar_w * self.percentage / 100, 10, 4, fill=1, stroke=0)
        # Percentage text
        self.canv.setFillColor(SUBTLE)
        self.canv.setFont("Helvetica", 7)
        self.canv.drawString(bar_x + bar_w + 3, 3, f"{self.percentage}%")


def build_pdf():
    output_path = "/Users/harshshah92/Documents/GitHub/HarshShah_Portfolio/Docs/Harsh_Portfolio_20260614.pdf"
    
    doc = SimpleDocTemplate(
        output_path,
        pagesize=A4,
        rightMargin=15*mm,
        leftMargin=15*mm,
        topMargin=12*mm,
        bottomMargin=12*mm,
    )

    styles = getSampleStyleSheet()
    
    # Custom styles
    title_style = ParagraphStyle('Title', parent=styles['Title'], fontSize=28, textColor=PRIMARY, spaceAfter=2*mm, fontName='Helvetica-Bold')
    subtitle_style = ParagraphStyle('Subtitle', parent=styles['Normal'], fontSize=13, textColor=HIGHLIGHT, spaceAfter=4*mm, fontName='Helvetica')
    section_style = ParagraphStyle('Section', parent=styles['Heading2'], fontSize=14, textColor=PRIMARY, spaceBefore=6*mm, spaceAfter=3*mm, fontName='Helvetica-Bold', borderPadding=0)
    body_style = ParagraphStyle('Body', parent=styles['Normal'], fontSize=9.5, textColor=DARK_TEXT, leading=14, alignment=TA_JUSTIFY)
    summary_style = ParagraphStyle('Summary', parent=styles['Normal'], fontSize=10, textColor=DARK_TEXT, leading=15, alignment=TA_JUSTIFY, spaceBefore=2*mm, spaceAfter=4*mm)
    proj_title_style = ParagraphStyle('ProjTitle', parent=styles['Heading3'], fontSize=12, textColor=HIGHLIGHT, spaceBefore=5*mm, spaceAfter=1*mm, fontName='Helvetica-Bold')
    proj_desc_style = ParagraphStyle('ProjDesc', parent=styles['Normal'], fontSize=10.5, textColor=DARK_TEXT, leading=14, alignment=TA_JUSTIFY, spaceAfter=2*mm)
    bullet_style = ParagraphStyle('Bullet', parent=styles['Normal'], fontSize=9, textColor=DARK_TEXT, leading=13, leftIndent=10, bulletIndent=0, spaceBefore=1)
    tech_style = ParagraphStyle('Tech', parent=styles['Normal'], fontSize=8.5, textColor=HIGHLIGHT, leading=12, spaceBefore=2*mm)
    role_style = ParagraphStyle('Role', parent=styles['Normal'], fontSize=10, textColor=DARK_TEXT, leading=14, spaceBefore=1*mm, fontName='Helvetica-Bold')
    period_style = ParagraphStyle('Period', parent=styles['Normal'], fontSize=9, textColor=SUBTLE, leading=12)
    stats_style = ParagraphStyle('Stats', parent=styles['Normal'], fontSize=22, textColor=PRIMARY, alignment=TA_CENTER, fontName='Helvetica-Bold', spaceAfter=0)
    stats_label = ParagraphStyle('StatsLabel', parent=styles['Normal'], fontSize=8, textColor=SUBTLE, alignment=TA_CENTER)
    small_style = ParagraphStyle('Small', parent=styles['Normal'], fontSize=9.5, textColor=SUBTLE, leading=13)

    elements = []

    # ===== PAGE 1: HEADER & OVERVIEW =====
    elements.append(Spacer(1, 5*mm))
    elements.append(ColorBar(WIDTH - 30*mm, 3, GOLD))
    elements.append(Spacer(1, 6*mm))
    elements.append(Paragraph("HARSH", title_style))
    elements.append(Spacer(1, 4*mm))
    elements.append(Paragraph("Senior Mobile & Full Stack Engineer", subtitle_style))
    elements.append(Spacer(1, 2*mm))
    
    # Professional Summary
    elements.append(Paragraph(
        "Results-driven Senior Engineer with <b>9+ years</b> of hands-on experience architecting and delivering "
        "enterprise-grade mobile and full-stack applications. Specialized in cross-platform mobile development using "
        "<b>Xamarin.Forms, .NET MAUI, and Flutter</b>, coupled with robust backend systems built on <b>ASP.NET Core, "
        "FastAPI, SQL Server, and Supabase</b>. Passionate about integrating <b>AI/ML capabilities</b> into production "
        "applications using Python, Ollama, and modern LLM frameworks. Proven track record across healthcare, "
        "hospitality, logistics, finance, and real-time communication domains.",
        summary_style
    ))

    elements.append(Spacer(1, 3*mm))

    # Stats row
    stats_data = [
        [Paragraph("9+", stats_style), Paragraph("11+", stats_style), Paragraph("5", stats_style), Paragraph("3+", stats_style)],
        [Paragraph("Years Experience", stats_label), Paragraph("Projects Delivered", stats_label), Paragraph("Platforms", stats_label), Paragraph("AI Projects", stats_label)],
    ]
    stats_table = Table(stats_data, colWidths=[(WIDTH-30*mm)/4]*4, rowHeights=[14*mm, 8*mm])
    stats_table.setStyle(TableStyle([
        ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
        ('VALIGN', (0, 0), (-1, 0), 'TOP'),
        ('VALIGN', (0, 1), (-1, 1), 'TOP'),
        ('TOPPADDING', (0, 0), (-1, 0), 12),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 0),
        ('TOPPADDING', (0, 1), (-1, 1), 0),
        ('BOTTOMPADDING', (0, 1), (-1, 1), 10),
        ('BACKGROUND', (0, 0), (-1, -1), LIGHT_BG),
        ('ROUNDEDCORNERS', [5, 5, 5, 5]),
    ]))
    elements.append(stats_table)
    elements.append(Spacer(1, 5*mm))

    # Work Experience
    elements.append(HRFlowable(width="100%", thickness=0.5, color=HexColor("#dee2e6")))
    elements.append(Paragraph("CAREER TRAJECTORY", section_style))

    experiences = [
        ("Senior Software Engineer", "Jan 2026 – Present", "Leading architecture & development of enterprise mobile apps, AI integration, and full-stack solutions."),
        ("Xamarin Developer", "Jan 2022 – Dec 2025", "Designed and delivered cross-platform mobile applications for healthcare, logistics, and hospitality using Xamarin.Forms & .NET MAUI."),
        ("Associate Software Engineer", "Jun 2017 – Dec 2021", "Built foundational mobile and backend systems, REST APIs, database design, and client-facing applications."),
    ]

    for role, period, desc in experiences:
        elements.append(Paragraph(f"▸ {role}", role_style))
        elements.append(Paragraph(period, period_style))
        elements.append(Paragraph(desc, body_style))
        elements.append(Spacer(1, 2*mm))

    # Core Skills & Technologies
    elements.append(Spacer(1, 3*mm))
    elements.append(HRFlowable(width="100%", thickness=0.5, color=HexColor("#dee2e6")))
    elements.append(Paragraph("CORE SKILLS & TECHNOLOGIES", section_style))

    skills_data = [
        ["MOBILE", ".NET MAUI · Xamarin.Forms · Flutter · Dart · C# · MVVM"],
        ["BACKEND", "ASP.NET Core · FastAPI · REST APIs · Entity Framework · Python"],
        ["AI / ML", "Ollama · LLM Integration · AI Pipelines · Computer Vision"],
        ["CLOUD & DB", "SQL Server · Supabase · SQLite · Azure · Serverless"],
        ["TOOLS", "Visual Studio · VS Code · Git · Postman · Agile / Scrum"],
        ["OTHER", "HIPAA · HL7 · Real-time Chat · BLE · Cross-platform"],
    ]

    cat_style = ParagraphStyle('cat', fontSize=9, textColor=HIGHLIGHT, fontName='Helvetica-Bold')
    tech_style_cell = ParagraphStyle('techcell', fontSize=9, textColor=DARK_TEXT, leading=13)
    skills_table_data = [[Paragraph(f"<b>{cat}</b>", cat_style), Paragraph(techs, tech_style_cell)] for cat, techs in skills_data]
    skills_table = Table(skills_table_data, colWidths=[28*mm, 147*mm])
    skills_table.setStyle(TableStyle([
        ('VALIGN', (0, 0), (-1, -1), 'MIDDLE'),
        ('TOPPADDING', (0, 0), (-1, -1), 5),
        ('BOTTOMPADDING', (0, 0), (-1, -1), 5),
        ('LINEBELOW', (0, 0), (-1, -2), 0.3, HexColor("#dee2e6")),
        ('LEFTPADDING', (0, 0), (0, -1), 4),
        ('BACKGROUND', (0, 0), (-1, -1), LIGHT_BG),
    ]))
    elements.append(skills_table)

    # ===== PAGE 2+: PROJECT PORTFOLIO =====
    elements.append(PageBreak())
    elements.append(ColorBar(WIDTH - 30*mm, 3, GOLD))
    elements.append(Spacer(1, 4*mm))
    elements.append(Paragraph("PROJECT PORTFOLIO (11 Projects)", section_style))
    elements.append(Paragraph(
        "A curated collection of production applications spanning healthcare, AI, hospitality, logistics, and finance — "
        "demonstrating depth in mobile engineering, backend architecture, and AI integration.",
        small_style
    ))
    elements.append(Spacer(1, 3*mm))

    projects = [
        {
            "num": 1,
            "title": "HealthxApp for Patients",
            "subtitle": "Enterprise Healthcare Platform – Patient Portal",
            "desc": "A comprehensive patient-facing mobile application enabling appointment scheduling, secure document management, HIPAA-compliant video consultations, and real-time chat with healthcare providers.",
            "bullets": [
                "Built end-to-end appointment booking with provider availability and calendar sync",
                "Implemented secure video consultation using WebRTC with encrypted streams",
                "Developed real-time chat system with message history and push notifications",
                "Integrated HL7/FHIR standards for healthcare data interoperability",
                "Document upload/download with secure cloud storage and access control",
                "HIPAA-compliant data handling with encryption at rest and in transit",
                "Offline-first architecture with background sync for poor connectivity scenarios",
                "Role-based access control separating patient, provider, and admin flows",
            ],
            "tech": "Xamarin.Forms · C# · ASP.NET Core API · SQL Server · HL7 · HIPAA · MVVM · Push Notifications",
        },
        {
            "num": 2,
            "title": "HealthxApp for Providers",
            "subtitle": "Enterprise Healthcare Platform – Provider Dashboard",
            "desc": "Provider-facing companion application enabling doctors and clinical staff to manage appointments, review patient documents, conduct video consultations, and communicate securely with patients.",
            "bullets": [
                "Appointment management dashboard with schedule overview and conflict detection",
                "Patient document review system with annotation and approval workflows",
                "Video consultation initiation with recording capability for medical records",
                "Secure messaging with read receipts, typing indicators, and file sharing",
                "Integration with hospital EMR systems via HL7 interfaces",
                "Multi-location support for providers practising across clinics",
                "Analytics dashboard showing consultation metrics and patient engagement",
                "Notification system for urgent patient requests and schedule changes",
            ],
            "tech": "Xamarin.Forms · C# · ASP.NET Core API · SQL Server · HL7 · HIPAA · MVVM · WebRTC",
        },
        {
            "num": 3,
            "title": "Clipboard",
            "subtitle": "Patient Intake & Clinical Workflow Management",
            "desc": "Digital patient intake solution replacing paper-based processes — handling appointments, consent forms, questionnaires, and medical history management with seamless offline support.",
            "bullets": [
                "Dynamic consent form builder with e-signature capture and PDF generation",
                "Configurable medical questionnaires with conditional logic and branching",
                "Complete medical history intake with allergies, medications, and conditions",
                "Offline-first SQLite storage with intelligent background synchronisation",
                "Migrated from Xamarin.Forms to .NET MAUI for long-term platform support",
                "Barcode scanning for patient identification and record lookup",
                "Multi-language support for diverse patient demographics",
                "Seamless integration with backend .NET Core APIs and SQL Server",
            ],
            "tech": "Xamarin.Forms · .NET MAUI · C# · SQLite · SQL Server · .NET Core API · MVVM · Offline Sync",
        },
        {
            "num": 4,
            "title": "SMD Mobile",
            "subtitle": "Hospital & Clinic Management System",
            "desc": "Comprehensive hospital and clinic management mobile application covering patient records, medicine inventory, appointment scheduling, and clinical workflow automation.",
            "bullets": [
                "Patient registration and record management with search and filtering",
                "Medicine inventory tracking with stock alerts and expiry management",
                "Appointment scheduling with provider calendars and automated reminders",
                "Migrated entire codebase from Xamarin.Forms to .NET MAUI",
                "Improved startup time and memory efficiency via framework optimisation",
                "REST API integration for secure, real-time backend communication",
                "Resolved Android/iOS platform-specific UI and compatibility issues",
                "Extensive testing, debugging, and production performance tuning",
            ],
            "tech": "Xamarin.Forms · .NET MAUI · C# · SQLite · SQL Server · .NET Core API · MVVM · REST APIs",
        },
        {
            "num": 5,
            "title": "LogicWash",
            "subtitle": "Commercial Car Wash Management Solution",
            "desc": "A streamlined mobile solution for managing commercial car wash operations — handling service queues, customer management, wash tracking, and operational analytics.",
            "bullets": [
                "Service queue management with real-time status tracking",
                "Customer profile management with wash history and preferences",
                "Multiple wash package configuration with pricing tiers",
                "Offline-capable SQLite storage for uninterrupted operations",
                "Staff scheduling and performance tracking dashboards",
                "Revenue reporting with daily, weekly, and monthly breakdowns",
                "Push notifications for service completion and promotional offers",
                "Clean MVVM architecture ensuring maintainability and testability",
            ],
            "tech": ".NET MAUI · C# · SQLite · MVVM · Local Storage · Cross-platform",
        },
        {
            "num": 6,
            "title": "Digital Butler",
            "subtitle": "AI-Powered Hotel & Resort Guest Management Platform",
            "desc": "An intelligent hospitality platform leveraging AI to provide personalised guest experiences — from smart room booking and concierge services to AI-driven recommendations and guest communication.",
            "bullets": [
                "AI-powered concierge chatbot using Ollama LLM for natural guest interactions",
                "Smart room booking with dynamic pricing and availability optimisation",
                "Guest preference learning system for personalised service recommendations",
                "Real-time communication between guests and hotel staff via chat",
                "Integration with hotel PMS for room status, housekeeping, and maintenance",
                "Multi-property support with centralised management dashboard",
                "Supabase real-time database for instant updates across all clients",
                "Python FastAPI backend with AI pipeline orchestration",
            ],
            "tech": "Flutter · Dart · Supabase · Python · FastAPI · AI · Ollama · Real-time DB · Cross-platform",
        },
        {
            "num": 7,
            "title": "SmartLogix",
            "subtitle": "AI-Powered Shipment & Logistics Tracking Platform",
            "desc": "Intelligent logistics platform that uses AI for shipment registration, route optimisation, delivery prediction, and real-time tracking — transforming traditional shipping workflows.",
            "bullets": [
                "AI-driven shipment registration with automatic data extraction from documents",
                "Real-time GPS tracking with estimated delivery time predictions",
                "Route optimisation engine using ML models for cost and time efficiency",
                "Automated status updates with intelligent notification triggers",
                "Document scanning and OCR for bills of lading and shipping labels",
                "Analytics dashboard with shipment performance metrics and trends",
                "Multi-carrier integration with unified tracking interface",
                "Supabase real-time sync for instant status propagation",
            ],
            "tech": "Flutter · Dart · Supabase · Python · FastAPI · AI · Ollama · OCR · Real-time Tracking",
        },
        {
            "num": 8,
            "title": "ReconVision",
            "subtitle": "AI Platform for Crime & Anomaly Detection",
            "desc": "Advanced AI-powered surveillance and analytics platform combining computer vision for crime detection, facial recognition, violence detection, and behavioural analytics in real-time video feeds.",
            "bullets": [
                "Real-time video feed analysis with computer vision models for anomaly detection",
                "Face detection and recognition with configurable alert thresholds",
                "Violence and aggressive behaviour detection using trained ML models",
                "Analytics dashboard with heat maps, incident timelines, and trend analysis",
                "Multi-camera support with centralised monitoring interface",
                "Alert system with configurable escalation workflows",
                "Historical incident search with video playback and evidence export",
                "Python AI pipeline with Ollama integration for contextual analysis",
            ],
            "tech": "Flutter · Dart · Supabase · Python · FastAPI · AI · Ollama · Computer Vision · Analytics",
        },
        {
            "num": 9,
            "title": "Pinglet",
            "subtitle": "Real-Time Chat Application",
            "desc": "A modern, performant real-time messaging application with instant message delivery, presence indicators, media sharing, and group conversation support.",
            "bullets": [
                "Real-time messaging with sub-second delivery using Supabase Realtime",
                "Online/offline presence indicators with last-seen timestamps",
                "Media sharing including images, documents, and voice messages",
                "Group chat creation and management with admin controls",
                "Message read receipts and typing indicators",
                "Push notifications for background message delivery",
                "End-to-end message history with search functionality",
                "Clean Material Design UI with smooth animations",
            ],
            "tech": "Flutter · Dart · Supabase · Realtime · Push Notifications · Cross-platform",
        },
        {
            "num": 10,
            "title": "Finance App",
            "subtitle": "Personal Finance & Expense Tracking",
            "desc": "A personal finance management application enabling users to track expenses, set budgets, visualise spending patterns, and gain insights into their financial habits.",
            "bullets": [
                "Expense recording with category tagging and receipt photo capture",
                "Budget creation with configurable limits and overspend alerts",
                "Interactive charts and graphs for spending pattern visualisation",
                "Monthly and yearly financial summaries with export capability",
                "Recurring expense tracking with automatic categorisation",
                "Multi-currency support with real-time conversion rates",
                "Secure authentication with biometric login support",
                "Cloud sync via Supabase for multi-device access",
            ],
            "tech": "Flutter · Dart · Supabase · Charts · Cross-platform · Biometric Auth",
        },
        {
            "num": 11,
            "title": "GalleryHub",
            "subtitle": "Cross-Platform Smart Gallery & Media Manager",
            "desc": "A cross-platform gallery application built with Flutter — ported from .NET MAUI. Features rich media browsing with grid/list layouts, folder organisation, full-resolution image viewing, native video playback, camera capture, and batch operations.",
            "bullets": [
                "Gallery view with grid (2/3/4 columns) or list layout, grouped by date",
                "Folder browsing with media organized by albums with cover thumbnails",
                "Full-resolution image viewer with pinch-to-zoom using PhotoView",
                "Native video player with play/pause and progress scrubbing",
                "Share single or multiple media items via system share sheet",
                "Delete and rename media files with platform-specific handling",
                "Camera capture for photos and videos directly from the app",
                "Theme support with System, Light, and Dark modes with persistent preference",
                "Multi-select selection mode for batch delete or share operations",
                "Animated auto-hiding header and floating pill-shaped bottom navigation",
            ],
            "tech": "Flutter · Dart · Provider · photo_manager · video_player · Cross-platform",
        },
    ]

    for proj in projects:
        elements.append(Spacer(1, 2*mm))
        # Project number badge + title
        elements.append(Paragraph(
            f'<font color="{GOLD.hexval()}" size="11"><b>{proj["num"]}</b></font>&nbsp;&nbsp;'
            f'<font color="{PRIMARY.hexval()}" size="12"><b>{proj["title"]}</b></font>',
            ParagraphStyle('pt', fontSize=12, leading=16, spaceBefore=3*mm)
        ))
        elements.append(Paragraph(proj["subtitle"], ParagraphStyle('pst', fontSize=9, textColor=SUBTLE, leading=12, leftIndent=7*mm)))
        elements.append(Spacer(1, 1*mm))
        proj_desc_indented = ParagraphStyle('ProjDescInd', parent=proj_desc_style, leftIndent=7*mm)
        elements.append(Paragraph(proj["desc"], proj_desc_indented))

        # Bullets in 2-column layout
        half = len(proj["bullets"]) // 2
        left_bullets = proj["bullets"][:half]
        right_bullets = proj["bullets"][half:]

        left_text = "<br/>".join([f"<font color='{GOLD.hexval()}'>●</font> {b}" for b in left_bullets])
        right_text = "<br/>".join([f"<font color='{GOLD.hexval()}'>●</font> {b}" for b in right_bullets])

        col_style = ParagraphStyle('col', fontSize=9, textColor=DARK_TEXT, leading=13)
        bullet_table = Table(
            [[Paragraph(left_text, col_style), Paragraph(right_text, col_style)]],
            colWidths=[(WIDTH-38*mm)/2, (WIDTH-38*mm)/2],
        )
        bullet_table.setStyle(TableStyle([
            ('VALIGN', (0, 0), (-1, -1), 'TOP'),
            ('LEFTPADDING', (0, 0), (0, -1), 7*mm),
            ('LEFTPADDING', (1, 0), (-1, -1), 2),
            ('RIGHTPADDING', (0, 0), (-1, -1), 2),
            ('TOPPADDING', (0, 0), (-1, -1), 2),
            ('BOTTOMPADDING', (0, 0), (-1, -1), 2),
        ]))
        elements.append(bullet_table)

        # Tech tags
        elements.append(Spacer(1, 1.5*mm))
        tech_tags = " · ".join([f"[{t.strip()}]" for t in proj["tech"].split("·")])
        elements.append(Paragraph(
            f'<font color="{HIGHLIGHT.hexval()}" size="8"><b>Tech:</b> {tech_tags}</font>',
            ParagraphStyle('techline', fontSize=8, leading=11, textColor=HIGHLIGHT, leftIndent=7*mm)
        ))
        elements.append(Spacer(1, 1*mm))
        elements.append(HRFlowable(width="100%", thickness=0.3, color=HexColor("#dee2e6")))

    # Footer note
    elements.append(Spacer(1, 8*mm))
    elements.append(ColorBar(WIDTH - 30*mm, 2, GOLD))
    elements.append(Spacer(1, 3*mm))
    elements.append(Paragraph(
        "This portfolio represents a curated selection of production applications. "
        "Each project demonstrates expertise in architecture design, clean code practices, "
        "and delivering real business value through technology.",
        ParagraphStyle('footer', fontSize=8, textColor=SUBTLE, alignment=TA_CENTER, leading=11)
    ))

    doc.build(elements)
    print(f"✅ Portfolio generated: {output_path}")


if __name__ == "__main__":
    build_pdf()
