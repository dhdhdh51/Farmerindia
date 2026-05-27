# Kisan Ledger (Flutter, Offline-first)

Kisan Ledger is a modern farming management Android app designed for Indian farmers with offline-first architecture.

## Features
- Material 3 UI (light/dark)
- Hindi + English support toggle
- Offline local data with Hive
- Dashboard cards + charts
- Field records and crop details
- Expense tracker categories
- Fertilizer/watering reminders scaffold
- Daily diary and report placeholders
- Backup/export JSON
- GitHub Actions debug APK build

## Screens (Implemented)
- Splash
- Onboarding
- Dashboard
- Field List/Add Field
- Reports (placeholder)
- Settings
- Backup/Restore
- Farming Diary (placeholder)

## Local Setup
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
- Trigger: on push
- Installs Flutter
- Runs `flutter pub get`
- Builds debug APK
- Uploads artifact

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
- `docs/screenshots/expenses.png`
