// Dosya Konumu: lib/services/analytics_service.dart

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Google Analytics servisi - Kullanıcı davranışlarını takip etmek için
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  FirebaseAnalytics? _analytics;
  bool _isInitialized = false;

  /// Analytics servisini başlat
  Future<void> initialize() async {
    try {
      _analytics = FirebaseAnalytics.instance;
      _isInitialized = true;
      if (kDebugMode) {
        print('✅ Analytics servisi başarıyla başlatıldı');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Analytics servisi başlatma hatası: $e');
      }
      _isInitialized = false;
    }
  }

  /// Analytics servisinin başlatılıp başlatılmadığını kontrol et
  bool get isInitialized => _isInitialized && _analytics != null;

  /// Sayfa görüntüleme olayı
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
      if (kDebugMode) {
        print('📊 Screen View: $screenName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Screen View log hatası: $e');
      }
    }
  }

  /// Buton tıklama olayı
  Future<void> logButtonClick({
    required String buttonName,
    String? screenName,
    Map<String, dynamic>? parameters,
  }) async {
    if (!isInitialized) return;

    try {
      final eventParams = <String, Object>{
        'button_name': buttonName,
        if (screenName != null) 'screen_name': screenName,
        ...?parameters?.map((key, value) => MapEntry(key, value as Object)),
      };

      await _analytics!.logEvent(
        name: 'button_click',
        parameters: eventParams,
      );
      if (kDebugMode) {
        print('📊 Button Click: $buttonName (Screen: $screenName)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Button Click log hatası: $e');
      }
    }
  }

  /// Kategori seçimi olayı
  Future<void> logCategorySelected({
    required String categoryName,
    int? videoCount,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'category_selected',
        parameters: {
          'category_name': categoryName,
          if (videoCount != null) 'video_count': videoCount,
        },
      );
      if (kDebugMode) {
        print('📊 Category Selected: $categoryName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Category Selected log hatası: $e');
      }
    }
  }

  /// Video ekleme olayı
  Future<void> logVideoAdded({
    required String platform,
    String? category,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'video_added',
        parameters: {
          'platform': platform,
          if (category != null) 'category': category,
        },
      );
      if (kDebugMode) {
        print('📊 Video Added: Platform=$platform, Category=$category');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Video Added log hatası: $e');
      }
    }
  }

  /// Video silme olayı
  Future<void> logVideoDeleted({
    required String platform,
    String? category,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'video_deleted',
        parameters: {
          'platform': platform,
          if (category != null) 'category': category,
        },
      );
      if (kDebugMode) {
        print('📊 Video Deleted: Platform=$platform, Category=$category');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Video Deleted log hatası: $e');
      }
    }
  }

  /// Video oynatma olayı
  Future<void> logVideoPlayed({
    required String platform,
    String? category,
    String? videoId,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'video_played',
        parameters: {
          'platform': platform,
          if (category != null) 'category': category,
          if (videoId != null) 'video_id': videoId,
        },
      );
      if (kDebugMode) {
        print('📊 Video Played: Platform=$platform, Category=$category');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Video Played log hatası: $e');
      }
    }
  }

  /// Arama olayı
  Future<void> logSearch({
    required String searchQuery,
    int? resultCount,
    String? searchType,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logSearch(
        searchTerm: searchQuery,
        parameters: {
          if (resultCount != null) 'result_count': resultCount,
          if (searchType != null) 'search_type': searchType,
        },
      );
      if (kDebugMode) {
        print('📊 Search: $searchQuery (Results: $resultCount)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Search log hatası: $e');
      }
    }
  }

  /// Koleksiyon oluşturma olayı
  Future<void> logCollectionCreated({
    required String collectionName,
    int? videoCount,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'collection_created',
        parameters: {
          'collection_name': collectionName,
          if (videoCount != null) 'video_count': videoCount,
        },
      );
      if (kDebugMode) {
        print('📊 Collection Created: $collectionName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Collection Created log hatası: $e');
      }
    }
  }

  /// Ayarlar değişikliği olayı
  Future<void> logSettingChanged({
    required String settingName,
    required String oldValue,
    required String newValue,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'setting_changed',
        parameters: {
          'setting_name': settingName,
          'old_value': oldValue,
          'new_value': newValue,
        },
      );
      if (kDebugMode) {
        print('📊 Setting Changed: $settingName ($oldValue -> $newValue)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Setting Changed log hatası: $e');
      }
    }
  }

  /// Tema değişikliği olayı
  Future<void> logThemeChanged(String themeMode) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'theme_changed',
        parameters: {
          'theme_mode': themeMode,
        },
      );
      if (kDebugMode) {
        print('📊 Theme Changed: $themeMode');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Theme Changed log hatası: $e');
      }
    }
  }

  /// Dil değişikliği olayı
  Future<void> logLanguageChanged(String languageCode) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: 'language_changed',
        parameters: {
          'language_code': languageCode,
        },
      );
      if (kDebugMode) {
        print('📊 Language Changed: $languageCode');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Language Changed log hatası: $e');
      }
    }
  }

  /// Özel olay loglama
  Future<void> logCustomEvent({
    required String eventName,
    Map<String, dynamic>? parameters,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.logEvent(
        name: eventName,
        parameters: parameters?.map((key, value) => MapEntry(key, value as Object)),
      );
      if (kDebugMode) {
        print('📊 Custom Event: $eventName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Custom Event log hatası: $e');
      }
    }
  }

  /// Kullanıcı özelliği ayarlama
  Future<void> setUserProperty({
    required String name,
    required String? value,
  }) async {
    if (!isInitialized) return;

    try {
      await _analytics!.setUserProperty(name: name, value: value);
      if (kDebugMode) {
        print('📊 User Property Set: $name = $value');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ User Property Set hatası: $e');
      }
    }
  }

  /// Kullanıcı ID ayarlama
  Future<void> setUserId(String? userId) async {
    if (!isInitialized) return;

    try {
      await _analytics!.setUserId(id: userId);
      if (kDebugMode) {
        print('📊 User ID Set: $userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ User ID Set hatası: $e');
      }
    }
  }
}

