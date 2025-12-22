// Dosya Konumu: lib/screens/add_video_screen.dart

import 'package:flutter/material.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/services/database_service.dart';
import 'package:linkcim/utils/constants.dart';

class AddVideoScreen extends StatefulWidget {
  final SavedVideo? video;

  AddVideoScreen({this.video});

  @override
  _AddVideoScreenState createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _tagController = TextEditingController();

  List<String> tags = [];
  bool isEditing = false;

  final DatabaseService _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();

    if (widget.video != null) {
      isEditing = true;
      _populateFields();
    }
  }

  void _populateFields() {
    final video = widget.video!;
    _urlController.text = video.videoUrl;
    _titleController.text = video.title;
    _descriptionController.text = video.description;
    _categoryController.text = video.category;
    tags = List.from(video.tags);
  }

  // 🏷️ Etiket Yönetimi
  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !tags.contains(tag) && tags.length < 10) {
      setState(() {
        tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() => tags.remove(tag));
  }

  // 💾 Video Kaydetme
  Future<void> _saveVideo() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;
    
    if (_urlController.text.isNotEmpty &&
        !AppConstants.isValidVideoUrl(_urlController.text)) {
      _showError(l10n.invalidUrl);
      return;
    }

    try {
      if (isEditing) {
        // Güncelleme
        widget.video!.videoUrl = _urlController.text.trim();
        widget.video!.title = _titleController.text.trim();
        widget.video!.description = _descriptionController.text.trim();
        widget.video!.category = _categoryController.text.trim();
        widget.video!.tags = tags;

        await _dbService.updateVideo(widget.video!);
        _showSuccess(l10n.videoUpdated);
      } else {
        // Yeni video ekleme
        final video = SavedVideo.create(
          videoUrl: _urlController.text.trim(),
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _categoryController.text.trim(),
          tags: tags,
          authorName: '',
          authorUsername: '',
          platform: AppConstants.detectPlatform(_urlController.text.trim()),
        );

        await _dbService.addVideo(video);
        _showSuccess(l10n.videoSaved);
      }

      Navigator.of(context).pop(true);
    } catch (e) {
      _showError('${l10n.saveError}: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          isEditing ? l10n.editVideo : l10n.addVideo,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Başlık
              Text(
                isEditing
                    ? '✏️ ${l10n.editVideoInfo}'
                    : '🎬 ${l10n.newVideo}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 8),
              Text(
                l10n.videoInfoDescription,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 32),

              // URL girişi
              _buildInputCard(
                child: TextFormField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    labelText: l10n.videoUrl,
                    hintText: l10n.enterVideoUrl,
                    border: InputBorder.none,
                    prefixIcon: Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          Icon(Icons.link, color: theme.colorScheme.primary, size: 20),
                    ),
                    suffixIcon: _urlController.text.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.all(12),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(
                                  AppConstants.getPlatformColor(
                                      AppConstants.detectPlatform(
                                          _urlController.text))),
                              child: Text(
                                AppConstants.platformEmojis[
                                        AppConstants.detectPlatform(
                                            _urlController.text)] ??
                                    '🎬',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          )
                        : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.videoUrlRequired;
                    }
                    if (!AppConstants.isValidVideoUrl(value)) {
                      return l10n.invalidUrl;
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() {}),
                ),
              ),

              SizedBox(height: 20),

              // Başlık girişi
              _buildInputCard(
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: l10n.videoTitle,
                    hintText: l10n.enterTitle,
                    border: InputBorder.none,
                    prefixIcon: Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.title,
                          color: theme.colorScheme.onSecondaryContainer, size: 20),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.titleRequired;
                    }
                    return null;
                  },
                  maxLength: 150,
                ),
              ),

              SizedBox(height: 20),

              // Açıklama girişi
              _buildInputCard(
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: l10n.videoDescription,
                    hintText: l10n.enterDescription,
                    border: InputBorder.none,
                    prefixIcon: Container(
                      margin: EdgeInsets.all(12),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.description,
                          color: theme.colorScheme.onTertiaryContainer, size: 20),
                    ),
                    alignLabelWithHint: true,
                  ),
                  maxLength: 500,
                ),
              ),

              SizedBox(height: 20),

              // Kategori girişi
              _buildInputCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _categoryController,
                      decoration: InputDecoration(
                        labelText: l10n.category,
                        hintText: l10n.selectCategory,
                        border: InputBorder.none,
                        prefixIcon: Container(
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.category,
                              color: theme.colorScheme.onErrorContainer, size: 20),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.categoryRequired;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: AppConstants.getDefaultCategories(l10n).map((category) {
                        final isSelected = _categoryController.text == category;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _categoryController.text = category;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.primaryContainer
                                  : theme.colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline,
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected
                                    ? theme.colorScheme.onPrimaryContainer
                                    : theme.colorScheme.onSurfaceVariant,
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Etiket girişi
              _buildInputCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _tagController,
                            decoration: InputDecoration(
                              labelText: l10n.addTag,
                              hintText: l10n.enterTag,
                              border: InputBorder.none,
                              prefixIcon: Container(
                                margin: EdgeInsets.all(12),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.tag,
                                    color: theme.colorScheme.primary, size: 20),
                              ),
                              suffixText: l10n.tagsCount(tags.length),
                            ),
                            onFieldSubmitted: (_) => _addTag(),
                            enabled: tags.length < 10,
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            onPressed: tags.length < 10 ? _addTag : null,
                            icon: Icon(Icons.add, color: theme.colorScheme.onPrimaryContainer),
                          ),
                        ),
                      ],
                    ),
                    if (tags.isNotEmpty) ...[
                      SizedBox(height: 16),
                      Text(
                        l10n.tagsCount(tags.length),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: tags.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: theme.colorScheme.primary),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tag,
                                  style: TextStyle(
                                    color: theme.colorScheme.onPrimaryContainer,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () => _removeTag(tag),
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: theme.colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 40),

              // Kaydet butonu
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveVideo,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isEditing ? Icons.update : Icons.save,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        isEditing ? l10n.update : l10n.save,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({required Widget child}) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(4),
      child: child,
    );
  }
}
