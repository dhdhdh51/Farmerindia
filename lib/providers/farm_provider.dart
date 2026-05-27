import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class FarmProvider extends ChangeNotifier {
  final fields = <Map>[];
  final expenses = <Map>[];
  final fertilizer = <Map>[];
  final watering = <Map>[];
  final ploughing = <Map>[];
  final diary = <Map>[];

  Future<void> loadAll() async {
    fields
      ..clear()
      ..addAll(Hive.box('fields').values.cast<Map>());
    expenses
      ..clear()
      ..addAll(Hive.box('expenses').values.cast<Map>());
    fertilizer
      ..clear()
      ..addAll(Hive.box('fertilizer').values.cast<Map>());
    watering
      ..clear()
      ..addAll(Hive.box('watering').values.cast<Map>());
    ploughing
      ..clear()
      ..addAll(Hive.box('ploughing').values.cast<Map>());
    diary
      ..clear()
      ..addAll(Hive.box('diary').values.cast<Map>());
    notifyListeners();
  }

  Future<void> add(String box, Map<String, dynamic> item) async {
    await Hive.box(box).add(item);
    await Hive.box('activity').add({'title': 'Added in $box', 'time': DateTime.now().toIso8601String()});
    await loadAll();
  }

  double get totalExpenses => expenses.fold(0, (p, e) => p + ((e['amount'] ?? 0) as num));

  Future<String> exportJson() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/kisan_backup.json');
    final payload = {
      'fields': fields,
      'expenses': expenses,
      'fertilizer': fertilizer,
      'watering': watering,
      'ploughing': ploughing,
      'diary': diary,
    };
    await file.writeAsString(jsonEncode(payload));
    return file.path;
  }
}
