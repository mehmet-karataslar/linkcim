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

class _AddVideoScreenState extends State<AddVideoScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _tagController = TextEditingController();

  List<String> tags = [];
  bool isEditing = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final DatabaseService _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    if (widget.video != null) {
      isEditing = true;
      _populateFields();
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _urlController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _tagController.dispose();
    super.dispose();
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
        widget.video!.videoUrl = _urlController.text.trim();
        widget.video!.title = _titleController.text.trim();
        widget.video!.description = _descriptionController.text.trim();
        widget.video!.category = _categoryController.text.trim();
        widget.video!.tags = tags;

        await _dbService.updateVideo(widget.video!);
        _showSuccess(l10n.videoUpdated);
      } else {
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
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: theme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  void _showSuccess(String message) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: theme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, size: 18),
            color: theme.colorScheme.onSurface,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          isEditing ? l10n.editVideo : l10n.addVideo,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primaryContainer.withOpacity(0.3),
                theme.colorScheme.secondaryContainer.withOpacity(0.2),
                theme.scaffoldBackgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    
                    // Hero Section
                    _buildHeroSection(l10n, theme),
                    
                    SizedBox(height: 32),

                    // URL Input
                    _buildModernInputField(
                      controller: _urlController,
                      label: l10n.videoUrl,
                      hint: l10n.enterVideoUrl,
                      icon: Icons.link_rounded,
                      color: theme.colorScheme.primary,
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
                      suffix: _urlController.text.isNotEmpty
                          ? _buildPlatformBadge(_urlController.text, theme)
                          : null,
                    ),

                    SizedBox(height: 24),

                    // Title Input
                    _buildModernInputField(
                      controller: _titleController,
                      label: l10n.videoTitle,
                      hint: l10n.enterTitle,
                      icon: Icons.title_rounded,
                      color: theme.colorScheme.secondary,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.titleRequired;
                        }
                        return null;
                      },
                      maxLength: 150,
                    ),

                    SizedBox(height: 24),

                    // Description Input
                    _buildModernInputField(
                      controller: _descriptionController,
                      label: l10n.videoDescription,
                      hint: l10n.enterDescription,
                      icon: Icons.description_rounded,
                      color: theme.colorScheme.tertiary,
                      maxLines: 4,
                      maxLength: 500,
                    ),

                    SizedBox(height: 24),

                    // Category Section
                    _buildCategorySection(l10n, theme),

                    SizedBox(height: 24),

                    // Tags Section
                    _buildTagsSection(l10n, theme),

                    SizedBox(height: 40),

                    // Save Button
                    _buildSaveButton(l10n, theme),

                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(AppLocalizations l10n, ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.1),
            theme.colorScheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isEditing ? Icons.edit_rounded : Icons.add_circle_rounded,
              size: 32,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: 16),
          Text(
            isEditing ? l10n.editVideoInfo : l10n.newVideo,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            l10n.videoInfoDescription,
            style: TextStyle(
              fontSize: 15,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color color,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    int maxLines = 1,
    int? maxLength,
    Widget? suffix,
  }) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        maxLength: maxLength,
        validator: validator,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 16,
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
          ),
          labelStyle: TextStyle(
            color: theme.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          prefixIcon: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          suffixIcon: suffix,
          counterText: '',
        ),
      ),
    );
  }

  Widget _buildPlatformBadge(String url, ThemeData theme) {
    final platform = AppConstants.detectPlatform(url);
    final emoji = AppConstants.platformEmojis[platform] ?? '🎬';
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: 16)),
          SizedBox(width: 6),
          Text(
            platform,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(AppLocalizations l10n, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Row(
            children: [
              Icon(Icons.category_rounded, size: 20, color: theme.colorScheme.primary),
              SizedBox(width: 8),
              Text(
                l10n.category,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _categoryController,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: l10n.selectCategory,
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.categoryRequired;
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: AppConstants.getDefaultCategories(l10n).map((category) {
                  final isSelected = _categoryController.text == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _categoryController.text = category;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outline.withOpacity(0.3),
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                            size: 18,
                            color: isSelected
                                ? theme.colorScheme.onPrimaryContainer
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 8),
                          Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? theme.colorScheme.onPrimaryContainer
                                  : theme.colorScheme.onSurfaceVariant,
                              fontSize: 14,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagsSection(AppLocalizations l10n, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Row(
            children: [
              Icon(Icons.tag_rounded, size: 20, color: theme.colorScheme.secondary),
              SizedBox(width: 8),
              Text(
                l10n.tags,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${tags.length}/10',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _tagController,
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: l10n.enterTag,
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.tag_rounded,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      onFieldSubmitted: (_) => _addTag(),
                      enabled: tags.length < 10,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.secondary,
                          theme.colorScheme.secondary.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: tags.length < 10 ? _addTag : null,
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          padding: EdgeInsets.all(14),
                          child: Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (tags.isNotEmpty) ...[
                SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.secondaryContainer,
                            theme.colorScheme.secondaryContainer.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.secondary,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.label_rounded,
                            size: 16,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                          SizedBox(width: 8),
                          Text(
                            tag,
                            style: TextStyle(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _removeTag(tag),
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.errorContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                size: 14,
                                color: theme.colorScheme.onErrorContainer,
                              ),
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
      ],
    );
  }

  Widget _buildSaveButton(AppLocalizations l10n, ThemeData theme) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.4),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _saveVideo,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isEditing ? Icons.update_rounded : Icons.save_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                SizedBox(width: 12),
                Text(
                  isEditing ? l10n.update : l10n.save,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
