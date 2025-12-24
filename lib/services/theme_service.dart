import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linkcim/config/app_theme.dart';

enum AppThemeMode { light, dark, system }

class ThemeService extends ChangeNotifier {
  static const String _themeKey = 'app_theme_mode';
  static const String _colorSchemeKey = 'app_color_scheme';
  
  AppThemeMode _currentTheme = AppThemeMode.system;
  ThemeMode _themeMode = ThemeMode.system;
  ColorSchemeType _colorScheme = ColorSchemeType.blue;

  ThemeService() {
    _loadTheme();
  }

  AppThemeMode get currentTheme => _currentTheme;
  ThemeMode get themeMode => _themeMode;
  ColorSchemeType get colorScheme => _colorScheme;

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Tema modunu yükle
      final themeIndex = prefs.getInt(_themeKey) ?? AppThemeMode.system.index;
      _currentTheme = AppThemeMode.values[themeIndex];
      _updateThemeMode();
      
      // Renk şemasını yükle
      final colorSchemeIndex = prefs.getInt(_colorSchemeKey) ?? ColorSchemeType.blue.index;
      _colorScheme = ColorSchemeType.values[colorSchemeIndex];
      
      notifyListeners();
    } catch (e) {
      print('Tema yükleme hatası: $e');
    }
  }

  Future<void> setTheme(AppThemeMode theme) async {
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

  Future<void> setColorScheme(ColorSchemeType colorScheme) async {
    _colorScheme = colorScheme;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_colorSchemeKey, colorScheme.index);
    } catch (e) {
      print('Renk şeması kaydetme hatası: $e');
    }
  }

  void _updateThemeMode() {
    switch (_currentTheme) {
      case AppThemeMode.light:
        _themeMode = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        _themeMode = ThemeMode.dark;
        break;
      case AppThemeMode.system:
        _themeMode = ThemeMode.system;
        break;
    }
  }

  String getThemeName(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return 'Açık Tema';
      case AppThemeMode.dark:
        return 'Koyu Tema';
      case AppThemeMode.system:
        return 'Sistem Teması';
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    switch (mode) {
      case ThemeMode.light:
        await setTheme(AppThemeMode.light);
        break;
      case ThemeMode.dark:
        await setTheme(AppThemeMode.dark);
        break;
      case ThemeMode.system:
        await setTheme(AppThemeMode.system);
        break;
    }
  }

  // Tema verilerini döndür
  ThemeData getLightTheme() {
    return AppTheme.getLightTheme(_colorScheme);
  }

  ThemeData getDarkTheme() {
    return AppTheme.getDarkTheme(_colorScheme);
  }
}