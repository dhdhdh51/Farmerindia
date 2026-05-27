import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  String languageCode = 'en';
  String currency = '₹';

  Future<void> loadSettings() async {
    final box = Hive.box('settings');
    themeMode = ThemeMode.values[box.get('themeMode', defaultValue: 0) as int];
    languageCode = box.get('lang', defaultValue: 'en') as String;
    currency = box.get('currency', defaultValue: '₹') as String;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    themeMode = themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await Hive.box('settings').put('themeMode', themeMode.index);
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    languageCode = languageCode == 'en' ? 'hi' : 'en';
    await Hive.box('settings').put('lang', languageCode);
    notifyListeners();
  }
}
