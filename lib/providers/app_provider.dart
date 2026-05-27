import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/app_models.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode mode = ThemeMode.system;
  String lang = 'hi';
  String currency = '₹';

  List<FieldRecord> get fields => Hive.box('fields').values.map((e) => FieldRecord.fromMap(Map<String, dynamic>.from(e))).toList();
  List<ExpenseRecord> get expenses => Hive.box('expenses').values.map((e) => ExpenseRecord.fromMap(Map<String, dynamic>.from(e))).toList();
  List<ReminderRecord> get reminders => Hive.box('reminders').values.map((e) => ReminderRecord.fromMap(Map<String, dynamic>.from(e))).toList();
  List<DiaryRecord> get diary => Hive.box('diary').values.map((e) => DiaryRecord.fromMap(Map<String, dynamic>.from(e))).toList();

  void addField(FieldRecord f) { Hive.box('fields').put(f.id, f.toMap()); notifyListeners(); }
  void addExpense(ExpenseRecord e) { Hive.box('expenses').put(e.id, e.toMap()); notifyListeners(); }
  void addReminder(ReminderRecord r) { Hive.box('reminders').put(r.id, r.toMap()); notifyListeners(); }
  void addDiary(DiaryRecord d) { Hive.box('diary').put(d.id, d.toMap()); notifyListeners(); }

  void toggleTheme(bool dark) { mode = dark ? ThemeMode.dark : ThemeMode.light; Hive.box('settings').put('dark', dark); notifyListeners(); }
  void setLang(String l) { lang = l; Hive.box('settings').put('lang', l); notifyListeners(); }
}
