// Dosya Konumu: lib/screens/video_preview_screen.dart

import 'package:flutter/material.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/widgets/video_thumbnail.dart';
import 'package:linkcim/widgets/share_menu.dart';
import 'package:linkcim/widgets/tag_chip.dart';
import 'package:linkcim/screens/video_player_screen.dart';
import 'package:linkcim/screens/add_video_screen.dart';
import 'package:linkcim/services/share_service.dart';
import 'package:linkcim/services/instagram_service.dart';
import 'package:linkcim/services/analytics_service.dart';
import 'package:url_launcher/url_launcher.dart';


class VideoPreviewScreen extends StatefulWidget {
  final SavedVideo video;

  const VideoPreviewScreen({Key? key, required this.video}) : super(key: key);

  @override
  _VideoPreviewScreenState createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  Map<String, dynamic>? metaData;
  bool isLoadingMeta = true;

  @override
  void initState() {
    super.initState();
    _loadVideoMetadata();
    
    // Analytics: Video önizleme sayfası görüntüleme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AnalyticsService().logScreenView(screenName: 'video_preview_screen');
      AnalyticsService().logVideoPlayed(
        platform: widget.video.platform,
        category: widget.video.category,
        videoId: widget.video.key.toString(),
      );
    });
  }

  Future<void> _loadVideoMetadata() async {
    try {
      final data =
          await InstagramService.getVideoMetadata(widget.video.videoUrl);
      setState(() {
        metaData = data;
        isLoadingMeta = false;
      });
    } catch (e) {
      setState(() {
        isLoadingMeta = false;
      });
    }
  }

  Future<void> _openInPlatform() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      // Analytics: Platform'da aç butonu
      AnalyticsService().logButtonClick(
        buttonName: 'open_in_platform',
        screenName: 'video_preview_screen',
        parameters: {
          'platform': widget.video.platform,
        },
      );
      
      final uri = Uri.parse(widget.video.videoUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        // Analytics: Video platform'da açıldı
        AnalyticsService().logVideoPlayed(
          platform: widget.video.platform,
          category: widget.video.category,
          videoId: widget.video.key.toString(),
        );
      } else {
        _showError(l10n.couldNotOpen(_getPlatformName(context)));
      }
    } catch (e) {
      _showError('${l10n.linkOpenError}: $e');
    }
  }

  String _getPlatformName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (widget.video.platform.toLowerCase()) {
      case 'instagram':
        return l10n.platformInstagram;
      case 'youtube':
        return l10n.platformYouTube;
      case 'tiktok':
        return l10n.platformTikTok;
      case 'twitter':
        return l10n.platformTwitter;
      default:
        return l10n.platformGeneral;
    }
  }

  String _getPlatformActionText(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (widget.video.platform.toLowerCase()) {
      case 'instagram':
        return l10n.openInInstagram;
      case 'youtube':
        return l10n.openInYouTube;
      case 'tiktok':
        return l10n.openInTikTok;
      case 'twitter':
        return l10n.openInTwitter;
      default:
        return l10n.openInPlatform;
    }
  }

  void _openVideoPlayer() {
    // Analytics: Video oynatıcı açıldı
    AnalyticsService().logButtonClick(
      buttonName: 'open_video_player',
      screenName: 'video_preview_screen',
      parameters: {
        'platform': widget.video.platform,
      },
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(video: widget.video),
      ),
    );
  }

  void _editVideo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddVideoScreen(video: widget.video),
      ),
    ).then((result) {
      if (result == true) {
        Navigator.of(context).pop(true); // Değişiklik oldu, geri dön
      }
    });
  }

  void _showError(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: theme.colorScheme.onError),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showSuccess(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: theme.colorScheme.onPrimary),
            SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Color _getPlatformColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (widget.video.platform.toLowerCase()) {
      case 'instagram':
        return Colors.purple;
      case 'youtube':
        return Colors.red;
      case 'tiktok':
        return theme.brightness == Brightness.dark ? Colors.white : Colors.black;
      case 'twitter':
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.onSurfaceVariant;
    }
  }

  String _getVideoType(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final url = widget.video.videoUrl.toLowerCase();
    if (url.contains('/reel/')) return l10n.instagramReel;
    if (url.contains('/tv/')) return l10n.igtv;
    if (url.contains('/p/')) return l10n.instagramPost;
    if (url.contains('youtube.com')) return l10n.youtubeVideo;
    if (url.contains('tiktok.com')) return l10n.tiktokVideo;
    if (url.contains('twitter.com')) return l10n.twitterVideo;
    return l10n.video;
  }

  Widget _buildDetailRow(
      BuildContext context, String label, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.preview),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editVideo,
            tooltip: l10n.edit,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => ShareMenu.show(context, widget.video),
            tooltip: l10n.share,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video thumbnail büyük görünüm
            LargeVideoThumbnail(
              videoUrl: widget.video.videoUrl,
              customThumbnailUrl: metaData?['thumbnail'],
              onTap: _openVideoPlayer,
            ),

            SizedBox(height: 16),

            // Video başlığı
            Text(
              widget.video.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            // Platform ve yazar bilgisi
            Row(
              children: [
                Text(
                  widget.video.platformIcon,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 4),
                Text(
                  widget.video.platform.toUpperCase(),
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.video.authorDisplay,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8),

            // Meta bilgiler
            Row(
              children: [
                Icon(Icons.category, size: 16, color: theme.colorScheme.onSurfaceVariant),
                SizedBox(width: 4),
                Text(
                  widget.video.category,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: theme.colorScheme.onSurfaceVariant),
                SizedBox(width: 4),
                Text(
                  widget.video.formattedDate,
                  style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Video açıklaması
            if (widget.video.description.isNotEmpty) ...[
              Text(
                l10n.videoDescription,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.video.description,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 16),
            ],

            // Etiketler
            if (widget.video.tags.isNotEmpty) ...[
              Text(
                l10n.tags,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.video.tags.map((tag) {
                  return TagChip(
                    tag: tag,
                    size: TagChipSize.medium,
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
            ],

            // Instagram meta bilgileri
            if (metaData != null && metaData!['success'] == true) ...[
              Text(
                l10n.instagramInfo,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (metaData!['author'] != null)
                      Text('${l10n.author}: ${metaData!['author']}'),
                    if (metaData!['postType'] != null)
                      Text('${l10n.postType}: ${metaData!['postType']}'),
                    if (metaData!['postId'] != null)
                      Text('${l10n.postId}: ${metaData!['postId']}'),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],

            // Loading indicator for meta data
            if (isLoadingMeta) ...[
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text(l10n.loadingInstagramInfo),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _openVideoPlayer,
                    icon: Icon(Icons.play_arrow),
                    label: Text(l10n.playInApp),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _openInPlatform,
                    icon: Icon(Icons.open_in_new),
                    label: Text(_getPlatformActionText(context)),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Paylaşma butonları
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      try {
                        await ShareService.copyLinkToClipboard(
                            widget.video.videoUrl, l10n);
                        _showSuccess(l10n.linkCopied);
                      } catch (e) {
                        _showError(l10n.copyError);
                      }
                    },
                    icon: Icon(Icons.copy),
                    label: Text(l10n.copyLink),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => ShareMenu.show(context, widget.video),
                    icon: Icon(Icons.share),
                    label: Text(l10n.share),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Link Detayları Bölümü - Gelişmiş
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.link, color: theme.colorScheme.onPrimary, size: 20),
                        SizedBox(width: 8),
                        Text(
                          l10n.linkDetails,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // İçerik
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Platform Bilgisi
                        _buildDetailRow(
                          context,
                          l10n.platform,
                          _getPlatformName(context),
                          Icons.public,
                          _getPlatformColor(context),
                        ),

                        SizedBox(height: 12),

                        // Video Türü
                        _buildDetailRow(
                          context,
                          l10n.videoType,
                          _getVideoType(context),
                          Icons.video_library,
                          theme.colorScheme.secondary,
                        ),

                        SizedBox(height: 12),

                        // URL Detayı
                        _buildDetailRow(
                          context,
                          l10n.urlLength,
                          '${widget.video.videoUrl.length} ${l10n.characters}',
                          Icons.text_fields,
                          theme.colorScheme.tertiary,
                        ),

                        SizedBox(height: 16),

                        // Tam URL
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${l10n.fullUrl}:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              SizedBox(height: 6),
                              SelectableText(
                                widget.video.videoUrl,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.colorScheme.primary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        // URL Kopyalama Butonu
                        Container(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              try {
                                await ShareService.copyLinkToClipboard(
                                    widget.video.videoUrl, l10n);
                                _showSuccess(l10n.linkCopied);
                              } catch (e) {
                                _showError(l10n.copyError);
                              }
                            },
                            icon: Icon(Icons.copy, size: 18),
                            label: Text(l10n.copyLink),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
