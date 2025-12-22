// Dosya Konumu: lib/services/database_service.dart

import 'package:hive_flutter/hive_flutter.dart';
import 'package:linkcim/models/saved_video.dart';
import 'package:linkcim/models/video_collection.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Box<SavedVideo>? _videoBox;
  Box<VideoCollection>? _collectionBox;
  final _uuid = Uuid();

  Future<void> initDB() async {
    // Hive'ı başlat
    await Hive.initFlutter();

    // Type adapter'ları kaydet
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SavedVideoAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(VideoCollectionAdapter());
    }

    // Box'ları aç
    _videoBox = await Hive.openBox<SavedVideo>('videos');
    _collectionBox = await Hive.openBox<VideoCollection>('collections');

    print('✅ Hive veritabanı başarıyla başlatıldı');
  }

  Box<SavedVideo> get videoBox {
    if (_videoBox == null) {
      throw Exception('Veritabani baslatilmadi! initDB() metodunu cagirin.');
    }
    return _videoBox!;
  }

  Box<VideoCollection> get collectionBox {
    if (_collectionBox == null) {
      throw Exception('Veritabani baslatilmadi! initDB() metodunu cagirin.');
    }
    return _collectionBox!;
  }

  // Video ekleme
  Future<void> addVideo(SavedVideo video) async {
    await videoBox.add(video);
  }

  // Tum videolari getirme (tarihine gore sirali)
  Future<List<SavedVideo>> getAllVideos() async {
    final videos = videoBox.values.toList();
    videos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return videos;
  }

  // Video silme - Hive için video objesini doğrudan sil
  Future<void> deleteVideo(SavedVideo video) async {
    await video.delete();
  }

  // Video guncelleme
  Future<void> updateVideo(SavedVideo video) async {
    await video.save();
  }

  // Arama yapma
  Future<List<SavedVideo>> searchVideos(String query) async {
    if (query.isEmpty) return await getAllVideos();

    final allVideos = await getAllVideos();
    return allVideos.where((video) => video.matchesSearch(query)).toList();
  }

  // Kategoriye gore filtreleme
  Future<List<SavedVideo>> getVideosByCategory(String category) async {
    final allVideos = await getAllVideos();
    return allVideos.where((video) => video.category == category).toList();
  }

  // Etikete gore filtreleme
  Future<List<SavedVideo>> getVideosByTag(String tag) async {
    final allVideos = await getAllVideos();
    return allVideos.where((video) => video.tags.contains(tag)).toList();
  }

  // Benzersiz kategorileri getirme
  Future<List<String>> getAllCategories() async {
    final videos = await getAllVideos();
    final categories = videos.map((v) => v.category).toSet().toList();
    categories.sort();
    return categories;
  }

  // Benzersiz etiketleri getirme
  Future<List<String>> getAllTags() async {
    final videos = await getAllVideos();
    final allTags = <String>{};
    for (final video in videos) {
      allTags.addAll(video.tags);
    }
    final tagList = allTags.toList();
    tagList.sort();
    return tagList;
  }

  // Benzersiz platformları getirme
  Future<List<String>> getAllPlatforms() async {
    final videos = await getAllVideos();
    final platforms = videos
        .map((v) => v.platform)
        .where((p) => p.isNotEmpty)
        .toSet()
        .toList();
    platforms.sort();
    return platforms;
  }

  // Benzersiz yazarları getirme
  Future<List<String>> getAllAuthors() async {
    final videos = await getAllVideos();
    final authors = <String>{};
    for (final video in videos) {
      if (video.authorName.isNotEmpty) {
        authors.add(video.authorName);
      }
      if (video.authorUsername.isNotEmpty &&
          video.authorUsername != video.authorName) {
        authors.add('@${video.authorUsername}');
      }
    }
    final authorList = authors.toList();
    authorList.sort();
    return authorList;
  }

  // Platforma göre filtreleme
  Future<List<SavedVideo>> getVideosByPlatform(String platform) async {
    final allVideos = await getAllVideos();
    return allVideos
        .where(
            (video) => video.platform.toLowerCase() == platform.toLowerCase())
        .toList();
  }

  // Yazara göre filtreleme
  Future<List<SavedVideo>> getVideosByAuthor(String author) async {
    final allVideos = await getAllVideos();
    final cleanAuthor = author.replaceAll('@', '');
    return allVideos
        .where((video) =>
            video.authorName
                .toLowerCase()
                .contains(cleanAuthor.toLowerCase()) ||
            video.authorUsername
                .toLowerCase()
                .contains(cleanAuthor.toLowerCase()))
        .toList();
  }

  // Video sayisini getirme
  Future<int> getVideoCount() async {
    return videoBox.length;
  }

  // ==================== KOLEKSİYON METODLARI ====================

  // Koleksiyon ekleme
  Future<VideoCollection> addCollection(VideoCollection collection) async {
    if (collection.id.isEmpty) {
      collection.id = _uuid.v4();
    }
    await collectionBox.add(collection);
    return collection;
  }

  // Tüm koleksiyonları getirme
  Future<List<VideoCollection>> getAllCollections() async {
    final collections = collectionBox.values.toList();
    // Favoriler önce, sonra güncelleme tarihine göre
    collections.sort((a, b) {
      if (a.isFavorite != b.isFavorite) {
        return b.isFavorite ? 1 : -1;
      }
      return b.updatedAt.compareTo(a.updatedAt);
    });
    return collections;
  }

  // Koleksiyon silme
  Future<void> deleteCollection(VideoCollection collection) async {
    await collection.delete();
  }

  // Koleksiyon güncelleme
  Future<void> updateCollection(VideoCollection collection) async {
    collection.updatedAt = DateTime.now();
    await collection.save();
  }

  // ID'ye göre koleksiyon getirme
  Future<VideoCollection?> getCollectionById(String id) async {
    try {
      return collectionBox.values.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  // Koleksiyona video ekleme
  Future<void> addVideoToCollection(String collectionId, String videoKey) async {
    final collection = await getCollectionById(collectionId);
    if (collection != null) {
      collection.addVideo(videoKey);
      await updateCollection(collection);
    }
  }

  // Koleksiyondan video çıkarma
  Future<void> removeVideoFromCollection(
      String collectionId, String videoKey) async {
    final collection = await getCollectionById(collectionId);
    if (collection != null) {
      collection.removeVideo(videoKey);
      await updateCollection(collection);
    }
  }

  // Video'nun hangi koleksiyonlarda olduğunu bulma
  Future<List<VideoCollection>> getCollectionsForVideo(
      String videoKey) async {
    final allCollections = await getAllCollections();
    return allCollections
        .where((collection) => collection.videoIds.contains(videoKey))
        .toList();
  }

  // Koleksiyondaki videoları getirme
  Future<List<SavedVideo>> getVideosInCollection(
      String collectionId) async {
    final collection = await getCollectionById(collectionId);
    if (collection == null) return [];

    final allVideos = await getAllVideos();
    final videoMap = <String, SavedVideo>{};
    for (final video in allVideos) {
      videoMap[video.key.toString()] = video;
    }

    return collection.videoIds
        .map((key) => videoMap[key])
        .where((video) => video != null)
        .cast<SavedVideo>()
        .toList();
  }

  // Veritabanını kapat
  Future<void> close() async {
    await _videoBox?.close();
    await _collectionBox?.close();
  }
}
