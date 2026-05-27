# Kisan Ledger (Android, Java + XML)

Offline-first farming management app for Indian farmers.

## Stack
- Java + XML
- MVVM architecture
- Room database
- WorkManager reminders
- SharedPreferences settings
- MPAndroidChart, Glide, Gson, Lottie, OSMdroid

## Modules
- Dashboard
- Field Management (map coordinates + crop/soil/image/notes)
- Expense Tracker (category, amount, date, notes)
- Fertilizer Scheduler + reminders
- Watering Tracker + reminders
- Tractor/Ploughing ledger
- Crop Timeline
- Farming Diary
- Reports (monthly, crop-wise, PDF export)
- Backup & Restore (JSON)
- Settings (dark mode, language, currency, reset)

## Build
1. Open in Android Studio Iguana+.
2. Sync Gradle.
3. Run `assembleDebug` or click Run.

## Notes
This scaffold is designed to be lightweight and fully offline (except map tiles).
