// Dosya Konumu: lib/config/app_theme.dart
// Tema renkleri ve ayarları

import 'package:flutter/material.dart';

class AppTheme {
  // Renk paleti - Icon'dan esinlenilmiş renkler
  // Icon: Derin mavi arka plan, turuncu hashtag badge, beyaz doküman, koyu gri detaylar
  
  // Light Theme - Icon renklerine uygun
  static const Color lightPrimary = Color(0xFF2563EB); // Icon'daki derin mavi (Blue-600)
  static const Color lightSecondary = Color(0xFF3B82F6); // Açık mavi (Blue-500)
  static const Color lightTertiary = Color(0xFFF97316); // Icon'daki turuncu hashtag (Orange-500)
  static const Color lightAccent = Color(0xFFFB923C); // Açık turuncu (Orange-400)
  static const Color lightBackground = Color(0xFFF9FAFB); // Hafif gri arka plan
  static const Color lightSurface = Color(0xFFFFFFFF); // Icon'daki beyaz doküman
  static const Color lightSurfaceVariant = Color(0xFFF3F4F6); // Hafif gri
  static const Color lightOnSurface = Color(0xFF1F2937); // Icon'daki koyu gri metin
  static const Color lightOnSurfaceVariant = Color(0xFF4B5563); // Orta gri
  static const Color lightOutline = Color(0xFFE5E7EB); // Açık gri çizgiler
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightSuccess = Color(0xFF10B981);

  // Dark Theme - Icon renklerine uygun dark versiyonları
  static const Color darkPrimary = Color(0xFF3B82F6); // Açık mavi (Blue-500)
  static const Color darkSecondary = Color(0xFF60A5FA); // Daha açık mavi (Blue-400)
  static const Color darkTertiary = Color(0xFFFB923C); // Icon'daki turuncu (Orange-400)
  static const Color darkAccent = Color(0xFFFDBA74); // Açık turuncu (Orange-300)
  static const Color darkBackground = Color(0xFF111827); // Koyu arka plan
  static const Color darkSurface = Color(0xFF1F2937); // Koyu yüzey
  static const Color darkSurfaceVariant = Color(0xFF374151); // Orta koyu gri
  static const Color darkOnSurface = Color(0xFFF9FAFB); // Açık metin
  static const Color darkOnSurfaceVariant = Color(0xFFD1D5DB); // Orta açık gri
  static const Color darkOutline = Color(0xFF4B5563); // Koyu gri çizgiler
  static const Color darkError = Color(0xFFF87171);
  static const Color darkSuccess = Color(0xFF34D399);

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      // Ana renkler
      primarySwatch: Colors.blue,
      primaryColor: lightPrimary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimary,
        brightness: Brightness.light,
        primary: lightPrimary, // Icon'daki derin mavi
        secondary: lightSecondary, // Açık mavi
        tertiary: lightTertiary, // Icon'daki turuncu hashtag
        surface: lightSurface, // Icon'daki beyaz doküman
        surfaceVariant: lightSurfaceVariant,
        onSurface: lightOnSurface, // Icon'daki koyu gri metin
        onSurfaceVariant: lightOnSurfaceVariant,
        outline: lightOutline,
        error: lightError,
        errorContainer: Color(0xFFFEE2E2),
        onErrorContainer: Color(0xFF991B1B),
      ),

      // AppBar teması
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: lightOnSurface,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: lightOnSurface),
      ),

      // Floating Action Button teması - Icon'daki turuncu renk
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: lightTertiary, // Icon'daki turuncu hashtag rengi
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Card teması
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: lightOutline,
            width: 1,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: lightSurface,
      ),

      // Input teması
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: lightError, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        filled: true,
        fillColor: lightBackground,
      ),

      // Chip teması
      chipTheme: ChipThemeData(
        backgroundColor: lightSurfaceVariant,
        selectedColor: Color(0xFFEEF2FF),
        secondarySelectedColor: Color(0xFFE0E7FF),
        labelStyle: TextStyle(
          color: Color(0xFF374151),
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: TextStyle(
          color: lightPrimary,
          fontWeight: FontWeight.w600,
        ),
        brightness: Brightness.light,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Button temaları
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lightPrimary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightPrimary,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(color: lightPrimary, width: 2),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: lightPrimary,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Snackbar teması
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF1F2937),
      ),

      // Divider teması
      dividerTheme: DividerThemeData(
        color: lightOutline,
        thickness: 1,
        space: 1,
      ),

      // Visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Platform brightness
      brightness: Brightness.light,

      // Splash factory
      splashFactory: InkRipple.splashFactory,

      // Scaffold background
      scaffoldBackgroundColor: lightBackground,

      // Icon teması
      iconTheme: IconThemeData(
        color: lightOnSurface,
        size: 24,
      ),

      // Text teması
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: lightOnSurface,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: lightOnSurface,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: lightOnSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: lightOnSurface,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: lightOnSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: lightOnSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: lightOnSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: lightOnSurfaceVariant,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: lightOnSurfaceVariant,
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      // Ana renkler
      primarySwatch: Colors.blue,
      primaryColor: darkPrimary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimary, // Icon'daki mavi
        brightness: Brightness.dark,
        primary: darkPrimary, // Açık mavi
        secondary: darkSecondary, // Daha açık mavi
        tertiary: darkTertiary, // Icon'daki turuncu
        surface: darkSurface,
        surfaceVariant: darkSurfaceVariant,
        onSurface: darkOnSurface,
        onSurfaceVariant: darkOnSurfaceVariant,
        outline: darkOutline,
        error: darkError,
        errorContainer: Color(0xFF7F1D1D),
        onErrorContainer: Color(0xFFFEE2E2),
      ),

      // AppBar teması
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: darkOnSurface,
          letterSpacing: -0.5,
        ),
        iconTheme: IconThemeData(color: darkOnSurface),
      ),

      // Floating Action Button teması - Icon'daki turuncu renk
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkTertiary, // Icon'daki turuncu hashtag rengi
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Card teması
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: darkOutline,
            width: 1,
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: darkSurface,
      ),

      // Input teması
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkOutline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkOutline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: darkError, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        fillColor: darkBackground,
        filled: true,
      ),

      // Chip teması
      chipTheme: ChipThemeData(
        backgroundColor: darkSurfaceVariant,
        selectedColor: Color(0xFF312E81),
        secondarySelectedColor: Color(0xFF4C1D95),
        labelStyle: TextStyle(
          color: Color(0xFFE5E7EB),
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: TextStyle(
          color: darkPrimary,
          fontWeight: FontWeight.w600,
        ),
        brightness: Brightness.dark,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Button temaları
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkPrimary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkPrimary,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(color: darkPrimary, width: 2),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimary,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Snackbar teması
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        backgroundColor: darkSurfaceVariant,
      ),

      // Divider teması
      dividerTheme: DividerThemeData(
        color: darkOutline,
        thickness: 1,
        space: 1,
      ),

      // Visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Platform brightness
      brightness: Brightness.dark,

      // Splash factory
      splashFactory: InkRipple.splashFactory,

      // Scaffold background
      scaffoldBackgroundColor: darkBackground,

      // Icon teması
      iconTheme: IconThemeData(
        color: darkOnSurface,
        size: 24,
      ),

      // Text teması
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkOnSurface,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkOnSurface,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: darkOnSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: darkOnSurface,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darkOnSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkOnSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: darkOnSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: darkOnSurfaceVariant,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: darkOnSurfaceVariant,
        ),
      ),
    );
  }

  // Gradient renkler - Icon renklerine uygun
  static List<Color> get primaryGradient => [lightPrimary, lightSecondary];
  static List<Color> get darkPrimaryGradient => [darkPrimary, darkSecondary];
  static List<Color> get accentGradient => [lightTertiary, lightAccent]; // Icon'daki turuncu gradient
  static List<Color> get darkAccentGradient => [darkTertiary, darkAccent];
  
  // Shadow renkleri
  static Color get lightShadow => Colors.black.withOpacity(0.05);
  static Color get darkShadow => Colors.black.withOpacity(0.3);
  
  // Icon renk referansları
  static const Color iconBlue = lightPrimary; // Icon'daki derin mavi arka plan
  static const Color iconOrange = lightTertiary; // Icon'daki turuncu hashtag badge
  static const Color iconWhite = lightSurface; // Icon'daki beyaz doküman
  static const Color iconDarkGray = lightOnSurface; // Icon'daki koyu gri detaylar
}

