import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/farm_models.dart';
import '../../providers/farm_provider.dart';

class FieldsScreen extends StatelessWidget {
  const FieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FarmProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Field Management')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _add(context),
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
        itemCount: provider.fields.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.3),
        itemBuilder: (_, i) {
          final item = provider.fields[i];
          return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)), Text(item.cropType), Text(item.notes)])));
        },
      ),
    );
  }

  void _add(BuildContext context) {
    final name = TextEditingController();
    final crop = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Field'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: name, decoration: const InputDecoration(labelText: 'Field Name')), TextField(controller: crop, decoration: const InputDecoration(labelText: 'Crop Type'))]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          FilledButton(
              onPressed: () {
                context.read<FarmProvider>().addField(FieldRecord(name: name.text, cropType: crop.text));
                Navigator.pop(context);
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
