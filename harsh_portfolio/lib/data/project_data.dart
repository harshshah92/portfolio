import '../models/project_model.dart';

class ProjectData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      id: 'pinglet',
      title: 'Pinglet',
      subtitle: 'Real-Time Chat Application',
      domain: 'Communication',
      overview:
          'A modern, performant real-time messaging application with instant message delivery, presence indicators, media sharing, and group conversation support.',
      techStack: [
        'Flutter',
        'Dart',
        'Supabase',
        'Realtime',
        'Push Notifications',
        'Cross-platform',
      ],
      features: [
        'Real-time messaging with sub-second delivery using Supabase Realtime',
        'Online/offline presence indicators with last-seen timestamps',
        'Media sharing including images, documents, and voice messages',
        'Group chat creation and management with admin controls',
        'Message read receipts and typing indicators',
        'Push notifications for background message delivery',
        'End-to-end message history with search functionality',
        'Clean Material Design UI with smooth animations',
      ],
      architectureHighlights: [
        'Supabase Realtime for sub-second message delivery',
        'Presence system with online/offline indicators and last-seen tracking',
        'Media upload pipeline for images, documents, and voice messages',
        'Group management with admin controls and member permissions',
        'Message indexing for full-text search across history',
        'Push notification service for background delivery',
      ],
      technicalChallenges: [
        'Achieving sub-second message delivery with reliable ordering guarantees',
        'Implementing presence indicators that accurately reflect user connectivity state',
        'Building media sharing with efficient upload, compression, and delivery across platforms',
        'Designing group chat with admin controls that scale to large member counts',
        'Ensuring message history search performs well across large conversation archives',
      ],
      keyDeliverables: [
        'Real-time messaging app with instant delivery',
        'Presence and typing indicator system',
        'Media sharing with images, documents, and voice',
        'Group chat with admin management',
        'Push notification infrastructure for background delivery',
      ],
      isFeatured: true,
    ),
    ProjectModel(
      id: 'reconvision',
      title: 'ReconVision',
      subtitle: 'AI Platform for Crime & Anomaly Detection',
      domain: 'AI',
      overview:
          'Advanced AI-powered surveillance and analytics platform combining computer vision for crime detection, facial recognition, violence detection, and behavioural analytics in real-time video feeds.',
      techStack: [
        'Flutter',
        'Dart',
        'Supabase',
        'Python',
        'FastAPI',
        'AI',
        'Ollama',
        'Computer Vision',
        'Analytics',
      ],
      features: [
        'Real-time video feed analysis with computer vision models for anomaly detection',
        'Face detection and recognition with configurable alert thresholds',
        'Violence and aggressive behaviour detection using trained ML models',
        'Analytics dashboard with heat maps, incident timelines, and trend analysis',
        'Multi-camera support with centralised monitoring interface',
        'Alert system with configurable escalation workflows',
        'Historical incident search with video playback and evidence export',
        'Python AI pipeline with Ollama integration for contextual analysis',
      ],
      architectureHighlights: [
        'Real-time computer vision pipeline for video feed analysis',
        'Face detection and recognition with configurable threshold engine',
        'ML model inference for violence and behaviour detection',
        'Multi-camera video stream management with centralised processing',
        'Alert escalation workflow engine with configurable rules',
        'Historical data indexing for incident search and evidence retrieval',
      ],
      technicalChallenges: [
        'Processing multiple real-time video feeds with minimal latency for anomaly detection',
        'Training and deploying violence detection ML models with acceptable accuracy rates',
        'Implementing facial recognition with configurable thresholds to balance security and privacy',
        'Building a scalable multi-camera architecture that handles concurrent video streams',
        'Designing an evidence export system that maintains chain-of-custody integrity',
      ],
      keyDeliverables: [
        'Real-time video surveillance and analysis platform',
        'Computer vision models for anomaly and violence detection',
        'Facial recognition system with configurable alerts',
        'Multi-camera centralised monitoring dashboard',
        'Historical incident search and evidence export system',
      ],
      isFeatured: true,
    ),
    ProjectModel(
      id: 'digital-butler',
      title: 'Digital Butler',
      subtitle: 'AI-Powered Hotel & Resort Guest Management Platform',
      domain: 'Hospitality',
      overview:
          'An intelligent hospitality platform leveraging AI to provide personalised guest experiences — from smart room booking and concierge services to AI-driven recommendations and guest communication.',
      techStack: [
        'Flutter',
        'Dart',
        'Supabase',
        'Python',
        'FastAPI',
        'AI',
        'Ollama',
        'Real-time DB',
        'Cross-platform',
      ],
      features: [
        'AI-powered concierge chatbot using Ollama LLM for natural guest interactions',
        'Smart room booking with dynamic pricing and availability optimisation',
        'Guest preference learning system for personalised service recommendations',
        'Real-time communication between guests and hotel staff via chat',
        'Integration with hotel PMS for room status, housekeeping, and maintenance',
        'Multi-property support with centralised management dashboard',
        'Supabase real-time database for instant updates across all clients',
        'Python FastAPI backend with AI pipeline orchestration',
      ],
      architectureHighlights: [
        'AI pipeline orchestration with Ollama LLM for natural language processing',
        'Guest preference ML model for personalised recommendations',
        'Supabase real-time subscriptions for instant cross-client updates',
        'FastAPI backend with async AI inference pipeline',
        'Multi-property architecture with centralised management layer',
        'Hotel PMS integration layer for room and housekeeping status',
      ],
      technicalChallenges: [
        'Integrating Ollama LLM for natural conversational AI in a hospitality context',
        'Building a guest preference learning system that improves recommendations over time',
        'Implementing dynamic pricing algorithms with real-time availability optimisation',
        'Ensuring real-time communication reliability across multiple hotel properties',
        'Orchestrating AI inference pipelines without impacting response latency',
      ],
      keyDeliverables: [
        'AI-powered concierge chatbot with natural language understanding',
        'Smart room booking system with dynamic pricing',
        'Real-time guest-staff communication platform',
        'Multi-property management dashboard',
        'Guest preference learning and recommendation engine',
      ],
      isFeatured: true,
    ),
    ProjectModel(
      id: 'smartlogix',
      title: 'SmartLogix',
      subtitle: 'AI-Powered Shipment & Logistics Tracking Platform',
      domain: 'Logistics',
      overview:
          'Intelligent logistics platform that uses AI for shipment registration, route optimisation, delivery prediction, and real-time tracking — transforming traditional shipping workflows.',
      techStack: [
        'Flutter',
        'Dart',
        'Supabase',
        'Python',
        'FastAPI',
        'AI',
        'Ollama',
        'OCR',
        'Real-time Tracking',
      ],
      features: [
        'AI-driven shipment registration with automatic data extraction from documents',
        'Real-time GPS tracking with estimated delivery time predictions',
        'Route optimisation engine using ML models for cost and time efficiency',
        'Automated status updates with intelligent notification triggers',
        'Document scanning and OCR for bills of lading and shipping labels',
        'Analytics dashboard with shipment performance metrics and trends',
        'Multi-carrier integration with unified tracking interface',
        'Supabase real-time sync for instant status propagation',
      ],
      architectureHighlights: [
        'AI-driven document processing with OCR extraction pipeline',
        'ML-based route optimisation engine for cost and time efficiency',
        'Real-time GPS tracking with delivery prediction algorithms',
        'Supabase real-time sync for instant multi-client status propagation',
        'Multi-carrier abstraction layer with unified tracking interface',
        'Intelligent notification engine with configurable triggers',
      ],
      technicalChallenges: [
        'Building OCR pipeline that accurately extracts data from diverse shipping documents',
        'Implementing ML-based route optimisation that balances cost, time, and reliability',
        'Real-time GPS tracking with accurate delivery time predictions under variable conditions',
        'Multi-carrier integration with different API formats and tracking protocols',
        'Designing intelligent notification triggers that avoid alert fatigue',
      ],
      keyDeliverables: [
        'AI-powered shipment registration with document OCR',
        'Real-time GPS tracking and delivery prediction system',
        'Route optimisation engine with ML models',
        'Multi-carrier unified tracking platform',
        'Analytics dashboard with performance metrics',
      ],
      isFeatured: false,
    ),
    ProjectModel(
      id: 'finance',
      title: 'Finance App',
      subtitle: 'Personal Finance & Expense Tracking',
      domain: 'Finance',
      overview:
          'A personal finance management application enabling users to track expenses, set budgets, visualise spending patterns, and gain insights into their financial habits.',
      techStack: [
        'Flutter',
        'Dart',
        'Supabase',
        'Charts',
        'Cross-platform',
        'Biometric Auth',
      ],
      features: [
        'Expense recording with category tagging and receipt photo capture',
        'Budget creation with configurable limits and overspend alerts',
        'Interactive charts and graphs for spending pattern visualisation',
        'Monthly and yearly financial summaries with export capability',
        'Recurring expense tracking with automatic categorisation',
        'Multi-currency support with real-time conversion rates',
        'Secure authentication with biometric login support',
        'Cloud sync via Supabase for multi-device access',
      ],
      architectureHighlights: [
        'Biometric authentication with secure local credential storage',
        'Chart rendering engine for interactive spending visualisations',
        'Recurring expense engine with automatic categorisation rules',
        'Multi-currency layer with real-time conversion rate fetching',
        'Supabase cloud sync for multi-device data consistency',
        'Export pipeline for financial summaries in multiple formats',
      ],
      technicalChallenges: [
        'Implementing biometric authentication across diverse device hardware',
        'Building interactive charts that render smoothly with large datasets',
        'Designing recurring expense logic with accurate automatic categorisation',
        'Multi-currency conversion with reliable rate sources and offline fallback',
        'Cloud sync that handles conflicts when editing from multiple devices',
      ],
      keyDeliverables: [
        'Personal finance tracking app with expense and budget management',
        'Interactive charts and spending pattern visualisation',
        'Multi-currency support with real-time conversion',
        'Biometric authentication and secure access',
        'Cloud-synced multi-device experience',
      ],
      isFeatured: false,
    ),
    ProjectModel(
      id: 'logicwash',
      title: 'LogicWash',
      subtitle: 'Commercial Car Wash Management Solution',
      domain: 'Logistics',
      overview:
          'A streamlined mobile solution for managing commercial car wash operations — handling service queues, customer management, wash tracking, and operational analytics.',
      techStack: [
        '.NET MAUI',
        'C#',
        'SQLite',
        'MVVM',
        'Local Storage',
        'Cross-platform',
      ],
      features: [
        'Service queue management with real-time status tracking',
        'Customer profile management with wash history and preferences',
        'Multiple wash package configuration with pricing tiers',
        'Offline-capable SQLite storage for uninterrupted operations',
        'Staff scheduling and performance tracking dashboards',
        'Revenue reporting with daily, weekly, and monthly breakdowns',
        'Push notifications for service completion and promotional offers',
        'Clean MVVM architecture ensuring maintainability and testability',
      ],
      architectureHighlights: [
        'Clean MVVM architecture with dependency injection',
        'Offline-first SQLite storage for uninterrupted field operations',
        'Queue management system with real-time status propagation',
        'Revenue analytics engine with configurable time-period breakdowns',
        'Push notification service for customer engagement',
      ],
      technicalChallenges: [
        'Designing a real-time queue management system that works reliably offline',
        'Building configurable pricing tiers with dynamic wash package management',
        'Implementing staff scheduling with performance tracking and conflict avoidance',
        'Creating revenue reporting with accurate daily, weekly, and monthly aggregations',
        'Ensuring push notifications are delivered reliably for service completion alerts',
      ],
      keyDeliverables: [
        'Complete car wash management mobile application',
        'Service queue and customer management system',
        'Staff scheduling and performance dashboards',
        'Revenue analytics and reporting module',
        'Offline-capable cross-platform app',
      ],
      isFeatured: false,
    ),
    ProjectModel(
      id: 'smd-mobile',
      title: 'SMD Mobile',
      subtitle: 'Hospital & Clinic Management System',
      domain: 'Healthcare',
      overview:
          'Comprehensive hospital and clinic management mobile application covering patient records, medicine inventory, appointment scheduling, and clinical workflow automation.',
      techStack: [
        'Xamarin.Forms',
        '.NET MAUI',
        'C#',
        'SQLite',
        'SQL Server',
        '.NET Core API',
        'MVVM',
        'REST APIs',
      ],
      features: [
        'Patient registration and record management with search and filtering',
        'Medicine inventory tracking with stock alerts and expiry management',
        'Appointment scheduling with provider calendars and automated reminders',
        'Migrated entire codebase from Xamarin.Forms to .NET MAUI',
        'Improved startup time and memory efficiency via framework optimisation',
        'REST API integration for secure, real-time backend communication',
        'Resolved Android/iOS platform-specific UI and compatibility issues',
        'Extensive testing, debugging, and production performance tuning',
      ],
      architectureHighlights: [
        'Full codebase migration from Xamarin.Forms to .NET MAUI',
        'Performance-optimised startup and memory management',
        'Platform-specific renderers for Android/iOS compatibility',
        'REST API layer with secure authentication and real-time sync',
        'Inventory management module with alert-based triggers',
      ],
      technicalChallenges: [
        'Migrating a large production codebase from Xamarin.Forms to .NET MAUI without downtime',
        'Optimising application startup time and memory usage on resource-constrained devices',
        'Resolving platform-specific rendering issues across Android and iOS simultaneously',
        'Building a reliable medicine inventory system with real-time stock alerts',
        'Performance tuning for production-scale data with search and filtering',
      ],
      keyDeliverables: [
        'Complete hospital management mobile application',
        'Successful Xamarin.Forms to .NET MAUI migration',
        'Performance-optimised app with improved startup and memory usage',
        'Patient records, inventory, and appointment management modules',
        'Cross-platform compatibility across Android and iOS',
      ],
      isFeatured: false,
    ),
    ProjectModel(
      id: 'clipboard',
      title: 'Clipboard',
      subtitle: 'Patient Intake & Clinical Workflow Management',
      domain: 'Healthcare',
      overview:
          'Digital patient intake solution replacing paper-based processes — handling appointments, consent forms, questionnaires, and medical history management with seamless offline support.',
      techStack: [
        'Xamarin.Forms',
        '.NET MAUI',
        'C#',
        'SQLite',
        'SQL Server',
        '.NET Core API',
        'MVVM',
        'Offline Sync',
      ],
      features: [
        'Dynamic consent form builder with e-signature capture and PDF generation',
        'Configurable medical questionnaires with conditional logic and branching',
        'Complete medical history intake with allergies, medications, and conditions',
        'Offline-first SQLite storage with intelligent background synchronisation',
        'Migrated from Xamarin.Forms to .NET MAUI for long-term platform support',
        'Barcode scanning for patient identification and record lookup',
        'Multi-language support for diverse patient demographics',
        'Seamless integration with backend .NET Core APIs and SQL Server',
      ],
      architectureHighlights: [
        'Form engine with conditional logic, branching, and dynamic rendering',
        'E-signature capture with PDF generation pipeline',
        'Offline-first SQLite with conflict resolution and background sync',
        'Migration architecture from Xamarin.Forms to .NET MAUI',
        'Barcode scanning integration for patient identification',
        'Localisation framework for multi-language support',
      ],
      technicalChallenges: [
        'Designing a flexible form builder engine supporting conditional logic and branching paths',
        'Migrating a production Xamarin.Forms app to .NET MAUI while maintaining feature parity',
        'Implementing e-signature capture that produces legally valid PDF documents',
        'Building reliable offline sync with conflict resolution for medical data',
        'Supporting barcode scanning across diverse device hardware capabilities',
      ],
      keyDeliverables: [
        'Digital patient intake system replacing paper workflows',
        'Dynamic form builder with e-signature and PDF generation',
        'Successfully migrated application from Xamarin.Forms to .NET MAUI',
        'Offline-capable data layer with intelligent synchronisation',
        'Multi-language patient-facing interface',
      ],
      isFeatured: false,
    ),
    ProjectModel(
      id: 'healthx-patients',
      title: 'HealthxApp for Patients',
      subtitle: 'Enterprise Healthcare Platform – Patient Portal',
      domain: 'Healthcare',
      overview:
          'A comprehensive patient-facing mobile application enabling appointment scheduling, secure document management, HIPAA-compliant video consultations, and real-time chat with healthcare providers.',
      techStack: [
        'Xamarin.Forms',
        'C#',
        'ASP.NET Core API',
        'SQL Server',
        'HL7',
        'HIPAA',
        'MVVM',
        'Push Notifications',
      ],
      features: [
        'Built end-to-end appointment booking with provider availability and calendar sync',
        'Implemented secure video consultation using WebRTC with encrypted streams',
        'Developed real-time chat system with message history and push notifications',
        'Integrated HL7/FHIR standards for healthcare data interoperability',
        'Document upload/download with secure cloud storage and access control',
        'HIPAA-compliant data handling with encryption at rest and in transit',
        'Offline-first architecture with background sync for poor connectivity scenarios',
        'Role-based access control separating patient, provider, and admin flows',
      ],
      architectureHighlights: [
        'MVVM pattern with clean separation of concerns',
        'Offline-first architecture with SQLite local cache and background synchronisation',
        'WebRTC integration for peer-to-peer encrypted video streams',
        'HL7/FHIR compliant data layer for healthcare interoperability',
        'Role-based middleware for access control across patient, provider, and admin',
        'Push notification service with real-time message delivery',
      ],
      technicalChallenges: [
        'Ensuring HIPAA compliance across all data flows including video, chat, and document storage',
        'Implementing reliable offline-first sync without data conflicts in a multi-user healthcare environment',
        'Integrating WebRTC for video consultations with fallback mechanisms for unstable connections',
        'Achieving HL7/FHIR interoperability with diverse hospital systems and EHR platforms',
        'Managing encrypted data at rest and in transit while maintaining app performance',
      ],
      keyDeliverables: [
        'Production-ready patient portal with appointment, video, chat, and document modules',
        'HIPAA-compliant architecture documentation and security audit clearance',
        'Offline-capable mobile app with intelligent background sync',
        'HL7/FHIR integration layer for healthcare data exchange',
        'Scalable push notification infrastructure',
      ],
      isFeatured: true,
    ),
    ProjectModel(
      id: 'healthx-providers',
      title: 'HealthxApp for Providers',
      subtitle: 'Enterprise Healthcare Platform – Provider Dashboard',
      domain: 'Healthcare',
      overview:
          'Provider-facing companion application enabling doctors and clinical staff to manage appointments, review patient documents, conduct video consultations, and communicate securely with patients.',
      techStack: [
        'Xamarin.Forms',
        'C#',
        'ASP.NET Core API',
        'SQL Server',
        'HL7',
        'HIPAA',
        'MVVM',
        'WebRTC',
      ],
      features: [
        'Appointment management dashboard with schedule overview and conflict detection',
        'Patient document review system with annotation and approval workflows',
        'Video consultation initiation with recording capability for medical records',
        'Secure messaging with read receipts, typing indicators, and file sharing',
        'Integration with hospital EMR systems via HL7 interfaces',
        'Multi-location support for providers practising across clinics',
        'Analytics dashboard showing consultation metrics and patient engagement',
        'Notification system for urgent patient requests and schedule changes',
      ],
      architectureHighlights: [
        'Dashboard-centric UI with real-time data refresh',
        'HL7 interface layer for EMR system integration',
        'WebRTC with recording pipeline for medical consultation archival',
        'Multi-location data partitioning for provider context switching',
        'Analytics engine with aggregated metrics and engagement scoring',
      ],
      technicalChallenges: [
        'Building a conflict detection system for multi-location appointment scheduling',
        'Implementing video recording with HIPAA-compliant storage and retrieval',
        'Integrating with multiple EMR systems each with different HL7 implementation versions',
        'Designing an annotation system for medical documents with approval workflows',
        'Real-time notification prioritisation for urgent vs routine patient communications',
      ],
      keyDeliverables: [
        'Provider dashboard with appointment, document, and analytics modules',
        'Video consultation system with recording and archival capability',
        'HL7 integration adapters for hospital EMR connectivity',
        'Multi-location provider management system',
        'Real-time secure messaging platform with file sharing',
      ],
      isFeatured: false,
    ),
    ProjectModel(
      id: 'galleryhub',
      title: 'GalleryHub',
      subtitle: 'Cross-Platform Smart Gallery & Media Manager',
      domain: 'AI',
      overview:
          'A cross-platform gallery application built with Flutter — ported from .NET MAUI. Features a rich media browsing experience with grid/list layouts, folder organisation, full-resolution image viewing, native video playback, camera capture, and batch operations for managing device media.',
      techStack: [
        'Flutter',
        'Dart',
        'Provider',
        'photo_manager',
        'video_player',
        'Cross-platform',
      ],
      features: [
        'Gallery view with grid (2/3/4 columns) or list layout, grouped by date',
        'Folder browsing with media organized by albums/folders with cover thumbnails',
        'Full-resolution image viewer with pinch-to-zoom using PhotoView',
        'Native video player with play/pause and progress scrubbing',
        'Share single or multiple media items via system share sheet',
        'Delete media from device with confirmation dialog',
        'Rename media files with platform-specific handling',
        'Camera capture for taking photos or recording videos directly from the app',
        'Theme support with System default, Light, and Dark themes with persistent preference',
        'Settings for theme, grid column count, and grid/list layout preference',
        'Timeline overlay scroll indicator showing date group while scrolling',
        'Animated auto-hiding header on scroll down, reappearing on scroll up',
        'Multi-select selection mode for batch delete or share operations',
        'Floating pill-shaped bottom navigation bar (All / Folders / Settings)',
      ],
      architectureHighlights: [
        'Provider-based state management with GalleryProvider',
        'Service layer abstraction with MediaService and PreferencesService',
        'photo_manager integration for device media access across platforms',
        'Reusable widget architecture for thumbnails, dialogs, and navigation',
        'Persistent user preferences with shared_preferences',
        'Clean separation into models, services, providers, pages, and widgets',
      ],
      technicalChallenges: [
        'Efficiently loading and rendering thousands of media thumbnails without memory pressure',
        'Implementing smooth pinch-to-zoom and gesture handling for full-resolution images',
        'Cross-platform media permission handling for photo and video access',
        'Building a responsive grid that adapts column count and layout mode dynamically',
        'Porting .NET MAUI architecture patterns to Flutter with Provider state management',
      ],
      keyDeliverables: [
        'Cross-platform gallery app with grid and list browsing modes',
        'Full-resolution image viewer with zoom and video playback',
        'Camera capture and media management (share, delete, rename)',
        'Theme system with persistent user preferences',
        'Batch operations with multi-select mode',
      ],
      isFeatured: false,
    ),
  ];

  static List<String> get allDomains =>
      projects.map((p) => p.domain).toSet().toList()..sort();

  static List<String> get allTechnologies {
    final techs = <String>{};
    for (final p in projects) {
      techs.addAll(p.techStack);
    }
    return techs.toList()..sort();
  }

  static List<ProjectModel> get featuredProjects =>
      projects.where((p) => p.isFeatured).toList();

  static ProjectModel? getById(String id) {
    try {
      return projects.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<ProjectModel> filterByDomain(String domain) =>
      projects.where((p) => p.domain == domain).toList();

  static List<ProjectModel> filterByTechnology(String tech) =>
      projects.where((p) => p.techStack.contains(tech)).toList();

  static List<ProjectModel> search(String query) {
    final q = query.toLowerCase();
    return projects.where((p) {
      return p.title.toLowerCase().contains(q) ||
          p.domain.toLowerCase().contains(q) ||
          p.techStack.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  static Map<String, int> get technologyProjectCount {
    final map = <String, int>{};
    for (final p in projects) {
      for (final t in p.techStack) {
        map[t] = (map[t] ?? 0) + 1;
      }
    }
    return map;
  }

  static const Map<String, List<String>> technologyGroups = {
    'Mobile': ['.NET MAUI', 'Xamarin.Forms', 'Flutter', 'Dart', 'C#', 'MVVM'],
    'Backend': ['ASP.NET Core', 'FastAPI', 'REST APIs', 'Entity Framework', 'Python', '.NET Core API', 'ASP.NET Core API'],
    'AI': ['Ollama', 'LLM Integration', 'AI Pipelines', 'Computer Vision', 'AI', 'OCR'],
    'Database': ['SQL Server', 'Supabase', 'SQLite'],
    'Cloud': ['Azure', 'Serverless', 'Real-time DB', 'Realtime'],
  };
}
