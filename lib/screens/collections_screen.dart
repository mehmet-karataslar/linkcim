// Dosya Konumu: lib/screens/collections_screen.dart

import 'package:flutter/material.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:linkcim/models/video_collection.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/services/database_service.dart';
import 'package:linkcim/services/analytics_service.dart';
import 'package:linkcim/widgets/video_card.dart';
import 'package:uuid/uuid.dart';

class CollectionsScreen extends StatefulWidget {
  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<VideoCollection> collections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCollections();
    
    // Analytics: Koleksiyonlar sayfası görüntüleme
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AnalyticsService().logScreenView(screenName: 'collections_screen');
    });
  }

  Future<void> _loadCollections() async {
    setState(() => isLoading = true);
    try {
      final allCollections = await _dbService.getAllCollections();
      setState(() {
        collections = allCollections;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showError('Error loading collections: $e');
    }
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

  Future<void> _createCollection() async {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.newCollection),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.collectionName,
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.collectionDescription,
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                Navigator.of(context).pop({
                  'name': nameController.text.trim(),
                  'description': descriptionController.text.trim(),
                });
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );

    if (result != null) {
      try {
        final collection = VideoCollection.create(
          id: Uuid().v4(),
          name: result['name']!,
          description: result['description'] ?? '',
        );
        await _dbService.addCollection(collection);
        // Analytics: Koleksiyon oluşturuldu
        AnalyticsService().logCollectionCreated(
          collectionName: result['name']!,
          videoCount: 0,
        );
        _showSuccess(l10n.collectionCreated);
        _loadCollections();
      } catch (e) {
        _showError('Error creating collection: $e');
      }
    }
  }

  Future<void> _deleteCollection(VideoCollection collection) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.delete),
        content: Text('${l10n.confirmDelete}\n\n${collection.name}'),
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
        await _dbService.deleteCollection(collection);
        _showSuccess(l10n.collectionDeleted);
        _loadCollections();
      } catch (e) {
        _showError('Error deleting collection: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.collections),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _createCollection,
            tooltip: l10n.newCollection,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : collections.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: collections.length,
                  itemBuilder: (context, index) {
                    final collection = collections[index];
                    return _buildCollectionCard(collection);
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createCollection,
        icon: Icon(Icons.add),
        label: Text(l10n.newCollection),
      ),
    );
  }

  Widget _buildCollectionCard(VideoCollection collection) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _openCollection(collection),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // Koleksiyon ikonu
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Color(int.parse(collection.color.replaceFirst('#', '0xFF'))),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    collection.icon,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Koleksiyon bilgileri
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            collection.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (collection.isFavorite)
                          Icon(Icons.star, color: Colors.amber, size: 20),
                      ],
                    ),
                    SizedBox(height: 4),
                    if (collection.description.isNotEmpty)
                      Text(
                        collection.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    SizedBox(height: 4),
                    Text(
                      l10n.videosInCollection(collection.videoCount),
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              // Menü
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      _editCollection(collection);
                      break;
                    case 'delete':
                      _deleteCollection(collection);
                      break;
                  }
                },
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
        ),
      ),
    );
  }

  Future<void> _editCollection(VideoCollection collection) async {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController(text: collection.name);
    final descriptionController = TextEditingController(text: collection.description);

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.edit),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.collectionName,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.collectionDescription,
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                Navigator.of(context).pop({
                  'name': nameController.text.trim(),
                  'description': descriptionController.text.trim(),
                });
              }
            },
            child: Text(l10n.update),
          ),
        ],
      ),
    );

    if (result != null) {
      try {
        collection.name = result['name']!;
        collection.description = result['description'] ?? '';
        await _dbService.updateCollection(collection);
        _showSuccess(l10n.collectionUpdated);
        _loadCollections();
      } catch (e) {
        _showError('Error updating collection: $e');
      }
    }
  }

  void _openCollection(VideoCollection collection) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollectionDetailScreen(collection: collection),
      ),
    ).then((_) => _loadCollections());
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
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.folder_outlined,
                size: 48,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 20),
            Text(
              l10n.noCollections,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              l10n.createFirstCollection,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _createCollection,
              icon: Icon(Icons.add),
              label: Text(l10n.newCollection),
            ),
          ],
        ),
      ),
    );
  }
}

// Koleksiyon detay ekranı
class CollectionDetailScreen extends StatefulWidget {
  final VideoCollection collection;

  const CollectionDetailScreen({Key? key, required this.collection}) : super(key: key);

  @override
  _CollectionDetailScreenState createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<SavedVideo> videos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    setState(() => isLoading = true);
    try {
      final collectionVideos = await _dbService.getVideosInCollection(widget.collection.id);
      setState(() {
        videos = collectionVideos;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.collection.name),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : videos.isEmpty
              ? Center(
                  child: Text(
                    l10n.noVideos,
                    style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return VideoCard(
                      video: video,
                      onDelete: () async {
                        await _dbService.removeVideoFromCollection(
                          widget.collection.id,
                          video.key.toString(),
                        );
                        _loadVideos();
                      },
                    );
                  },
                ),
    );
  }
}

