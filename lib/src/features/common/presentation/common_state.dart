import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/common/presentation/home/home_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CommonState {
  final bool isHomeActive;
  final bool isCommunityActive;
  final bool isEduActive;
  final bool isProfileActive;
  final bool isLastPage;
  final int currentIndex;
  final Widget currentScreen;
  final String gender;
  final String age;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<bool?> isGetLoading;
  final bool isOverlayVisible;
  final AsyncValue<User> userValue;

  CommonState({
    this.isHomeActive = true,
    this.isCommunityActive = false,
    this.isEduActive = false,
    this.isProfileActive = false,
    this.isOverlayVisible = false,
    this.isLastPage = false,
    this.currentIndex = 0,
    this.currentScreen = const HomeScreen(),
    this.gender = "Male",
    this.age = "10",
    this.isGetLoading = const AsyncData(false),
    this.userValue = const AsyncLoading(),
  });

  CommonState copyWith({
    bool? isHomeActive,
    bool? isCommunityActive,
    bool? isEduActive,
    bool? isProfileActive,
    bool? isLastPage,
    int? currentIndex,
    Widget? currentScreen,
    String? gender,
    String? age,
    AsyncValue<bool?>? isGetLoading,
    bool? isOverlayVisible,
    AsyncValue<User>? userValue,
  }) {
    return CommonState(
      isHomeActive: isHomeActive ?? this.isHomeActive,
      isCommunityActive: isCommunityActive ?? this.isCommunityActive,
      isEduActive: isEduActive ?? this.isEduActive,
      isProfileActive: isProfileActive ?? this.isProfileActive,
      isLastPage: isLastPage ?? this.isLastPage,
      currentIndex: currentIndex ?? this.currentIndex,
      currentScreen: currentScreen ?? this.currentScreen,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      isGetLoading: isGetLoading ?? this.isGetLoading,
      isOverlayVisible: isOverlayVisible ?? this.isOverlayVisible,
      userValue: userValue ?? this.userValue,
    );
  }
}
