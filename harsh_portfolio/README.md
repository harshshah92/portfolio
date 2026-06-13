# HARSH | Senior Mobile & Full Stack Engineer Portfolio

A premium, responsive, production-ready Flutter Web portfolio showcasing 10+ projects across healthcare, AI, hospitality, logistics, finance, and real-time communication.

## Features

- **Dark & Light Mode** — Toggle between themes
- **Responsive Design** — Mobile-first, works on all screen sizes
- **Smooth Animations** — Flutter Animate for entrance and hover effects
- **Project Search** — Filter by name, domain, or technology
- **Domain Filters** — Healthcare, AI, Hospitality, Logistics, Communication, Finance
- **Technology Filters** — Flutter, Xamarin, .NET MAUI, Supabase, AI, Python, C#
- **Technology Showcase** — Project count per technology
- **Featured Projects** — Highlighted AI, CV, real-time, and healthcare projects
- **PDF Download** — Portfolio document available for download
- **Hash Routing** — GitHub Pages compatible (`/#/projects`, `/#/projects/digital-butler`, etc.)
- **SEO Friendly** — Meta tags, Open Graph, structured content

## Routes

| Route | Page |
|-------|------|
| `/#/` | Home |
| `/#/projects` | All Projects |
| `/#/projects/healthx-patients` | HealthxApp for Patients |
| `/#/projects/healthx-providers` | HealthxApp for Providers |
| `/#/projects/clipboard` | Clipboard |
| `/#/projects/smd-mobile` | SMD Mobile |
| `/#/projects/logicwash` | LogicWash |
| `/#/projects/digital-butler` | Digital Butler |
| `/#/projects/smartlogix` | SmartLogix |
| `/#/projects/reconvision` | ReconVision |
| `/#/projects/pinglet` | Pinglet |
| `/#/projects/finance` | Finance App |

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── config/
│   └── routes.dart            # Named route configuration
├── data/
│   └── project_data.dart      # All project data from PDF
├── models/
│   └── project_model.dart     # Project data model
├── screens/
│   ├── home_screen.dart       # Home with hero, stats, career, skills
│   ├── projects_screen.dart   # Projects list with search & filters
│   └── project_detail_screen.dart  # Individual project detail
├── theme/
│   └── app_theme.dart         # Light & dark theme configuration
├── utils/
│   └── responsive.dart        # Responsive breakpoint utilities
└── widgets/
    ├── nav_bar.dart           # Sticky navigation bar
    ├── section_title.dart     # Reusable section header
    ├── project_card.dart      # Project card with hover effects
    ├── tech_chip.dart         # Technology filter chip
    └── footer.dart            # App footer
```

## Build

```bash
flutter pub get
flutter build web --release
```

Build output will be in `build/web/`.

## Run Locally

```bash
flutter run -d chrome
```

## Deploy to GitHub Pages

### Option 1: Manual Deployment

1. Build the project:
   ```bash
   flutter build web --release --base-href "/YOUR_REPO_NAME/"
   ```

2. Copy `build/web/` contents to a `gh-pages` branch or `/docs` folder.

3. In GitHub repo settings → Pages → set source to the branch/folder.

### Option 2: GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.41.9'
          channel: 'stable'
      
      - run: flutter pub get
      - run: flutter build web --release --base-href "/YOUR_REPO_NAME/"
      
      - uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build/web
```

Replace `YOUR_REPO_NAME` with your actual repository name.

## Tech Stack

- **Framework:** Flutter 3.41.9 (Web)
- **Language:** Dart 3.11.5
- **State:** ValueNotifier (lightweight, no external state management)
- **Routing:** Named routes with onGenerateRoute
- **Animations:** flutter_animate
- **Fonts:** Google Fonts (Inter)
- **Theme:** Material 3 with custom dark/light themes

## Requirements

- Flutter SDK ≥ 3.11.0
- Dart SDK ≥ 3.11.0
