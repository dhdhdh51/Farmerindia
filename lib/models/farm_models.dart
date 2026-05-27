class FieldRecord {
  FieldRecord({required this.name, required this.cropType, this.notes = ''});
  final String name;
  final String cropType;
  final String notes;
}

class ExpenseRecord {
  ExpenseRecord({required this.category, required this.amount, required this.date});
  final String category;
  final double amount;
  final DateTime date;
}

class ReminderRecord {
  ReminderRecord({required this.title, required this.date});
  final String title;
  final DateTime date;
}
