import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_state.dart';
import 'providers/farm_provider.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState();
  await appState.load();
  final farmProvider = FarmProvider();
  await farmProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => appState),
        ChangeNotifierProvider(create: (_) => farmProvider),
      ],
      child: const KisanLedgerApp(),
    ),
  );
}

class KisanLedgerApp extends StatelessWidget {
  const KisanLedgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return MaterialApp(
      title: 'Kisan Ledger',
      debugShowCheckedModeBanner: false,
      themeMode: appState.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: appState.locale,
      supportedLocales: const [Locale('en'), Locale('hi')],
      home: const SplashScreen(),
    );
  }
}
