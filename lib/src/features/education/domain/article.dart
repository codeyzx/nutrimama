enum ArticleCategory {
  semua('Semua'),
  kehamilan('Kehamilan'),
  makananSehat('Makanan Sehat'),
  kesehatanMental('Kesehatan Mental'),
  gizi('Gizi'),
  keuangan('Keuangan'),
  imunisasi('Imunisasi'),
  gayaHidupSehat('Gaya Hidup Sehat'),
  pengelolaanStress('Pengelolaan Stress'),
  olahraga('Olahraga dan Kebugaran');

  final String value;
  const ArticleCategory(this.value);
}

class Article {
  final String id;
  final String title;
  final String description;
  final String content;
  final ArticleCategory category;
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
      category: ArticleCategory.values.firstWhere(
        (e) => e.value == json['category'],
        orElse: () => ArticleCategory.semua,
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
    ArticleCategory? category,
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
