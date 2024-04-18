enum ArticleCategory {
  kehamilan('kehamilan'),
  olahraga('olahraga'),
  makananSehat('Makanan Sehat'),
  kesehatanMental('Kesehatan Mental'),
  kesehatan('Kesehatan');

  final String value;
  const ArticleCategory(this.value);
}

class Article {
  final String id;
  final String title;
  final String description;
  final ArticleCategory category;
  final String imageUrl;

  const Article({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: ArticleCategory.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => ArticleCategory.kehamilan,
      ),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'category': category.value,
      'imageUrl': imageUrl,
    };
  }

  Article copyWith({
    String? id,
    String? title,
    String? description,
    ArticleCategory? category,
    String? imageUrl,
  }) {
    return Article(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
