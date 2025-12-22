// Dosya Konumu: lib/models/video_collection.dart

import 'package:hive/hive.dart';

part 'video_collection.g.dart';

@HiveType(typeId: 1)
class VideoCollection extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late List<String> videoIds; // SavedVideo'ların key'leri

  @HiveField(4)
  late DateTime createdAt;

  @HiveField(5)
  late DateTime updatedAt;

  @HiveField(6)
  String color = '#2196F3'; // Koleksiyon rengi (hex)

  @HiveField(7)
  String icon = '📁'; // Koleksiyon ikonu

  @HiveField(8)
  bool isFavorite = false; // Favori koleksiyon mu?

  VideoCollection();

  VideoCollection.create({
    required this.id,
    required this.name,
    this.description = '',
    List<String>? videoIds,
    this.color = '#2196F3',
    this.icon = '📁',
    this.isFavorite = false,
  })  : videoIds = videoIds ?? [],
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'videoIds': videoIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'color': color,
      'icon': icon,
      'isFavorite': isFavorite,
    };
  }

  factory VideoCollection.fromJson(Map<String, dynamic> json) {
    final collection = VideoCollection();
    collection.id = json['id'] ?? '';
    collection.name = json['name'] ?? '';
    collection.description = json['description'] ?? '';
    collection.videoIds = List<String>.from(json['videoIds'] ?? []);
    collection.createdAt = DateTime.parse(
      json['createdAt'] ?? DateTime.now().toIso8601String(),
    );
    collection.updatedAt = DateTime.parse(
      json['updatedAt'] ?? DateTime.now().toIso8601String(),
    );
    collection.color = json['color'] ?? '#2196F3';
    collection.icon = json['icon'] ?? '📁';
    collection.isFavorite = json['isFavorite'] ?? false;
    return collection;
  }

  // Video ekleme
  void addVideo(String videoId) {
    if (!videoIds.contains(videoId)) {
      videoIds.add(videoId);
      updatedAt = DateTime.now();
    }
  }

  // Video çıkarma
  void removeVideo(String videoId) {
    videoIds.remove(videoId);
    updatedAt = DateTime.now();
  }

  // Video sayısı
  int get videoCount => videoIds.length;

  // Güncellenme zamanı formatı
  String get formattedUpdatedDate {
    return '${updatedAt.day}/${updatedAt.month}/${updatedAt.year}';
  }

  @override
  String toString() {
    return 'VideoCollection(name: $name, videoCount: $videoCount, isFavorite: $isFavorite)';
  }
}

