import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/farm_provider.dart';

class BackupRestoreScreen extends StatelessWidget {
  const BackupRestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farm = context.watch<FarmProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('BackupRestoreScreen')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(child: ListTile(title: const Text('Total expenses'), subtitle: Text('₹ ${farm.totalExpenses.toStringAsFixed(0)}'))),
          
          FilledButton(onPressed: () async { final p = await context.read<FarmProvider>().exportJson(); if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Backup saved: '+p))); }, child: const Text('Export JSON Backup')),
          const SizedBox(height: 8),
          const Text('Offline-first module scaffold. Add forms/charts/maps for production.')
        ],
      ),
    );
  }
}
