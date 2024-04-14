class Ingredients {
  final String name;
  final String total;

  Ingredients({
    required this.name,
    required this.total,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(
      name: json['name'] ?? '',
      total: json['total'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'total': total,
    };
  }

  Ingredients copyWith({
    String? name,
    String? total,
  }) {
    return Ingredients(
      name: name ?? this.name,
      total: total ?? this.total,
    );
  }
}
