import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/features/community/domain/post.dart';

class CommunityState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<List<Post>?> posts;
  final AsyncValue<Post?> post;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String? imageUrl;

  CommunityState({
    this.posts = const AsyncLoading(),
    this.post = const AsyncLoading(),
    required this.titleController,
    required this.descriptionController,
    this.imageUrl,
  });

  CommunityState copyWith({
    AsyncValue<List<Post>?>? posts,
    AsyncValue<Post?>? post,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
    String? imageUrl,
  }) {
    return CommunityState(
      posts: posts ?? this.posts,
      post: post ?? this.post,
      titleController: titleController ?? this.titleController,
      descriptionController:
          descriptionController ?? this.descriptionController,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
