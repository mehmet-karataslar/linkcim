// Dosya Konumu: lib/screens/advanced_search_screen.dart

import 'package:flutter/material.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/services/database_service.dart';
import 'package:linkcim/widgets/video_card.dart';
import 'package:linkcim/screens/add_video_screen.dart';

class AdvancedSearchScreen extends StatefulWidget {
  @override
  _AdvancedSearchScreenState createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final _searchController = TextEditingController();
  final DatabaseService _dbService = DatabaseService();

  List<SavedVideo> allVideos = [];
  List<SavedVideo> filteredVideos = [];
  bool isLoading = false;

  // Filtreler
  String selectedPlatform = '';
  String selectedCategory = '';
  List<String> selectedTags = [];
  DateTime? fromDate;
  DateTime? toDate;
  String sortBy = 'newest'; // newest, oldest, title, platform

  // Seçenekler
  List<String> platforms = [];
  List<String> categories = [];
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);
    try {
      final videos = await _dbService.getAllVideos();
      final allPlatforms = await _dbService.getAllPlatforms();
      final allCategories = await _dbService.getAllCategories();
      final allTags = await _dbService.getAllTags();

      setState(() {
        allVideos = videos;
        filteredVideos = videos;
        platforms = allPlatforms;
        categories = allCategories;
        tags = allTags;
        isLoading = false;
      });
      _applyFilters();
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _applyFilters() {
    List<SavedVideo> results = List.from(allVideos);

    // Metin araması
    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      results = results.where((video) => video.matchesSearch(query)).toList();
    }

    // Platform filtresi
    if (selectedPlatform.isNotEmpty) {
      results = results.where((video) =>
          video.platform.toLowerCase() == selectedPlatform.toLowerCase()).toList();
    }

    // Kategori filtresi
    if (selectedCategory.isNotEmpty) {
      results = results.where((video) => video.category == selectedCategory).toList();
    }

    // Etiket filtresi
    if (selectedTags.isNotEmpty) {
      results = results.where((video) =>
          selectedTags.any((tag) => video.tags.contains(tag))).toList();
    }

    // Tarih aralığı filtresi
    if (fromDate != null) {
      results = results.where((video) => video.createdAt.isAfter(fromDate!) ||
          video.createdAt.isAtSameMomentAs(fromDate!)).toList();
    }
    if (toDate != null) {
      final toDateEnd = DateTime(toDate!.year, toDate!.month, toDate!.day, 23, 59, 59);
      results = results.where((video) => video.createdAt.isBefore(toDateEnd) ||
          video.createdAt.isAtSameMomentAs(toDateEnd)).toList();
    }

    // Sıralama
    switch (sortBy) {
      case 'newest':
        results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'oldest':
        results.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case 'title':
        results.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'platform':
        results.sort((a, b) => a.platform.toLowerCase().compareTo(b.platform.toLowerCase()));
        break;
    }

    setState(() {
      filteredVideos = results;
    });
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      selectedPlatform = '';
      selectedCategory = '';
      selectedTags = [];
      fromDate = null;
      toDate = null;
      sortBy = 'newest';
    });
    _applyFilters();
  }

  Future<void> _selectDate(bool isFromDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? (fromDate ?? DateTime.now()) : (toDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
      _applyFilters();
    }
  }

  Future<void> _selectTags() async {
    final l10n = AppLocalizations.of(context)!;
    List<String> tempSelected = List<String>.from(selectedTags);
    
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(l10n.filterTags),
            content: Container(
              width: double.maxFinite,
              constraints: BoxConstraints(maxHeight: 400),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: tags.map((tag) {
                    final isSelected = tempSelected.contains(tag);
                    return CheckboxListTile(
                      title: Text(tag),
                      value: isSelected,
                      onChanged: (value) {
                        setDialogState(() {
                          if (value == true) {
                            tempSelected.add(tag);
                          } else {
                            tempSelected.remove(tag);
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
                child: Text(l10n.applyFilters),
              ),
            ],
          );
        },
      ),
    );

    if (result == true) {
      setState(() {
        selectedTags = tempSelected;
      });
      _applyFilters();
    }
  }

  Future<void> _deleteVideo(SavedVideo video) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.videoDelete),
        content: Text(l10n.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _dbService.deleteVideo(video);
        _loadData();
      } catch (e) {
        // Hata göster
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.advancedSearch),
        actions: [
          if (_hasActiveFilters())
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: _clearFilters,
              tooltip: l10n.clearFilters,
            ),
        ],
      ),
      body: Column(
        children: [
          // Arama çubuğu
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: l10n.searchPlaceholder,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _applyFilters();
                        },
                      )
                    : null,
              ),
              onChanged: (_) => _applyFilters(),
            ),
          ),

          // Filtreler
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildFilterChip(
                  label: l10n.filterPlatform,
                  value: selectedPlatform.isEmpty ? l10n.allPlatforms : selectedPlatform,
                  onTap: () => _showPlatformFilter(),
                ),
                _buildFilterChip(
                  label: l10n.filterCategory,
                  value: selectedCategory.isEmpty ? l10n.allCategories : selectedCategory,
                  onTap: () => _showCategoryFilter(),
                ),
                _buildFilterChip(
                  label: l10n.filterTags,
                  value: selectedTags.isEmpty
                      ? l10n.filterTags
                      : '${selectedTags.length} ${l10n.tags}',
                  onTap: _selectTags,
                ),
                _buildFilterChip(
                  label: l10n.filterDateRange,
                  value: fromDate != null || toDate != null
                      ? '${fromDate != null ? _formatDate(fromDate!) : ''} - ${toDate != null ? _formatDate(toDate!) : ''}'
                      : l10n.filterDateRange,
                  onTap: () => _showDateRangeFilter(),
                ),
                _buildFilterChip(
                  label: l10n.sortBy,
                  value: _getSortLabel(),
                  onTap: () => _showSortOptions(),
                ),
              ],
            ),
          ),

          // Sonuç sayısı
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.filter_list, color: theme.colorScheme.onPrimaryContainer),
                SizedBox(width: 8),
                Text(
                  '${filteredVideos.length} ${l10n.videosFound(filteredVideos.length)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),

          // Sonuçlar
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredVideos.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: filteredVideos.length,
                        itemBuilder: (context, index) {
                          final video = filteredVideos[index];
                          return VideoCard(
                            video: video,
                            onDelete: () => _deleteVideo(video),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddVideoScreen(video: video),
                                ),
                              ).then((_) => _loadData());
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.outline),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _hasActiveFilters() {
    return _searchController.text.isNotEmpty ||
        selectedPlatform.isNotEmpty ||
        selectedCategory.isNotEmpty ||
        selectedTags.isNotEmpty ||
        fromDate != null ||
        toDate != null ||
        sortBy != 'newest';
  }

  String _getSortLabel() {
    final l10n = AppLocalizations.of(context)!;
    switch (sortBy) {
      case 'newest':
        return l10n.sortNewest;
      case 'oldest':
        return l10n.sortOldest;
      case 'title':
        return l10n.sortTitle;
      case 'platform':
        return l10n.sortPlatform;
      default:
        return l10n.sortNewest;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _showPlatformFilter() async {
    final l10n = AppLocalizations.of(context)!;
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.filterPlatform),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(l10n.allPlatforms),
                onTap: () => Navigator.of(context).pop(''),
              ),
              Divider(),
              ...platforms.map((platform) => ListTile(
                    title: Text(platform),
                    onTap: () => Navigator.of(context).pop(platform),
                  )),
            ],
          ),
        ),
      ),
    );

    if (selected != null) {
      setState(() {
        selectedPlatform = selected;
      });
      _applyFilters();
    }
  }

  Future<void> _showCategoryFilter() async {
    final l10n = AppLocalizations.of(context)!;
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.filterCategory),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(l10n.allCategories),
                onTap: () => Navigator.of(context).pop(''),
              ),
              Divider(),
              ...categories.map((category) => ListTile(
                    title: Text(category),
                    onTap: () => Navigator.of(context).pop(category),
                  )),
            ],
          ),
        ),
      ),
    );

    if (selected != null) {
      setState(() {
        selectedCategory = selected;
      });
      _applyFilters();
    }
  }

  Future<void> _showDateRangeFilter() async {
    final l10n = AppLocalizations.of(context)!;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.filterDateRange),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(l10n.fromDate),
              subtitle: Text(fromDate != null ? _formatDate(fromDate!) : l10n.fromDate),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                Navigator.of(context).pop();
                _selectDate(true);
              },
            ),
            ListTile(
              title: Text(l10n.toDate),
              subtitle: Text(toDate != null ? _formatDate(toDate!) : l10n.toDate),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                Navigator.of(context).pop();
                _selectDate(false);
              },
            ),
            if (fromDate != null || toDate != null)
              TextButton(
                onPressed: () {
                  setState(() {
                    fromDate = null;
                    toDate = null;
                  });
                  Navigator.of(context).pop();
                  _applyFilters();
                },
                child: Text(l10n.clearFilters),
              ),
          ],
        ),
        actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancel),
            ),
        ],
      ),
    );
  }

  Future<void> _showSortOptions() async {
    final l10n = AppLocalizations.of(context)!;
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.sortBy),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text(l10n.sortNewest),
              value: 'newest',
              groupValue: sortBy,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
            RadioListTile<String>(
              title: Text(l10n.sortOldest),
              value: 'oldest',
              groupValue: sortBy,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
            RadioListTile<String>(
              title: Text(l10n.sortTitle),
              value: 'title',
              groupValue: sortBy,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
            RadioListTile<String>(
              title: Text(l10n.sortPlatform),
              value: 'platform',
              groupValue: sortBy,
              onChanged: (value) => Navigator.of(context).pop(value),
            ),
          ],
        ),
      ),
    );

    if (selected != null) {
      setState(() {
        sortBy = selected;
      });
      _applyFilters();
    }
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 16),
            Text(
              l10n.noVideoFound,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              l10n.tryDifferentKeywords,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _clearFilters,
              child: Text(l10n.clearFilters),
            ),
          ],
        ),
      ),
    );
  }
}

