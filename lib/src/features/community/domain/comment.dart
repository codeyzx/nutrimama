class Comment {
  final String id;
  final DateTime createdAt;
  final String postId;
  final String text;
  final String userId;
  final String userName;
  final String userPhoto;

  Comment({
    required this.id,
    required this.createdAt,
    required this.postId,
    required this.text,
    required this.userId,
    required this.userName,
    required this.userPhoto,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? '',
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      postId: json['postId'] ?? '',
      text: json['text'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userPhoto: json['userPhoto'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'postId': postId,
      'text': text,
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
    };
  }

  Comment copyWith({
    String? id,
    DateTime? createdAt,
    String? postId,
    String? text,
    String? userId,
    String? userName,
    String? userPhoto,
  }) {
    return Comment(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      postId: postId ?? this.postId,
      text: text ?? this.text,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhoto: userPhoto ?? this.userPhoto,
    );
  }
}
