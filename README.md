# Kisan Ledger (Flutter)

Offline-first farming management app for Indian farmers with Hindi/English support.

## Features
- Dashboard with summary cards and activity
- Field, expense, fertilizer, watering, ploughing, crop timeline records
- Local reminders with `flutter_local_notifications`
- Reports module scaffold and backup/restore JSON export
- Dark/light mode, EN/HI language toggle
- Clean architecture folders for scalability

## Screens (implemented scaffold)
- Splash
- Onboarding
- Dashboard
- Field List
- Expense Tracker
- Fertilizer Scheduler
- Watering Tracker
- Reports
- Settings
- Backup Restore
- Farming Diary

## Tech Stack
- Flutter (Material 3)
- Provider state management
- Hive local storage (offline-only)
- SharedPreferences-ready settings path
- Local notifications
- Google Maps package included for field picking integration

## Setup
```bash
flutter pub get
flutter run
```

## Build Debug APK
```bash
flutter build apk --debug
```

## GitHub Actions
Workflow: `.github/workflows/flutter-build.yml`
- triggers on push
- installs Java + Flutter
- runs pub get
- builds debug APK
- uploads artifact

## Folder Structure
- `lib/screens/`
- `lib/widgets/`
- `lib/models/`
- `lib/services/`
- `lib/database/`
- `lib/providers/`
- `lib/utils/`
- `lib/themes/`
- `lib/localization/`
- `lib/notifications/`

## Screenshot Placeholders
- `docs/screenshots/dashboard.png`
- `docs/screenshots/fields.png`
- `docs/screenshots/reports.png`
