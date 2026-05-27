import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/local_db.dart';
import 'notifications/notification_service.dart';
import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDb.init();
  await NotificationService.init();
  runApp(ChangeNotifierProvider(create: (_) => AppProvider(), child: const KisanLedgerApp()));
}

class KisanLedgerApp extends StatelessWidget {
  const KisanLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, app, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kisan Ledger',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: app.mode,
        home: const SplashScreen(),
      );
    });
  }
}
