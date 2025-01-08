// lib/theme/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider extends ChangeNotifier {
  final _settingsBox = Hive.box('settings');

  ThemeMode get themeMode {
    final isLight = _settingsBox.get('isLight', defaultValue: true);
    return isLight ? ThemeMode.light : ThemeMode.dark;
  }

  void toggleTheme() {
    _settingsBox.put('isLight', themeMode == ThemeMode.dark);
    notifyListeners();
  }
}