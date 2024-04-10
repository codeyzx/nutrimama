import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/data/auth_repository.dart';
import 'package:nutrimama/src/features/auth/domain/request_user.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/common/data/common_repository.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  UserState build() {
    getProfile();
    return UserState(
      nameController: TextEditingController(),
    );
  }

  void setData(User user) {
    state.nameController.text = user.name;

    state = state.copyWith(
      user: AsyncData(user),
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

    final user = RequestUser(
      name: state.nameController.text,
      id: state.user.asData?.value?.id,
    );

    final result = await ref.read(authRepositoryProvider).updateProfile(user);

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

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
  }
}
