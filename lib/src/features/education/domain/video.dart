enum VideoCategory {
  kehamilan('kehamilan'),
  olahraga('olahraga'),
  makananSehat('Makanan Sehat'),
  kesehatanMental('Kesehatan Mental'),
  kesehatan('Kesehatan');

  final String value;
  const VideoCategory(this.value);
}

class Video {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String imageUrl;
  final VideoCategory category;

  const Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.imageUrl,
    required this.category,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      category: VideoCategory.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => VideoCategory.kehamilan,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'imageUrl': imageUrl,
      'category': category.value,
    };
  }

  Video copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    String? imageUrl,
    VideoCategory? category,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }
}
