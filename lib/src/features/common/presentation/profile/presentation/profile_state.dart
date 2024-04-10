import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';

class UserState {
  final AsyncValue<User?> user;
  final AsyncValue<bool?> loadingValue;
  final TextEditingController nameController;

  UserState({
    this.user = const AsyncLoading(),
    this.loadingValue = const AsyncData(null),
    required this.nameController,
  });

  UserState copyWith({
    AsyncValue<User?>? user,
    AsyncValue<bool>? loadingValue,
    TextEditingController? nameController,
  }) {
    return UserState(
      user: user ?? this.user,
      loadingValue: loadingValue ?? this.loadingValue,
      nameController: nameController ?? this.nameController,
    );
  }
}
