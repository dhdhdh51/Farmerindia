import 'package:hive_flutter/hive_flutter.dart';

class LocalDb {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox('fields'),
      Hive.openBox('expenses'),
      Hive.openBox('fertilizer'),
      Hive.openBox('watering'),
      Hive.openBox('ploughing'),
      Hive.openBox('crops'),
      Hive.openBox('diary'),
      Hive.openBox('settings'),
      Hive.openBox('activity'),
    ]);
  }
}
