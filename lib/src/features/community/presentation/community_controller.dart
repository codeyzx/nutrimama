import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/community/data/community_repository.dart';
import 'package:nutrimama/src/features/community/domain/post.dart';
import 'package:nutrimama/src/features/community/presentation/community_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_controller.g.dart';

@Riverpod(keepAlive: true)
class CommunityController extends _$CommunityController {
  @override
  CommunityState build() {
    getPosts();
    return CommunityState(
      titleController: TextEditingController(),
      descriptionController: TextEditingController(),
    );
  }

  Future<void> getPosts() async {
    final result = await ref.read(communityRepositoryProvider).getPosts();
    result.when(
      success: (data) {
        state = state.copyWith(
          posts: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          posts: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> addPost(User user) async {
    state = state.copyWith(
      posts: const AsyncLoading(),
    );

    Post post = Post(
      id: '',
      comments: [],
      createdAt: DateTime.now(),
      imageUrl: state.imageUrl ?? '',
      likes: 0,
      userId: user.id,
      userName: user.name,
      userPhoto: user.photoUrl,
      title: state.titleController.text,
      description: state.descriptionController.text,
    );

    final result = await ref.read(communityRepositoryProvider).addPost(post);
    result.when(
      success: (data) {
        state = state.copyWith(
          posts: const AsyncLoading(),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          posts: AsyncError(error, stackTrace),
        );
      },
    );
  }
}
