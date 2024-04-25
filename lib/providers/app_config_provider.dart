import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  changelanguage(String newlanguage) {
    if (appLanguage == newlanguage) {
      return;
    }
    appLanguage = newlanguage;
    saveLanguage();
  }

  changeThemeMode(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    saveTheme();
  }

  saveLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', appLanguage);
    prefs.reload();
    notifyListeners();
  }

  saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', appTheme.index);
    prefs.reload();
    notifyListeners();
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('theme');
    if (themeIndex != null) {
      appTheme = ThemeMode.values[themeIndex];
    }
    notifyListeners();
  }

  getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
