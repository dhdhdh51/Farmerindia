enum ExpenseType { seeds, fertilizer, diesel, watering, labour, ploughing, pesticides, other }

class FieldRecord {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String size;
  final String crop;
  final String soil;
  final String notes;
  final String imagePath;

  FieldRecord({required this.id, required this.name, required this.lat, required this.lng, required this.size, required this.crop, required this.soil, required this.notes, this.imagePath = ''});

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'lat': lat, 'lng': lng, 'size': size, 'crop': crop, 'soil': soil, 'notes': notes, 'imagePath': imagePath};
  factory FieldRecord.fromMap(Map map) => FieldRecord(id: map['id'], name: map['name'], lat: (map['lat'] ?? 0).toDouble(), lng: (map['lng'] ?? 0).toDouble(), size: map['size'], crop: map['crop'], soil: map['soil'], notes: map['notes'], imagePath: map['imagePath'] ?? '');
}

class ExpenseRecord {
  final String id;
  final ExpenseType type;
  final double amount;
  final DateTime date;
  final String notes;
  ExpenseRecord({required this.id, required this.type, required this.amount, required this.date, this.notes = ''});
  Map<String, dynamic> toMap() => {'id': id, 'type': type.index, 'amount': amount, 'date': date.toIso8601String(), 'notes': notes};
  factory ExpenseRecord.fromMap(Map map) => ExpenseRecord(id: map['id'], type: ExpenseType.values[map['type']], amount: (map['amount'] ?? 0).toDouble(), date: DateTime.parse(map['date']), notes: map['notes'] ?? '');
}

class ReminderRecord {
  final String id;
  final String title;
  final DateTime date;
  final String category;
  final String note;
  ReminderRecord({required this.id, required this.title, required this.date, required this.category, this.note = ''});
  Map<String, dynamic> toMap() => {'id': id, 'title': title, 'date': date.toIso8601String(), 'category': category, 'note': note};
  factory ReminderRecord.fromMap(Map map) => ReminderRecord(id: map['id'], title: map['title'], date: DateTime.parse(map['date']), category: map['category'], note: map['note'] ?? '');
}

class DiaryRecord {
  final String id;
  final DateTime date;
  final String text;
  DiaryRecord({required this.id, required this.date, required this.text});
  Map<String, dynamic> toMap() => {'id': id, 'date': date.toIso8601String(), 'text': text};
  factory DiaryRecord.fromMap(Map map) => DiaryRecord(id: map['id'], date: DateTime.parse(map['date']), text: map['text']);
}

class SmartCalc {
  static double profitLoss(double income, double cost) => income - cost;
  static double yieldEstimate(double area, double productivity) => area * productivity;
}
