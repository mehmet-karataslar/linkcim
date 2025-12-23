// Dosya Konumu: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/services/database_service.dart';
import 'package:linkcim/services/permission_service.dart';
import 'package:linkcim/services/locale_service.dart';
import 'package:linkcim/services/analytics_service.dart';

import 'package:linkcim/screens/add_video_screen.dart';
import 'package:linkcim/screens/search_screen.dart';
import 'package:linkcim/screens/settings_screen.dart';
import 'package:linkcim/screens/collections_screen.dart';
import 'package:linkcim/screens/advanced_search_screen.dart';

import 'package:linkcim/widgets/video_card.dart';
import 'package:linkcim/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<SavedVideo> videos = [];
  List<SavedVideo> filteredVideos = [];
  List<String> categories = [];
  String selectedCategoryKey = ''; // Kategori key'i (veritabanından gelen)
  bool isLoading = true;
  String? _lastLocale; // Son kullanılan locale'i takip et

  // Sistem durumu
  Map<String, dynamic> systemStatus = {};
  bool showSystemStatus = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final DatabaseService _dbService = DatabaseService();

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadData();
    _checkAndRequestPermissions();

    _animationController.forward();
    
    // Analytics: Ana sayfa görüntüleme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AnalyticsService().logScreenView(screenName: 'home_screen');
    });
  }

  // Dil değişikliğini dinle
  void _onLocaleChanged() {
    if (mounted) {
      _updateCategoriesForLocale();
    }
  }

  // İzin kontrolü ve isteme
  Future<void> _checkAndRequestPermissions() async {
    // Widget'ın mount olmasını bekle
    await Future.delayed(Duration(milliseconds: 500));
    
    if (!mounted) return;

    // Daha önce izin istenmiş mi kontrol et
    final hasRequested = await PermissionService.hasRequestedPermissions();
    if (hasRequested) {
      // Daha önce istenmişse sadece kontrol et
      final permissions = await PermissionService.checkPermissions();
      if (!(permissions['all'] ?? false)) {
        // İzin verilmemişse tekrar iste
        _requestPermissions();
      }
      return;
    }

    // İlk açılış - izin dialog'unu göster
    final shouldRequest = await PermissionService.showPermissionDialog(context);
    if (shouldRequest == true) {
      _requestPermissions();
    }
  }

  // İzinleri iste
  Future<void> _requestPermissions() async {
    final results = await PermissionService.requestPermissions();
    final allGranted = results['all'] == PermissionStatus.granted;

    if (!mounted) return;

    final l10n = AppLocalizations.of(context)!;
    if (allGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Text(l10n.permissionsGranted)),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.all(16),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning, color: Colors.white),
              SizedBox(width: 12),
              Expanded(child: Text(l10n.permissionsDenied)),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.all(16),
          action: SnackBarAction(
            label: l10n.settings,
            textColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    try {
      final allVideos = await _dbService.getAllVideos();
      final allCategories = await _dbService.getAllCategories();

      final l10n = AppLocalizations.of(context)!;
      setState(() {
        videos = allVideos;
        filteredVideos = allVideos;
        // İlk yüklemede "Tümü" seçili olsun
        if (selectedCategoryKey.isEmpty) {
          selectedCategoryKey = ''; // '' = Tümü
        }
        // Kategorileri lokalizasyona göre ayarla
        categories = [l10n.allCategories, ...allCategories];
        isLoading = false;
      });

      _animationController.reset();
      _animationController.forward();
    } catch (e) {
      setState(() => isLoading = false);
      final l10n = AppLocalizations.of(context)!;
      _showError('${l10n.dataLoadError}: $e');
    }
  }

  // Kategorileri mevcut dile göre güncelle
  Future<void> _updateCategoriesForLocale() async {
    if (!mounted) return;
    
    try {
      final dbCategories = await _dbService.getAllCategories();
      if (!mounted) return;
      
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        categories = [l10n.allCategories, ...dbCategories];
        // Seçili kategoriyi koru ama filtrelemeyi yeniden yap
        _filterByCategoryKey(selectedCategoryKey);
      });
    } catch (e) {
      print('Kategori güncelleme hatası: $e');
    }
  }



  void _filterByCategory(String category) {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      // Eğer "Tümü" seçildiyse
      if (category == l10n.allCategories) {
        selectedCategoryKey = '';
        filteredVideos = videos;
        // Analytics: Tüm kategoriler seçildi
        AnalyticsService().logCategorySelected(
          categoryName: 'all',
          videoCount: videos.length,
        );
      } else {
        // Diğer kategoriler için veritabanındaki kategori adını kullan
        selectedCategoryKey = category;
        filteredVideos = videos.where((v) => v.category == category).toList();
        // Analytics: Kategori seçildi
        AnalyticsService().logCategorySelected(
          categoryName: category,
          videoCount: filteredVideos.length,
        );
      }
    });
  }

  // Kategori key'ine göre filtrele (dil değiştiğinde kullanılır)
  void _filterByCategoryKey(String categoryKey) {
    setState(() {
      if (categoryKey.isEmpty) {
        // Tümü seçili
        filteredVideos = videos;
      } else {
        filteredVideos = videos.where((v) => v.category == categoryKey).toList();
      }
    });
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filterByCategoryKey(selectedCategoryKey);
      } else {
        filteredVideos = videos.where((v) => v.matchesSearch(query)).toList();
        // Analytics: Arama yapıldı
        AnalyticsService().logSearch(
          searchQuery: query,
          resultCount: filteredVideos.length,
          searchType: 'home_search',
        );
      }
    });
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Future<void> _deleteVideo(SavedVideo video) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.delete_forever, color: Theme.of(context).colorScheme.error),
            SizedBox(width: 8),
            Text(l10n.videoDelete),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.confirmDelete),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                video.title,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            child: Text(l10n.delete, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _dbService.deleteVideo(video);
        // Analytics: Video silindi
        AnalyticsService().logVideoDeleted(
          platform: video.platform,
          category: video.category,
        );
        _showSuccess(l10n.videoDeleted);
        _loadData();
      } catch (e) {
        _showError('${l10n.videoDeleteError}: $e');
      }
    }
  }

  Widget _buildSystemStatusBanner() {
    if (!showSystemStatus || videos.isEmpty) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.blue[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.videoStatistics,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () => setState(() => showSystemStatus = false),
                icon: Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 16),

          // İstatistik kartları
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  Icons.video_library,
                  AppLocalizations.of(context)!.totalVideos,
                  '${videos.length}',
                  Colors.white.withOpacity(0.2),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  Icons.category,
                  AppLocalizations.of(context)!.categories,
                  '${categories.length - 1}',
                  Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Platform dağılımı
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.platformDistribution,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                _buildPlatformStats(),
              ],
            ),
          ),

          SizedBox(height: 12),

          // Kategori dağılımı
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.popularCategories,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                _buildCategoryStats(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      IconData icon, String label, String value, Color backgroundColor) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformStats() {
    if (videos.isEmpty) return SizedBox.shrink();

    final platforms = <String, int>{};
    for (final video in videos) {
      final platformName = video.platform.isNotEmpty ? video.platform : 'Genel';
      platforms[platformName] = (platforms[platformName] ?? 0) + 1;
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: platforms.entries.map((entry) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Text(
            '${entry.key}: ${entry.value}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryStats() {
    if (videos.isEmpty) return SizedBox.shrink();

    final categories = <String, int>{};
    for (final video in videos) {
      categories[video.category] = (categories[video.category] ?? 0) + 1;
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: categories.entries.take(5).map((entry) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Text(
            '${entry.key}: ${entry.value}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // LocaleService'i dinle - dil değiştiğinde kategorileri güncelle
    final localeService = Provider.of<LocaleService>(context, listen: true);
    final currentLocale = localeService.currentLocale.languageCode;
    
    // Dil değiştiğinde kategorileri güncelle
    if (_lastLocale != null && _lastLocale != currentLocale && categories.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateCategoriesForLocale();
      });
    }
    _lastLocale = currentLocale;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/icons/iconumuz.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/icons/icon.png',
                  width: 24,
                  height: 24,
                );
              },
            ),
            SizedBox(width: 8),
            Text(AppLocalizations.of(context)!.appTitle),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [




          // Koleksiyonlar
          IconButton(
            icon: Icon(Icons.folder_outlined),
            onPressed: () {
              AnalyticsService().logButtonClick(
                buttonName: 'collections_button',
                screenName: 'home_screen',
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CollectionsScreen()),
              ).then((_) => _loadData());
            },
            tooltip: AppLocalizations.of(context)!.collections,
          ),

          // Gelişmiş Arama
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              AnalyticsService().logButtonClick(
                buttonName: 'advanced_search_button',
                screenName: 'home_screen',
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdvancedSearchScreen()),
              ).then((_) => _loadData());
            },
            tooltip: AppLocalizations.of(context)!.advancedSearch,
          ),

          // Arama
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              AnalyticsService().logButtonClick(
                buttonName: 'search_button',
                screenName: 'home_screen',
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              ).then((_) => _loadData());
            },
          ),

          // Ayarlar
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              AnalyticsService().logButtonClick(
                buttonName: 'settings_button',
                screenName: 'home_screen',
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              ).then((_) => _checkSystemStatus());
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Sistem durumu banner'ı


            // Arama çubuğu
            CustomSearchBar(
              onSearch: _onSearch,
              hintText: AppLocalizations.of(context)!.searchVideos,
            ),

            // Kategori filtreleri
            if (categories.isNotEmpty)
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final l10n = AppLocalizations.of(context)!;
                    // İlk kategori "Tümü" ise, selectedCategoryKey boş olmalı
                    final isSelected = index == 0 
                        ? selectedCategoryKey.isEmpty
                        : category == selectedCategoryKey;
                    final theme = Theme.of(context);

                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 16 : 8,
                        right: 8,
                      ),
                      child: FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (_) => _filterByCategory(category),
                        selectedColor: theme.colorScheme.primaryContainer,
                        checkmarkColor: theme.colorScheme.onPrimaryContainer,
                        backgroundColor: theme.colorScheme.surfaceVariant,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Video listesi
            Expanded(
              child: isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(AppLocalizations.of(context)!.videosLoading),
                        ],
                      ),
                    )
                  : filteredVideos.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                          onRefresh: _loadData,
                          child: ListView.builder(
                            padding: EdgeInsets.all(16),
                            itemCount: filteredVideos.length,
                            itemBuilder: (context, index) {
                              final video = filteredVideos[index];
                              return VideoCard(
                                video: video,
                                onDelete: () => _deleteVideo(video),
                                onTap: () => _loadData(), // Refresh after edit
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AnalyticsService().logButtonClick(
            buttonName: 'add_video_fab',
            screenName: 'home_screen',
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVideoScreen()),
          ).then((result) {
            if (result == true) {
              _loadData();
            }
          });
        },
        icon: Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.newVideo),
        tooltip: AppLocalizations.of(context)!.addVideo,
      ),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/icons/iconumuz.png',
                width: 48,
                height: 48,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/icons/icon.png',
                    width: 48,
                    height: 48,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              videos.isEmpty ? l10n.noVideos : l10n.noVideoFound,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              videos.isEmpty
                  ? l10n.addFirstVideo
                  : l10n.tryDifferentKeywords,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            if (videos.isEmpty) ...[
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddVideoScreen()),
                  ).then((result) {
                    if (result == true) {
                      _loadData();
                    }
                  });
                },
                icon: Icon(Icons.add),
                label: Text(l10n.addFirstVideoButton),
              ),
              SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: [
                  _buildFeatureChip('🎯 ${l10n.category}'),
                  _buildFeatureChip('🔍 ${l10n.search}'),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(String text) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  
  void _checkSystemStatus() {
    // System status check - can be implemented later
  }
}
