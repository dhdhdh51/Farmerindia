import 'package:flutter/material.dart';

import 'backup_restore_screen.dart';
import 'dashboard_screen.dart';
import 'diary_screen.dart';
import 'expense_screen.dart';
import 'fertilizer_screen.dart';
import 'field_list_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'watering_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int index = 0;
  final pages = const [DashboardScreen(), FieldListScreen(), ExpenseScreen(), FertilizerScreen(), WateringScreen(), ReportsScreen(), DiaryScreen(), BackupRestoreScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Fields'),
          NavigationDestination(icon: Icon(Icons.currency_rupee), label: 'Expense'),
          NavigationDestination(icon: Icon(Icons.science), label: 'Fertilizer'),
          NavigationDestination(icon: Icon(Icons.water_drop), label: 'Water'),
          NavigationDestination(icon: Icon(Icons.assessment), label: 'Reports'),
          NavigationDestination(icon: Icon(Icons.menu_book), label: 'Diary'),
          NavigationDestination(icon: Icon(Icons.backup), label: 'Backup'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
