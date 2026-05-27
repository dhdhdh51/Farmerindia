import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('fields');
    await Hive.openBox('expenses');
    await Hive.openBox('reminders');
    await Hive.openBox('diary');
    await Hive.openBox('settings');
  }
}
