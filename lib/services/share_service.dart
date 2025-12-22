// Dosya Konumu: lib/services/share_service.dart

import 'package:share_plus/share_plus.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class ShareService {
  // Video linkini paylaş
  static Future<void> shareVideoLink(SavedVideo video, AppLocalizations l10n) async {
    try {
      final shareText = _buildShareText(video, l10n);

      await Share.share(
        shareText,
        subject: video.title,
      );
    } catch (e) {
      print('${l10n.shareError}: $e');
      throw '${l10n.shareError}: $e';
    }
  }

  // Video bilgilerini detaylı paylaş
  static Future<void> shareVideoDetails(SavedVideo video, AppLocalizations l10n) async {
    try {
      final detailedText = _buildDetailedShareText(video, l10n);

      await Share.share(
        detailedText,
        subject: '${l10n.videoInfo}: ${video.title}',
      );
    } catch (e) {
      print('${l10n.shareError}: $e');
      throw '${l10n.shareError}: $e';
    }
  }

  // Sadece linki paylaş
  static Future<void> shareOnlyLink(String url) async {
    try {
      await Share.share(url);
    } catch (e) {
      print('Link share error: $e');
      throw 'Link share failed: $e';
    }
  }

  // Linki panoya kopyala
  static Future<void> copyLinkToClipboard(String url, AppLocalizations l10n) async {
    try {
      await Clipboard.setData(ClipboardData(text: url));
    } catch (e) {
      print('${l10n.copyError}: $e');
      throw '${l10n.copyError}: $e';
    }
  }

  // Video bilgilerini panoya kopyala
  static Future<void> copyVideoDetailsToClipboard(SavedVideo video, AppLocalizations l10n) async {
    try {
      final detailedText = _buildDetailedShareText(video, l10n);
      await Clipboard.setData(ClipboardData(text: detailedText));
    } catch (e) {
      print('${l10n.copyError}: $e');
      throw '${l10n.copyError}: $e';
    }
  }

  // Birden fazla video linkini paylaş
  static Future<void> shareMultipleVideos(List<SavedVideo> videos, AppLocalizations l10n) async {
    try {
      if (videos.isEmpty) {
        throw l10n.noVideos;
      }

      final shareText = _buildMultipleVideosShareText(videos, l10n);

      await Share.share(
        shareText,
        subject: l10n.videoCollection(videos.length),
      );
    } catch (e) {
      print('${l10n.shareError}: $e');
      throw '${l10n.shareError}: $e';
    }
  }

  // Kategori bazlı paylaşım
  static Future<void> shareVideosByCategory(String category, List<SavedVideo> videos, AppLocalizations l10n) async {
    try {
      final categoryVideos = videos.where((v) => v.category == category).toList();

      if (categoryVideos.isEmpty) {
        throw l10n.noVideoFound;
      }

      final shareText = _buildCategoryShareText(category, categoryVideos, l10n);

      await Share.share(
        shareText,
        subject: '${l10n.categoryVideos(category)} (${categoryVideos.length} ${l10n.videosFound(categoryVideos.length)})',
      );
    } catch (e) {
      print('${l10n.shareError}: $e');
      throw '${l10n.shareError}: $e';
    }
  }

  // Basit paylaşım metni oluştur
  static String _buildShareText(SavedVideo video, AppLocalizations l10n) {
    return '''
🎬 ${video.title}

📱 ${l10n.videoUrl}:
${video.videoUrl}

📝 ${l10n.videoDescription}: ${video.description.isNotEmpty ? video.description : l10n.noDescription}

🏷️ ${l10n.category}: ${video.category}

${video.tags.isNotEmpty ? '🔖 ${l10n.tags}: ${video.tags.join(', ')}' : ''}

📅 ${video.formattedDate}

---
${l10n.sharedFromLinkcim} 📱
''';
  }

  // Detaylı paylaşım metni oluştur
  static String _buildDetailedShareText(SavedVideo video, AppLocalizations l10n) {
    return '''
🎬 ${video.title}

📱 ${l10n.videoUrl}:
${video.videoUrl}

📝 ${l10n.videoDescription}:
${video.description.isNotEmpty ? video.description : l10n.descriptionNotAvailable}

📊 ${l10n.videoInfo}:
• ${l10n.category}: ${video.category}
• ${l10n.tags}: ${video.tags.isNotEmpty ? video.tags.join(', ') : l10n.noTags}
• ${video.formattedDate}
• Video Key: ${video.key}

🔗 ${video.videoUrl.length > 50 ? video.videoUrl.substring(0, 50) + '...' : video.videoUrl}

---
${l10n.sharedFromLinkcim} 📱
''';
  }

  // Birden fazla video için paylaşım metni
  static String _buildMultipleVideosShareText(List<SavedVideo> videos, AppLocalizations l10n) {
    final buffer = StringBuffer();

    buffer.writeln('🎬 ${l10n.videoCollection(videos.length)}');
    buffer.writeln('');

    for (int i = 0; i < videos.length; i++) {
      final video = videos[i];
      buffer.writeln('${i + 1}. ${video.title}');
      buffer.writeln('   🔗 ${video.videoUrl}');
      buffer.writeln('   📁 ${video.category}');
      if (video.tags.isNotEmpty) {
        buffer.writeln('   🏷️ ${video.tags.take(3).join(', ')}${video.tags.length > 3 ? '...' : ''}');
      }
      buffer.writeln('');
    }

    buffer.writeln('---');
    buffer.writeln('${l10n.sharedFromLinkcim} 📱');

    return buffer.toString();
  }

  // Kategori bazlı paylaşım metni
  static String _buildCategoryShareText(String category, List<SavedVideo> videos, AppLocalizations l10n) {
    final buffer = StringBuffer();

    buffer.writeln('📁 ${l10n.categoryVideos(category)}');
    buffer.writeln(l10n.videosFoundInCategory(videos.length));
    buffer.writeln('');

    for (int i = 0; i < videos.length && i < 10; i++) { // Maksimum 10 video
      final video = videos[i];
      buffer.writeln('${i + 1}. ${video.title}');
      buffer.writeln('   🔗 ${video.videoUrl}');
      if (video.description.isNotEmpty && video.description.length <= 50) {
        buffer.writeln('   📝 ${video.description}');
      }
      buffer.writeln('');
    }

    if (videos.length > 10) {
      buffer.writeln(l10n.andMoreVideos(videos.length - 10));
      buffer.writeln('');
    }

    buffer.writeln('---');
    buffer.writeln('${l10n.sharedFromLinkcim} 📱');

    return buffer.toString();
  }

  // WhatsApp'a özel paylaşım
  static Future<void> shareToWhatsApp(SavedVideo video, AppLocalizations l10n) async {
    try {
      final text = _buildShareText(video, l10n);
      await Share.share(text, subject: video.title);
    } catch (e) {
      throw '${l10n.shareError}: $e';
    }
  }

  // Email'e özel paylaşım
  static Future<void> shareViaEmail(SavedVideo video, AppLocalizations l10n) async {
    try {
      final subject = '${l10n.videoInfo}: ${video.title}';
      final body = _buildDetailedShareText(video, l10n);

      await Share.share(
        body,
        subject: subject,
      );
    } catch (e) {
      throw '${l10n.shareError}: $e';
    }
  }
}