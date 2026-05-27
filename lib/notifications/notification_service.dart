import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    const initSettings = InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    await _plugin.initialize(initSettings);
  }

  static Future<void> showBasic(int id, String title, String body) async {
    const details = NotificationDetails(android: AndroidNotificationDetails('kisan_reminders', 'Kisan Reminders', importance: Importance.high));
    await _plugin.show(id, title, body, details);
  }
}
