import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  static const fieldsBox = 'fields';
  static const expensesBox = 'expenses';
  static const remindersBox = 'reminders';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(fieldsBox);
    await Hive.openBox(expensesBox);
    await Hive.openBox(remindersBox);
  }
}
