// Dosya Konumu: lib/utils/constants.dart

import 'package:linkcim/l10n/app_localizations.dart';

class AppConstants {
  // Debug modu
  static const bool debugMode = true;

  // Renkler
  static const primaryColor = 0xFF2196F3;
  static const secondaryColor = 0xFF1976D2;
  static const backgroundColor = 0xFFF5F5F5;
  static const cardColor = 0xFFFFFFFF;
  static const textColor = 0xFF212121;
  static const hintColor = 0xFF757575;

  // Varsayılan kategoriler - Lokalizasyon kullanılacak
  static List<String> getDefaultCategories(AppLocalizations l10n) {
    return [
      l10n.categoryGeneral,
      l10n.categorySoftware,
      l10n.categoryEducation,
      l10n.categoryEntertainment,
      l10n.categorySports,
      l10n.categoryFood,
      l10n.categoryMusic,
      l10n.categoryArt,
      l10n.categoryScience,
      l10n.categoryTechnology,
    ];
  }

  // Popüler etiketler
  static const List<String> popularTags = [
    'flutter',
    'dart',
    'programlama',
    'api',
    'widget',
    'eğitim',
    'öğrenme',
    'tutorial',
    'ipucu',
    'teknoloji',
    'yazılım',
    'mobil',
    'uygulama',
    'geliştirme',
    'kodlama',
  ];

  // Text stilleri
  static const double titleFontSize = 18.0;
  static const double subtitleFontSize = 14.0;
  static const double bodyFontSize = 12.0;
  static const double captionFontSize = 10.0;

  // Bosluklar
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // 🎯 DESTEKLENEN PLATFORMLAR
  static const List<String> supportedPlatforms = [
    'Instagram',
    'YouTube',
    'TikTok',
    'Twitter',
    'Facebook',
    'Vimeo',
    'Reddit',
  ];

  // 📱 Platform emojileri
  static const Map<String, String> platformEmojis = {
    'Instagram': '📸',
    'YouTube': '📺',
    'TikTok': '🎵',
    'Twitter': '🐦',
    'Facebook': '👤',
    'Vimeo': '🎬',
    'Reddit': '🤖',
    'Genel': '🎬',
  };

  // 🌐 URL Validation - Tüm Platformlar
  static bool isValidVideoUrl(String url) {
    return isValidInstagramUrl(url) ||
        isValidYouTubeUrl(url) ||
        isValidTikTokUrl(url) ||
        isValidTwitterUrl(url) ||
        isValidFacebookUrl(url) ||
        isValidVimeoUrl(url) ||
        isValidRedditUrl(url);
  }

  // Instagram URL validation
  static bool isValidInstagramUrl(String url) {
    return url.contains('instagram.com') &&
        (url.contains('/p/') || url.contains('/reel/') || url.contains('/tv/'));
  }

  // YouTube URL validation
  static bool isValidYouTubeUrl(String url) {
    return (url.contains('youtube.com/watch') && url.contains('v=')) ||
        (url.contains('youtu.be/')) ||
        (url.contains('youtube.com/shorts/')) ||
        (url.contains('m.youtube.com/watch'));
  }

  // TikTok URL validation
  static bool isValidTikTokUrl(String url) {
    return (url.contains('tiktok.com') && url.contains('/video/')) ||
        (url.contains('vm.tiktok.com/')) ||
        (url.contains('tiktok.com/@') && url.contains('/video/'));
  }

  // Twitter/X URL validation
  static bool isValidTwitterUrl(String url) {
    return (url.contains('twitter.com') && url.contains('/status/')) ||
        (url.contains('x.com') && url.contains('/status/')) ||
        (url.contains('mobile.twitter.com') && url.contains('/status/'));
  }

  // Facebook URL validation
  static bool isValidFacebookUrl(String url) {
    return (url.contains('facebook.com') && 
            (url.contains('/video.php') || 
             url.contains('/watch') || 
             url.contains('/videos/'))) ||
        (url.contains('fb.com') && url.contains('/watch')) ||
        (url.contains('fb.watch'));
  }

  // Vimeo URL validation
  static bool isValidVimeoUrl(String url) {
    return (url.contains('vimeo.com') && url.contains('/')) ||
        (url.contains('player.vimeo.com'));
  }

  // Reddit URL validation
  static bool isValidRedditUrl(String url) {
    return (url.contains('reddit.com') && 
            (url.contains('/r/') || url.contains('/user/'))) ||
        (url.contains('redd.it'));
  }

  // 🔍 Platform Detection
  static String detectPlatform(String url) {
    if (isValidInstagramUrl(url)) return 'Instagram';
    if (isValidYouTubeUrl(url)) return 'YouTube';
    if (isValidTikTokUrl(url)) return 'TikTok';
    if (isValidTwitterUrl(url)) return 'Twitter';
    if (isValidFacebookUrl(url)) return 'Facebook';
    if (isValidVimeoUrl(url)) return 'Vimeo';
    if (isValidRedditUrl(url)) return 'Reddit';
    return 'Genel';
  }

  // 🎬 URL'den başlık çıkarma - Multi-Platform
  static String extractTitleFromUrl(String url, AppLocalizations l10n) {
    try {
      String platform = detectPlatform(url);
      String emoji = platformEmojis[platform] ?? '🎬';

      switch (platform) {
        case 'Instagram':
          return _extractInstagramTitle(url, emoji, l10n);
        case 'YouTube':
          return _extractYouTubeTitle(url, emoji, l10n);
        case 'TikTok':
          return _extractTikTokTitle(url, emoji, l10n);
        case 'Twitter':
          return _extractTwitterTitle(url, emoji, l10n);
        case 'Facebook':
          return '$emoji ${l10n.facebookVideo}';
        case 'Vimeo':
          return '$emoji ${l10n.vimeoVideo}';
        case 'Reddit':
          return '$emoji ${l10n.redditVideo}';
        default:
          return '$emoji ${l10n.videoTitleFromUrl}';
      }
    } catch (e) {
      return '🎬 ${l10n.videoTitleFromUrl}';
    }
  }

  // Instagram başlık çıkarma
  static String _extractInstagramTitle(String url, String emoji, AppLocalizations l10n) {
    Uri uri = Uri.parse(url);
    String path = uri.path;

    RegExp regExp = RegExp(r'/(p|reel|tv)/([A-Za-z0-9_-]+)');
    Match? match = regExp.firstMatch(path);

    if (match != null) {
      String type = match.group(1)!;
      String id = match.group(2)!;

      switch (type) {
        case 'p':
          return '$emoji ${l10n.instagramPost}';
        case 'reel':
          return '$emoji ${l10n.instagramReel}';
        case 'tv':
          return '$emoji ${l10n.instagramTV}';
        default:
          return '$emoji ${l10n.instagramVideo}';
      }
    }

    return '$emoji ${l10n.instagramVideo}';
  }

  // YouTube başlık çıkarma
  static String _extractYouTubeTitle(String url, String emoji, AppLocalizations l10n) {
    Uri uri = Uri.parse(url);

    // YouTube Shorts
    if (url.contains('/shorts/')) {
      return '$emoji ${l10n.youtubeShorts}';
    }

    // Normal YouTube video
    if (url.contains('youtube.com/watch') || url.contains('youtu.be/')) {
      // Video ID'yi al
      String? videoId;
      if (url.contains('youtu.be/')) {
        videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : null;
      } else {
        videoId = uri.queryParameters['v'];
      }

      if (videoId != null && videoId.length >= 8) {
        return '$emoji ${l10n.youtubeVideo}';
      }
    }

    return '$emoji ${l10n.youtubeVideo}';
  }

  // TikTok başlık çıkarma
  static String _extractTikTokTitle(String url, String emoji, AppLocalizations l10n) {
    if (url.contains('/video/')) {
      return '$emoji ${l10n.tiktokVideo}';
    }
    if (url.contains('vm.tiktok.com/')) {
      return '$emoji ${l10n.tiktokVideoShortLink}';
    }

    return '$emoji ${l10n.tiktokVideo}';
  }

  // Twitter başlık çıkarma
  static String _extractTwitterTitle(String url, String emoji, AppLocalizations l10n) {
    try {
      Uri uri = Uri.parse(url);

      // Username çıkar
      String username = '';
      if (uri.pathSegments.isNotEmpty) {
        username = uri.pathSegments[0];
      }

      // Tweet ID çıkar
      String tweetId = '';
      final statusIndex = uri.pathSegments.indexOf('status');
      if (statusIndex != -1 && statusIndex + 1 < uri.pathSegments.length) {
        tweetId = uri.pathSegments[statusIndex + 1];
      }

      // X.com domain kontrolü
      if (url.contains('x.com')) {
        if (username.isNotEmpty) {
          return '$emoji ${l10n.xTwitterUser(username)}';
        }
        return '$emoji ${l10n.xTwitterPost}';
      }

      // Twitter.com domain
      if (username.isNotEmpty) {
        return '$emoji ${l10n.twitterUser(username)}';
      }

      return '$emoji ${l10n.twitterPost}';
    } catch (e) {
      return '$emoji ${l10n.twitterPost}';
    }
  }

  // 🎨 Platform rengini al
  static int getPlatformColor(String platform) {
    switch (platform) {
      case 'Instagram':
        return 0xFFE4405F; // Instagram kırmızısı
      case 'YouTube':
        return 0xFFFF0000; // YouTube kırmızısı
      case 'TikTok':
        return 0xFF000000; // TikTok siyahı
      case 'Twitter':
        return 0xFF1DA1F2; // Twitter mavisi
      case 'Facebook':
        return 0xFF1877F2; // Facebook mavisi
      case 'Vimeo':
        return 0xFF1AB7EA; // Vimeo mavisi
      case 'Reddit':
        return 0xFFFF4500; // Reddit turuncusu
      default:
        return primaryColor; // Varsayılan mavi
    }
  }
}
