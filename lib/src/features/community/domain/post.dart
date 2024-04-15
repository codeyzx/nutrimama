import 'package:nutrimama/src/features/community/domain/comment.dart';

class Post {
  final String id;
  final DateTime createdAt;
  final String userId;
  final String userName;
  final String userPhoto;
  final String imageUrl;
  final String title;
  final String description;
  final int likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userPhoto,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] ?? '',
      createdAt: json['createdAt'] == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      userPhoto: json['userPhoto'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      likes: json['likes'] ?? 0,
      comments: json['comments'] == null
          ? []
          : List<Comment>.from(
              json['comments'].map((comment) => Comment.fromJson(comment))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  Post copyWith({
    String? id,
    DateTime? createdAt,
    String? userId,
    String? userName,
    String? userPhoto,
    String? imageUrl,
    String? title,
    String? description,
    int? likes,
    List<Comment>? comments,
  }) {
    return Post(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userPhoto: userPhoto ?? this.userPhoto,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
