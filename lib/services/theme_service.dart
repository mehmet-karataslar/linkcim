import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, system }

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'app_theme';
  AppTheme _currentTheme = AppTheme.system;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeService() {
    _loadTheme();
  }

  AppTheme get currentTheme => _currentTheme;
  ThemeMode get themeMode => _themeMode;

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey) ?? AppTheme.system.index;
      _currentTheme = AppTheme.values[themeIndex];
      _updateThemeMode();
      notifyListeners();
    } catch (e) {
      print('Tema yükleme hatası: $e');
    }
  }

  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    _updateThemeMode();
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, theme.index);
    } catch (e) {
      print('Tema kaydetme hatası: $e');
    }
  }

  void _updateThemeMode() {
    switch (_currentTheme) {
      case AppTheme.light:
        _themeMode = ThemeMode.light;
        break;
      case AppTheme.dark:
        _themeMode = ThemeMode.dark;
        break;
      case AppTheme.system:
        _themeMode = ThemeMode.system;
        break;
    }
  }

  String getThemeName(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return 'Açık Tema';
      case AppTheme.dark:
        return 'Koyu Tema';
      case AppTheme.system:
        return 'Sistem Teması';
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.light:
        await setTheme(AppTheme.light);
        break;
      case ThemeMode.dark:
        await setTheme(AppTheme.dark);
        break;
      case ThemeMode.system:
        await setTheme(AppTheme.system);
        break;
    }
  }
}

