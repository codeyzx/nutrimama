class Comment {
  final DateTime createdAt;
  final String postId;
  final String text;
  final String userId;
  final String userName;
  final String userPhoto;

  Comment({
    required this.createdAt,
    required this.postId,
    required this.text,
    required this.userId,
    required this.userName,
    required this.userPhoto,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
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
      'createdAt': createdAt.millisecondsSinceEpoch,
      'postId': postId,
      'text': text,
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
    };
  }

  Comment copyWith({
    DateTime? createdAt,
    String? postId,
    String? text,
    String? userId,
    String? userName,
    String? userPhoto,
  }) {
    return Comment(
      createdAt: createdAt ?? this.createdAt,
      postId: postId ?? this.postId,
      text: text ?? this.text,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhoto: userPhoto ?? this.userPhoto,
    );
  }
}
