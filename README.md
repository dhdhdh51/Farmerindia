# Kisan Ledger 🌾

Kisan Ledger is an offline-first Flutter Android app for Indian farmers to manage fields, expenses, crop lifecycle, irrigation, fertilizer schedules, and farming records with Hindi + English support.

## Features
- Offline local storage with Hive
- Material 3, dark/light mode, green premium UI
- Hindi + English localization toggle
- Dashboard with summary cards and charts
- Field management with map-based coordinate picker
- Expense tracking with categories, filters, pie chart
- Fertilizer, watering, ploughing, crop timeline records
- Daily farming diary
- Reports with local PDF export placeholder + sharing hook
- Backup/restore JSON
- Local notifications for reminders
- Smart offline farming tips and calculators

## Screens (Implemented)
- Splash
- Onboarding
- Home Dashboard
- Fields List & Add Field
- Expense Tracker
- Fertilizer Scheduler
- Watering Tracker
- Reports
- Backup & Restore
- Farming Diary
- Settings

## Screenshots
Add screenshots under `docs/screenshots/` and update this section:
- `dashboard.png`
- `fields.png`
- `expenses.png`
- `reports.png`

## Local Setup
1. Install Flutter stable SDK.
2. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Build Debug APK
```bash
flutter build apk --debug
```

## GitHub Actions
Workflow file: `.github/workflows/flutter-build.yml`
- Triggers on push/pull_request
- Sets up Flutter
- Caches pub packages
- Builds debug APK
- Uploads APK artifact

## Folder Structure
```text
lib/
  database/
  localization/
  models/
  notifications/
  providers/
  screens/
  services/
  themes/
  utils/
  widgets/
```

## Notes
- No Firebase, no Supabase, no backend, no cloud DB.
- App is designed for Android 8+ with local offline-first architecture.
