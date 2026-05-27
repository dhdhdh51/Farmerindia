import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/farm_provider.dart';

class BackupScreen extends StatelessWidget {
  const BackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Text('Export your offline data as JSON.'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              final data = context.read<FarmProvider>().exportJson();
              showDialog(context: context, builder: (_) => AlertDialog(content: SingleChildScrollView(child: Text(data))));
            },
            child: const Text('Export JSON'),
          )
        ]),
      ),
    );
  }
}
