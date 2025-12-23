// Dosya Konumu: lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:linkcim/services/database_service.dart';
import 'package:linkcim/services/theme_service.dart' hide AppTheme;
import 'package:linkcim/services/locale_service.dart';
import 'package:linkcim/services/analytics_service.dart';
import 'package:linkcim/screens/home_screen.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:linkcim/config/app_theme.dart';

void main() async {
  // Flutter framework'ü başlat
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlat
  try {
    await Firebase.initializeApp();
    print('✅ Firebase başarıyla başlatıldı');
    
    // Analytics servisini başlat
    await AnalyticsService().initialize();
  } catch (e) {
    print('❌ Firebase başlatma hatası: $e');
  }

  // Veritabanını başlat
  try {
    await DatabaseService().initDB();
    print('✅ Veritabanı başarıyla başlatıldı');
  } catch (e) {
    print('❌ Veritabanı başlatma hatası: $e');
  }

  // Uygulamayı başlat
  runApp(LinkciApp());
}

class LinkciApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeService()),
        ChangeNotifierProvider(create: (_) => LocaleService()),
      ],
      child: Consumer2<ThemeService, LocaleService>(
        builder: (context, themeService, localeService, child) {
          return MaterialApp(
      title: 'Linkcim',
      debugShowCheckedModeBanner: false,

            // Çoklu dil desteği
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('tr', ''), // Türkçe
              Locale('en', ''), // İngilizce
            ],
            locale: localeService.currentLocale,

            // Tema ayarları
            themeMode: themeService.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            // Başlangıç sayfası - Direkt ana ekran
            home: HomeScreen(),

            // Route generator (gelecekte deep linking için)
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(builder: (_) => HomeScreen());
                case '/home':
                  return MaterialPageRoute(builder: (_) => HomeScreen());
                default:
                  return MaterialPageRoute(builder: (_) => HomeScreen());
              }
            },
          );
        },
      ),
    );
  }
}

// Global error handler
class GlobalErrorHandler {
  static void setupErrorHandling() {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('Flutter Hatası: ${details.exception}');
      print('Stack Trace: ${details.stack}');
    };
  }
}
