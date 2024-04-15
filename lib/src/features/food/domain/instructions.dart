class Instructions {
  final String title;
  final String description;

  Instructions({
    required this.title,
    required this.description,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) {
    return Instructions(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  Instructions copyWith({
    String? title,
    String? description,
  }) {
    return Instructions(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
