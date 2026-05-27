import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../providers/farm_provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farm = context.watch<FarmProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('ReportsScreen')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(child: ListTile(title: const Text('Total expenses'), subtitle: Text('₹ ${farm.totalExpenses.toStringAsFixed(0)}'))),
          
          
          const SizedBox(height: 8),
          const Text('Offline-first module scaffold. Add forms/charts/maps for production.')
        ],
      ),
    );
  }
}
