// Dosya Konumu: lib/widgets/video_card.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/widgets/tag_chip.dart';
import 'package:linkcim/widgets/video_thumbnail.dart';
import 'package:linkcim/widgets/share_menu.dart';
import 'package:linkcim/l10n/app_localizations.dart';

import 'package:linkcim/screens/video_preview_screen.dart';
import 'package:linkcim/screens/add_video_screen.dart';
import 'package:linkcim/services/database_service.dart';
import 'package:linkcim/services/analytics_service.dart';
import 'package:linkcim/models/video_collection.dart';

class VideoCard extends StatelessWidget {
  final SavedVideo video;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final String? highlightText;

  const VideoCard({
    Key? key,
    required this.video,
    this.onDelete,
    this.onTap,
    this.highlightText,
  }) : super(key: key);



  // Video açma
  Future<void> _openVideo() async {
    try {
      // Analytics: Video açıldı
      AnalyticsService().logVideoPlayed(
        platform: video.platform,
        category: video.category,
        videoId: video.key.toString(),
      );
      
      final uri = Uri.parse(video.videoUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Hata gösterme
    }
  }

  // Önizleme açma
  void _openPreview(BuildContext context) {
    // Analytics: Video önizleme açıldı
    AnalyticsService().logButtonClick(
      buttonName: 'video_preview',
      screenName: 'home_screen',
      parameters: {
        'platform': video.platform,
        'category': video.category,
      },
    );
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(video: video),
      ),
    );
  }

  // Koleksiyona ekleme dialog'u
  Future<void> _showAddToCollectionDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final dbService = DatabaseService();
    final collections = await dbService.getAllCollections();
    final videoKey = video.key.toString();

    // Video'nun zaten hangi koleksiyonlarda olduğunu bul
    final videoCollections = await dbService.getCollectionsForVideo(videoKey);
    final videoCollectionIds = videoCollections.map((c) => c.id).toSet();

    if (collections.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Önce bir koleksiyon oluşturun'),
          action: SnackBarAction(
            label: 'Tamam',
            onPressed: () {},
          ),
        ),
      );
      return;
    }

    final selectedCollections = <String>{...videoCollectionIds};

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(l10n.addToCollection),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: collections.map((collection) {
                  final isSelected = selectedCollections.contains(collection.id);
                  return CheckboxListTile(
                    title: Text(collection.name),
                    subtitle: Text(
                      l10n.videosInCollection(collection.videoCount),
                      style: TextStyle(fontSize: 12),
                    ),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedCollections.add(collection.id);
                        } else {
                          selectedCollections.remove(collection.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );

    if (result == true) {
      try {
        // Eski koleksiyonlardan çıkar
        for (final collection in videoCollections) {
          if (!selectedCollections.contains(collection.id)) {
            await dbService.removeVideoFromCollection(collection.id, videoKey);
          }
        }

        // Yeni koleksiyonlara ekle
        for (final collectionId in selectedCollections) {
          if (!videoCollectionIds.contains(collectionId)) {
            await dbService.addVideoToCollection(collectionId, videoKey);
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.videoAddedToCollection),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Platform ikonu ve rengi
  Widget _buildPlatformChip(BuildContext context) {
    final theme = Theme.of(context);
    Color platformColor;
    switch (video.platform.toLowerCase()) {
      case 'instagram':
        platformColor = Color(0xFFE4405F);
        break;
      case 'youtube':
        platformColor = Color(0xFFFF0000);
        break;
      case 'tiktok':
        platformColor = Color(0xFF000000);
        break;
      case 'twitter':
        platformColor = Color(0xFF1DA1F2);
        break;
      case 'facebook':
        platformColor = Color(0xFF1877F2);
        break;
      case 'vimeo':
        platformColor = Color(0xFF1AB7EA);
        break;
      case 'reddit':
        platformColor = Color(0xFFFF4500);
        break;
      default:
        platformColor = theme.colorScheme.onSurfaceVariant;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: platformColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: platformColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(video.platformIcon, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            video.platform.toUpperCase(),
            style: TextStyle(
              color: platformColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.surface,
      child: InkWell(
        onTap: () => _openPreview(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst kısım: Thumbnail + Bilgiler
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video thumbnail - Daha büyük ve gerçek kapak
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 120,
                      height: 90,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.shadow.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: VideoThumbnail(
                        videoUrl: video.videoUrl,
                        width: 120,
                        height: 90,
                        fit: BoxFit.cover,
                        onTap: () => _openPreview(context),
                        showPlayButton: true,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Video bilgileri
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Başlık
                        Text(
                          video.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 6),

                        // Platform chip
                        _buildPlatformChip(context),

                        const SizedBox(height: 4),

                        // Yazar ve tarih
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                video.authorDisplay,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              video.formattedDate,
                              style: TextStyle(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                ],
              ),

              const SizedBox(height: 12),

              // Açıklama (varsa)
              if (video.description.isNotEmpty) ...[
                Text(
                  video.description,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],

              // Etiketler (varsa)
              if (video.tags.isNotEmpty) ...[
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: video.tags
                      .take(3)
                      .map((tag) => TagChip(
                            tag: tag,
                            size: TagChipSize.small,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
              ],

              // Alt butonlar
              Row(
                children: [
                  // Önizleme
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _openPreview(context),
                      icon: Icon(Icons.preview, size: 16),
                      label: Text(l10n.preview),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Platform'da aç
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _openVideo,
                      icon: Icon(Icons.open_in_new, size: 16),
                      label: Text(l10n.open),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Menü
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      // Analytics: Video menü işlemi
                      AnalyticsService().logButtonClick(
                        buttonName: 'video_menu_$value',
                        screenName: 'home_screen',
                        parameters: {
                          'platform': video.platform,
                          'category': video.category,
                        },
                      );
                      
                      switch (value) {
                        case 'edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddVideoScreen(video: video),
                            ),
                          ).then((result) {
                            if (result == true && onTap != null) onTap!();
                          });
                          break;
                        case 'addToCollection':
                          await _showAddToCollectionDialog(context);
                          break;
                        case 'share':
                          ShareMenu.show(context, video);
                          break;
                        case 'delete':
                          if (onDelete != null) onDelete!();
                          break;
                      }
                    },
                    icon: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 16),
                            SizedBox(width: 8),
                            Text(l10n.edit),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'addToCollection',
                        child: Row(
                          children: [
                            Icon(Icons.folder_outlined, size: 16),
                            SizedBox(width: 8),
                            Text(l10n.addToCollection),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share, size: 16),
                            SizedBox(width: 8),
                            Text(l10n.share),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: theme.colorScheme.error),
                            SizedBox(width: 8),
                            Text(l10n.delete, style: TextStyle(color: theme.colorScheme.error)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
