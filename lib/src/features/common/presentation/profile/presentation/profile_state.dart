import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';

class ProfileState {
  final AsyncValue<User?> user;
  final AsyncValue<bool?> loadingValue;
  final TextEditingController nameController;

  ProfileState({
    this.user = const AsyncLoading(),
    this.loadingValue = const AsyncData(null),
    required this.nameController,
  });

  ProfileState copyWith({
    AsyncValue<User?>? user,
    AsyncValue<bool>? loadingValue,
    TextEditingController? nameController,
  }) {
    return ProfileState(
      user: user ?? this.user,
      loadingValue: loadingValue ?? this.loadingValue,
      nameController: nameController ?? this.nameController,
    );
  }
}
