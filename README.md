# Kisan Ledger (Java + XML, Offline-First)

Kisan Ledger is a lightweight Android farming management app for Indian farmers. It is built with **native Android (Java + XML)** and works offline using local storage.

## Highlights
- No login, no OTP, no ads, no cloud dependency
- Room database for local records
- WorkManager for reminder notifications
- Material Design 3 themed UI
- Hindi/English friendly setup
- Expense tracking, field management, diary, reports, backup scaffolding

## Tech Stack
- Java, XML
- Room
- MVVM (Repository + ViewModel)
- WorkManager
- SharedPreferences ready
- MPAndroidChart, Glide, Gson, Lottie

## Modules/Screens
- Splash, Onboarding, Home Dashboard
- Field list + add field
- Expense tracker
- Fertilizer scheduler
- Watering tracker
- Reports
- Farming diary
- Settings
- Backup/restore

## Build
```bash
./gradlew assembleDebug
```

## CI
GitHub Actions workflow at `.github/workflows/android-build.yml` automatically builds and uploads debug APK artifacts.
