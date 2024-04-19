import 'category.dart';

class Video {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final EducationCategory category;

  const Video({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.category,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      category: EducationCategory.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => EducationCategory.kehamilan,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'category': category.value,
    };
  }

  Video copyWith({
    String? id,
    String? title,
    String? description,
    String? videoUrl,
    EducationCategory? category,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      videoUrl: videoUrl ?? this.videoUrl,
      category: category ?? this.category,
    );
  }
}
