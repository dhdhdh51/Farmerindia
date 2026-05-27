import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  Locale locale = const Locale('en');

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final dark = prefs.getBool('dark_mode');
    final lang = prefs.getString('lang') ?? 'en';
    themeMode = dark == null ? ThemeMode.system : (dark ? ThemeMode.dark : ThemeMode.light);
    locale = Locale(lang);
  }

  Future<void> toggleTheme(bool dark) async {
    themeMode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', dark);
  }

  Future<void> setLanguage(String code) async {
    locale = Locale(code);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', code);
  }
}
