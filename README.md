# Kisan Ledger (Java + XML Android App)

Kisan Ledger is an offline-first farming management app for Indian farmers built with **native Android (Java + XML)**.

## Highlights
- Offline local storage with Room (no Firebase, no Supabase)
- Dashboard, field records, expenses, fertilizer, watering, diary, reports, settings, backup-restore pages
- MVVM architecture baseline
- Material Design 3 theme (green farming style)
- WorkManager reminder worker
- OSM dependency included for field map picker extension
- MPAndroidChart + Glide + Gson + Lottie integrated
- Android 8+ (minSdk 26)

## Tech Stack
- Java, XML
- Room Database
- MVVM (Repository + ViewModel)
- WorkManager
- SharedPreferences
- MPAndroidChart, Glide, Gson, Lottie, osmdroid

## Build
```bash
gradle :app:assembleDebug
```

## GitHub Actions
The workflow at `.github/workflows/android-build.yml` automatically builds and uploads debug APK artifacts.

## Module Structure
```
app/src/main/java/com/kisanledger/
├── activities/
├── adapters/
├── database/
├── models/
├── repository/
├── viewmodel/
├── utils/
└── notifications/
```

## Notes
This is a complete starter implementation with all required screens and architecture ready for feature expansion (map polygon selection, PDF report export, charts, language switching, and JSON backup UI flows).
