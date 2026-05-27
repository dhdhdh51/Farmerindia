import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../database/local_db.dart';
import '../models/farm_models.dart';

class FarmProvider extends ChangeNotifier {
  final List<FieldRecord> fields = [];
  final List<ExpenseRecord> expenses = [];
  final List<ReminderRecord> reminders = [];

  Future<void> initialize() async {
    await LocalDb.init();
    _loadAll();
  }

  double get totalExpenses => expenses.fold(0, (p, e) => p + e.amount);

  void addField(FieldRecord record) {
    fields.add(record);
    Hive.box(LocalDb.fieldsBox).add({'name': record.name, 'cropType': record.cropType, 'notes': record.notes});
    notifyListeners();
  }

  void addExpense(ExpenseRecord record) {
    expenses.add(record);
    Hive.box(LocalDb.expensesBox).add({'category': record.category, 'amount': record.amount, 'date': record.date.toIso8601String()});
    notifyListeners();
  }

  void addReminder(ReminderRecord reminder) {
    reminders.add(reminder);
    Hive.box(LocalDb.remindersBox).add({'title': reminder.title, 'date': reminder.date.toIso8601String()});
    notifyListeners();
  }

  String exportJson() => jsonEncode({
        'fields': fields.map((e) => {'name': e.name, 'cropType': e.cropType, 'notes': e.notes}).toList(),
        'expenses': expenses.map((e) => {'category': e.category, 'amount': e.amount, 'date': e.date.toIso8601String()}).toList(),
        'reminders': reminders.map((e) => {'title': e.title, 'date': e.date.toIso8601String()}).toList(),
      });

  void _loadAll() {
    final fieldsBox = Hive.box(LocalDb.fieldsBox);
    final expensesBox = Hive.box(LocalDb.expensesBox);
    final remindersBox = Hive.box(LocalDb.remindersBox);

    fields
      ..clear()
      ..addAll(fieldsBox.values.map((e) => FieldRecord(name: e['name'], cropType: e['cropType'], notes: e['notes'] ?? '')));
    expenses
      ..clear()
      ..addAll(expensesBox.values.map((e) => ExpenseRecord(category: e['category'], amount: (e['amount'] as num).toDouble(), date: DateTime.parse(e['date']))));
    reminders
      ..clear()
      ..addAll(remindersBox.values.map((e) => ReminderRecord(title: e['title'], date: DateTime.parse(e['date']))));
    notifyListeners();
  }
}
