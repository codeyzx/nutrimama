class Instructions {
  final String tile;
  final String description;

  Instructions({
    required this.tile,
    required this.description,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) {
    return Instructions(
      tile: json['tile'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tile': tile,
      'description': description,
    };
  }

  Instructions copyWith({
    String? tile,
    String? description,
  }) {
    return Instructions(
      tile: tile ?? this.tile,
      description: description ?? this.description,
    );
  }
}
