// Dosya Konumu: lib/widgets/share_menu.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/l10n/app_localizations.dart';

class ShareMenu extends StatelessWidget {
  final SavedVideo video;

  const ShareMenu({Key? key, required this.video}) : super(key: key);

  static Future<void> show(BuildContext context, SavedVideo video) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareMenu(video: video),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.all(16),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            SizedBox(height: 16),

            // Başlık
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    l10n.share,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    video.title,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Paylaş seçenekleri
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Video linkini paylaş
                  _buildShareButton(
                    context: context,
                    icon: Icons.share,
                    title: l10n.shareVideoLink,
                    subtitle: l10n.shareVideoLinkDesc,
                    onTap: () => _shareVideoLink(context),
                  ),

                  SizedBox(height: 10),

                  // Video detaylarını paylaş
                  _buildShareButton(
                    context: context,
                    icon: Icons.description,
                    title: l10n.shareDetailedInfo,
                    subtitle: l10n.shareDetailedInfoDesc,
                    onTap: () => _shareVideoDetails(context),
                  ),

                  SizedBox(height: 10),

                  // Link kopyala
                  _buildShareButton(
                    context: context,
                    icon: Icons.copy,
                    title: l10n.copyLink,
                    subtitle: l10n.copyLinkDesc,
                    onTap: () => _copyLink(context),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // İptal butonu
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    l10n.cancel,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.onPrimaryContainer,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _shareVideoLink(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await Share.share(
        video.videoUrl,
        subject: video.title,
      );
      Navigator.of(context).pop();
      _showSuccess(context, l10n.videoLinkShared);
    } catch (e) {
      _showError(context, '${l10n.shareError}: $e');
    }
  }

  void _shareVideoDetails(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final shareText = '''
🎬 ${video.title}

📱 Link: ${video.videoUrl}

📝 ${l10n.videoDescription}: ${video.description.isNotEmpty ? video.description : l10n.noDescription}

🏷️ ${l10n.category}: ${video.category}

${video.tags.isNotEmpty ? '🔖 ${l10n.tags}: ${video.tags.join(', ')}' : ''}

📅 ${video.formattedDate}

---
${l10n.sharedFromLinkcim} 📱
''';

      await Share.share(
        shareText,
        subject: '${l10n.videoInfo}: ${video.title}',
      );
      Navigator.of(context).pop();
      _showSuccess(context, l10n.videoDetailsShared);
    } catch (e) {
      _showError(context, '${l10n.shareError}: $e');
    }
  }

  void _copyLink(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await Clipboard.setData(ClipboardData(text: video.videoUrl));
      Navigator.of(context).pop();
      _showSuccess(context, l10n.linkCopied);
    } catch (e) {
      _showError(context, '${l10n.copyError}: $e');
    }
  }

  void _showSuccess(BuildContext context, String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: theme.colorScheme.tertiary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// Basit paylaşma butonu widget'ı
class ShareButton extends StatelessWidget {
  final SavedVideo video;
  final IconData? icon;
  final String? tooltip;

  const ShareButton({
    Key? key,
    required this.video,
    this.icon = Icons.share,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip ?? l10n.share,
      onPressed: () => ShareMenu.show(context, video),
    );
  }
}

// Hızlı paylaşma widget'ı (sadece link)
class QuickShareButton extends StatelessWidget {
  final SavedVideo video;

  const QuickShareButton({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return IconButton(
      icon: Icon(Icons.ios_share),
      tooltip: l10n.quickShare,
      onPressed: () async {
        try {
          await Share.share(video.videoUrl, subject: video.title);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.videoShared),
              backgroundColor: theme.colorScheme.tertiary,
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.shareFailed(e.toString())),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
    );
  }
}
