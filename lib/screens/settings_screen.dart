import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/farm_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farm = context.watch<FarmProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('SettingsScreen')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(child: ListTile(title: const Text('Total expenses'), subtitle: Text('₹ ${farm.totalExpenses.toStringAsFixed(0)}'))),
          Card(child: Column(children: [ListTile(title: const Text('Toggle theme'), onTap: () => context.read<AppProvider>().toggleTheme()), ListTile(title: const Text('Toggle language EN/HI'), onTap: () => context.read<AppProvider>().toggleLanguage())])),
          
          const SizedBox(height: 8),
          const Text('Offline-first module scaffold. Add forms/charts/maps for production.')
        ],
      ),
    );
  }
}
