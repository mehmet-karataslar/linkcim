// Dosya Konumu: lib/config/app_theme.dart
// Tema renkleri ve ayarları

import 'package:flutter/material.dart';

// Renk şeması enum'ı
enum ColorSchemeType {
  blue,    // Varsayılan mavi
  green,   // Yeşil
  purple,  // Mor
  orange,  // Turuncu
  teal,    // Teal
  red,     // Kırmızı
  pink,    // Pembe
}

class AppTheme {
  // Renk şemaları - Her şema için primary renkler
  static Color _getPrimaryColor(ColorSchemeType scheme, Brightness brightness) {
    switch (scheme) {
      case ColorSchemeType.blue:
        return brightness == Brightness.light 
            ? Color(0xFF2563EB) // Blue-600
            : Color(0xFF3B82F6); // Blue-500
      case ColorSchemeType.green:
        return brightness == Brightness.light
            ? Color(0xFF16A34A) // Green-600
            : Color(0xFF22C55E); // Green-500
      case ColorSchemeType.purple:
        return brightness == Brightness.light
            ? Color(0xFF9333EA) // Purple-600
            : Color(0xFFA855F7); // Purple-500
      case ColorSchemeType.orange:
        return brightness == Brightness.light
            ? Color(0xFFEA580C) // Orange-600
            : Color(0xFFF97316); // Orange-500
      case ColorSchemeType.teal:
        return brightness == Brightness.light
            ? Color(0xFF0D9488) // Teal-600
            : Color(0xFF14B8A6); // Teal-500
      case ColorSchemeType.red:
        return brightness == Brightness.light
            ? Color(0xFFDC2626) // Red-600
            : Color(0xFFEF4444); // Red-500
      case ColorSchemeType.pink:
        return brightness == Brightness.light
            ? Color(0xFFDB2777) // Pink-600
            : Color(0xFFEC4899); // Pink-500
    }
  }

  // Secondary renkler
  static Color _getSecondaryColor(ColorSchemeType scheme, Brightness brightness) {
    switch (scheme) {
      case ColorSchemeType.blue:
        return brightness == Brightness.light 
            ? Color(0xFF3B82F6) // Blue-500
            : Color(0xFF60A5FA); // Blue-400
      case ColorSchemeType.green:
        return brightness == Brightness.light
            ? Color(0xFF22C55E) // Green-500
            : Color(0xFF4ADE80); // Green-400
      case ColorSchemeType.purple:
        return brightness == Brightness.light
            ? Color(0xFFA855F7) // Purple-500
            : Color(0xFFC084FC); // Purple-400
      case ColorSchemeType.orange:
        return brightness == Brightness.light
            ? Color(0xFFF97316) // Orange-500
            : Color(0xFFFB923C); // Orange-400
      case ColorSchemeType.teal:
        return brightness == Brightness.light
            ? Color(0xFF14B8A6) // Teal-500
            : Color(0xFF2DD4BF); // Teal-400
      case ColorSchemeType.red:
        return brightness == Brightness.light
            ? Color(0xFFEF4444) // Red-500
            : Color(0xFFF87171); // Red-400
      case ColorSchemeType.pink:
        return brightness == Brightness.light
            ? Color(0xFFEC4899) // Pink-500
            : Color(0xFFF472B6); // Pink-400
    }
  }

  // Tertiary (Accent) renkler - Turuncu tonları
  static Color _getTertiaryColor(ColorSchemeType scheme, Brightness brightness) {
    // Tüm şemalar için turuncu accent kullanıyoruz
    return brightness == Brightness.light
        ? Color(0xFFF97316) // Orange-500
        : Color(0xFFFB923C); // Orange-400
  }

  // Background renklerini renk şemasına göre oluştur
  static Color _getBackgroundColor(ColorSchemeType scheme, Brightness brightness) {
    final primary = _getPrimaryColor(scheme, brightness);
    
    if (brightness == Brightness.light) {
      // Light mode için primary color'dan çok açık bir ton
      return Color.alphaBlend(
        primary.withOpacity(0.03),
        Color(0xFFFAFAFA), // Base açık gri
      );
    } else {
      // Dark mode için primary color'dan koyu bir ton
      return Color.alphaBlend(
        primary.withOpacity(0.08),
        Color(0xFF0F1419), // Base koyu gri
      );
    }
  }

  static Color _getSurfaceColor(ColorSchemeType scheme, Brightness brightness) {
    final primary = _getPrimaryColor(scheme, brightness);
    
    if (brightness == Brightness.light) {
      return Color.alphaBlend(
        primary.withOpacity(0.02),
        Color(0xFFFFFFFF),
      );
    } else {
      return Color.alphaBlend(
        primary.withOpacity(0.10),
        Color(0xFF1A1F2E),
      );
    }
  }

  static Color _getSurfaceVariantColor(ColorSchemeType scheme, Brightness brightness) {
    final primary = _getPrimaryColor(scheme, brightness);
    
    if (brightness == Brightness.light) {
      return Color.alphaBlend(
        primary.withOpacity(0.04),
        Color(0xFFF5F5F5),
      );
    } else {
      return Color.alphaBlend(
        primary.withOpacity(0.12),
        Color(0xFF252938),
      );
    }
  }

  // Light Theme - Renk şemasına göre
  static ThemeData getLightTheme(ColorSchemeType colorScheme) {
    final primary = _getPrimaryColor(colorScheme, Brightness.light);
    final secondary = _getSecondaryColor(colorScheme, Brightness.light);
    final tertiary = _getTertiaryColor(colorScheme, Brightness.light);
    
    // Dinamik arka plan renkleri
    final lightBackground = _getBackgroundColor(colorScheme, Brightness.light);
    final lightSurface = _getSurfaceColor(colorScheme, Brightness.light);
    final lightSurfaceVariant = _getSurfaceVariantColor(colorScheme, Brightness.light);
    
    final lightOnSurface = Color(0xFF1F2937);
    final lightOnSurfaceVariant = Color(0xFF4B5563);
    final lightOutline = Color(0xFFE5E7EB);
    final lightError = Color(0xFFEF4444);

    // ColorScheme.fromSeed ile otomatik renk üretimi
    final baseColorScheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    );

    return ThemeData(
      // Ana renkler
      primarySwatch: _colorToMaterialColor(primary),
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        surface: lightSurface,
        background: lightBackground,
        surfaceVariant: lightSurfaceVariant,
        onSurface: lightOnSurface,
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

      // Floating Action Button teması - Tertiary renk
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: tertiary,
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
          borderSide: BorderSide(color: primary, width: 2),
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
          color: primary,
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
          backgroundColor: primary,
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
          foregroundColor: primary,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(color: primary, width: 2),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
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

  // Dark Theme - Renk şemasına göre
  static ThemeData getDarkTheme(ColorSchemeType colorScheme) {
    final primary = _getPrimaryColor(colorScheme, Brightness.dark);
    final secondary = _getSecondaryColor(colorScheme, Brightness.dark);
    final tertiary = _getTertiaryColor(colorScheme, Brightness.dark);
    
    // Dinamik arka plan renkleri
    final darkBackground = _getBackgroundColor(colorScheme, Brightness.dark);
    final darkSurface = _getSurfaceColor(colorScheme, Brightness.dark);
    final darkSurfaceVariant = _getSurfaceVariantColor(colorScheme, Brightness.dark);
    
    final darkOnSurface = Color(0xFFF9FAFB);
    final darkOnSurfaceVariant = Color(0xFFD1D5DB);
    final darkOutline = Color(0xFF4B5563);
    final darkError = Color(0xFFF87171);

    return ThemeData(
      // Ana renkler
      primarySwatch: _colorToMaterialColor(primary),
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
        primary: primary,
        secondary: secondary,
        tertiary: tertiary,
        surface: darkSurface,
        background: darkBackground,
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

      // Floating Action Button teması - Tertiary renk
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: tertiary,
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
          borderSide: BorderSide(color: primary, width: 2),
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
          color: primary,
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
          backgroundColor: primary,
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
          foregroundColor: primary,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(color: primary, width: 2),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
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

  // Geriye uyumluluk için varsayılan temalar
  static ThemeData get lightTheme => getLightTheme(ColorSchemeType.blue);
  static ThemeData get darkTheme => getDarkTheme(ColorSchemeType.blue);

  // MaterialColor oluşturma helper
  static MaterialColor _colorToMaterialColor(Color color) {
    final int r = color.red, g = color.green, b = color.blue;
    final Map<int, Color> shades = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
    return MaterialColor(color.value, shades);
  }

  // Renk şeması için isim
  static String getColorSchemeName(ColorSchemeType scheme) {
    switch (scheme) {
      case ColorSchemeType.blue:
        return 'Mavi';
      case ColorSchemeType.green:
        return 'Yeşil';
      case ColorSchemeType.purple:
        return 'Mor';
      case ColorSchemeType.orange:
        return 'Turuncu';
      case ColorSchemeType.teal:
        return 'Teal';
      case ColorSchemeType.red:
        return 'Kırmızı';
      case ColorSchemeType.pink:
        return 'Pembe';
    }
  }

  // Renk şeması için İngilizce isim
  static String getColorSchemeNameEn(ColorSchemeType scheme) {
    switch (scheme) {
      case ColorSchemeType.blue:
        return 'Blue';
      case ColorSchemeType.green:
        return 'Green';
      case ColorSchemeType.purple:
        return 'Purple';
      case ColorSchemeType.orange:
        return 'Orange';
      case ColorSchemeType.teal:
        return 'Teal';
      case ColorSchemeType.red:
        return 'Red';
      case ColorSchemeType.pink:
        return 'Pink';
    }
  }

  // Renk şeması için renk örneği
  static Color getColorSchemePreview(ColorSchemeType scheme) {
    return _getPrimaryColor(scheme, Brightness.light);
  }
}