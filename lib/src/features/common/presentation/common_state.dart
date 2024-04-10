import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/home/presentation/home_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CommonState {
  final bool isHomeActive;
  final bool isAnalyzeActive;
  final bool isRecycleActive;
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
    this.isAnalyzeActive = false,
    this.isRecycleActive = false,
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
    bool? isAnalyzeActive,
    bool? isRecycleActive,
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
      isAnalyzeActive: isAnalyzeActive ?? this.isAnalyzeActive,
      isRecycleActive: isRecycleActive ?? this.isRecycleActive,
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
