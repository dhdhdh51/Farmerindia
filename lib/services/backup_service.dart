import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class BackupService {
  Future<String> exportJson() async {
    final data = {
      'fields': Hive.box('fields').values.toList(),
      'expenses': Hive.box('expenses').values.toList(),
      'reminders': Hive.box('reminders').values.toList(),
      'diary': Hive.box('diary').values.toList(),
    };
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/kisan_ledger_backup.json');
    await file.writeAsString(jsonEncode(data));
    return file.path;
  }
}
