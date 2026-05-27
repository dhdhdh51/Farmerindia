import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/farm_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FarmProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Kisan Ledger Dashboard')),
      floatingActionButton: FloatingActionButton.extended(onPressed: () {}, icon: const Icon(Icons.tips_and_updates), label: const Text('Tips')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Wrap(spacing: 12, runSpacing: 12, children: [
          _card('Total Fields', provider.fields.length.toString()),
          _card('Total Expenses', '₹${provider.totalExpenses.toStringAsFixed(0)}'),
          _card('Reminders', provider.reminders.length.toString()),
        ]),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: PieChart(PieChartData(sections: [
                PieChartSectionData(value: provider.totalExpenses == 0 ? 1 : provider.totalExpenses, title: 'Expenses'),
              ])),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _card(String title, String value) => SizedBox(width: 170, child: Card(child: ListTile(title: Text(title), subtitle: Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))));
}
