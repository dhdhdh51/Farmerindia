# Kisan Ledger (Flutter)

Kisan Ledger is an **offline-first Android farming management app** for Indian farmers.
It supports field records, expenses, fertilizer and watering reminders, crop timelines, reports, PDF-ready reporting hooks, and backup/restore with local JSON.

## Features
- Offline local database using Hive
- Material 3 + light/dark themes
- Hindi + English support
- Dashboard with cards + chart
- Field management with map-based field pin select (OpenStreetMap)
- Expense tracking with categories and charts
- Fertilizer, watering, ploughing, crop timeline records
- Daily farming diary
- Local notification reminders
- Backup/restore JSON
- Settings: theme, language, currency, reset data
- Smart section: tips, seasonal checklist, yield/profit calculators

## Screens (placeholders)
- Splash
- Onboarding
- Dashboard
- Fields
- Expenses
- Fertilizer
- Watering
- Reports
- Diary
- Backup/Restore
- Settings

## Local Setup
```bash
flutter pub get
flutter run
```

## Build debug APK
```bash
flutter build apk --debug
```

## GitHub Actions
Workflow: `.github/workflows/flutter-build.yml`
- Runs on push
- Sets up Flutter
- Caches dependencies
- Builds debug APK
- Uploads APK artifact

## Folder Structure
```text
lib/
  screens/
  widgets/
  models/
  services/
  database/
  providers/
  utils/
  themes/
  localization/
  notifications/
```

## Notes
- No Firebase/Supabase/cloud backend.
- Fully usable offline except map tiles loading.
