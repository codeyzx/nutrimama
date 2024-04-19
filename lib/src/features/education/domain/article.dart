import 'category.dart';

class Article {
  final String id;
  final String title;
  final String description;
  final String content;
  final EducationCategory category;
  final String imageUrl;

  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      category: EducationCategory.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => EducationCategory.semua,
      ),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'category': category.value,
      'imageUrl': imageUrl,
    };
  }

  Article copyWith({
    String? id,
    String? title,
    String? description,
    String? content,
    EducationCategory? category,
    String? imageUrl,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
