import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/data/auth_repository.dart';
import 'package:nutrimama/src/features/auth/domain/request_user.dart';
import 'package:nutrimama/src/features/common/data/common_repository.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_state.dart';
import 'package:nutrimama/src/features/community/data/community_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  ProfileState build() {
    getProfile();
    return ProfileState(
      nameController: TextEditingController(),
    );
  }

  Future<void> getProfile() async {
    final result = await ref.read(commonRepositoryProvider).getProfile();
    result.when(
      success: (data) {
        state = state.copyWith(
          user: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          user: AsyncError(error, stackTrace),
        );
      },
    );
  }

  FutureOr<void> updateProfile() async {
    state = state.copyWith(
      loadingValue: const AsyncLoading(),
    );

    final imageUrl = state.imageUrl != null
        ? state.imageUrl!.contains('https')
            ? state.imageUrl!
            : await uploadImages(state.imageUrl!)
        : '';

    final user = RequestUser(
      name: state.nameController.text,
      id: state.user.asData?.value?.id,
      photoUrl: imageUrl,
    );

    Map<String, String> userPost = {
      'userId': state.user.asData?.value?.id ?? '',
      'userName': state.nameController.text,
      'userPhoto': imageUrl,
    };

    final result = await ref.read(authRepositoryProvider).updateProfile(user);
    await ref.read(communityRepositoryProvider).updateUserPost(userPost);

    result.when(
      success: (data) {
        state = state.copyWith(
          loadingValue: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          loadingValue: AsyncError(error, stackTrace),
        );
      },
    );
  }

  void setTextField() {
    state = state.copyWith(
      nameController: state.nameController
        ..text = state.user.asData?.value?.name ?? '',
      imageUrl: state.user.asData?.value?.photoUrl ?? '',
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
  }

  void setImageUrl(String imageUrl) {
    state = state.copyWith(
      imageUrl: imageUrl,
    );
  }

  Future<String> uploadImages(String imagesPath) async {
    final value = await FirebaseStorage.instance
        .ref()
        .child(
            'users/images/${DateTime.now().millisecondsSinceEpoch}.${imagesPath.split('.').last}')
        .putFile(File(imagesPath));
    return value.ref.getDownloadURL();
  }
}
