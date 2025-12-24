import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService extends ChangeNotifier {
  static const String _localeKey = 'app_locale';
  static const String _hasSetLocaleKey = 'has_set_locale';
  Locale _currentLocale = const Locale('tr');

  LocaleService() {
    _loadLocale();
  }

  Locale get currentLocale => _currentLocale;

  /// Cihazın sistem dilini al
  Locale _getDeviceLocale() {
    try {
      // WidgetsBinding üzerinden sistem dilini al
      final systemLocale = WidgetsBinding.instance.platformDispatcher.locale;
      final languageCode = systemLocale.languageCode;
      
      // Desteklenen dilleri kontrol et
      if (languageCode == 'tr') {
        return const Locale('tr');
      } else if (languageCode == 'de') {
        return const Locale('de');
      } else if (languageCode == 'ru') {
        return const Locale('ru');
      } else if (languageCode == 'fr') {
        return const Locale('fr');
      } else if (languageCode == 'zh') {
        return const Locale('zh');
      } else {
        // Varsayılan olarak İngilizce
        return const Locale('en');
      }
    } catch (e) {
      // Hata durumunda varsayılan olarak İngilizce
      return const Locale('en');
    }
  }

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasSetLocale = prefs.getBool(_hasSetLocaleKey) ?? false;
      
      if (hasSetLocale) {
        // Kullanıcı daha önce manuel olarak dil seçmişse, onu kullan
        final localeCode = prefs.getString(_localeKey) ?? 'tr';
        _currentLocale = Locale(localeCode);
      } else {
        // İlk açılış: Cihaz diline göre otomatik seç
        final deviceLocale = _getDeviceLocale();
        _currentLocale = deviceLocale;
        // Cihaz dilini kaydet
        await prefs.setString(_localeKey, deviceLocale.languageCode);
      }
      
      notifyListeners();
    } catch (e) {
      print('Dil yükleme hatası: $e');
      // Hata durumunda cihaz dilini kullan
      _currentLocale = _getDeviceLocale();
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
      // Kullanıcı manuel olarak dil seçtiğini işaretle
      await prefs.setBool(_hasSetLocaleKey, true);
    } catch (e) {
      print('Dil kaydetme hatası: $e');
    }
  }

  Future<void> setLocaleFromCode(String languageCode) async {
    await setLocale(Locale(languageCode));
  }
}

