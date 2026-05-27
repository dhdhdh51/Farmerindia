import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/local_db.dart';
import 'localization/app_localizations.dart';
import 'notifications/notification_service.dart';
import 'providers/app_provider.dart';
import 'providers/farm_provider.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDb.init();
  await NotificationService.init();

  final appProvider = AppProvider();
  await appProvider.loadSettings();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appProvider),
        ChangeNotifierProvider(create: (_) => FarmProvider()..loadAll()),
      ],
      child: const KisanLedgerApp(),
    ),
  );
}

class KisanLedgerApp extends StatelessWidget {
  const KisanLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    return MaterialApp(
      title: 'Kisan Ledger',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: app.themeMode,
      locale: Locale(app.languageCode),
      localizationsDelegates: const [AppLocalizationsDelegate()],
      supportedLocales: const [Locale('en'), Locale('hi')],
      home: const SplashScreen(),
    );
  }
}
