import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  Locale _currentLocale = const Locale('tr');

  LocaleService() {
    _loadLocale();
  }

  Locale get currentLocale => _currentLocale;

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final localeCode = prefs.getString(_localeKey) ?? 'tr';
      _currentLocale = Locale(localeCode);
      notifyListeners();
    } catch (e) {
      print('Dil yükleme hatası: $e');
    }
  }

  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (e) {
      print('Dil kaydetme hatası: $e');
    }
  }

  Future<void> setLocaleFromCode(String languageCode) async {
    await setLocale(Locale(languageCode));
  }
}

