import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/nutrition/domain/nutrition.dart';

class ProfileState {
  final AsyncValue<User?> user;
  final AsyncValue<Nutrition?> nutrition;
  final AsyncValue<bool?> loadingValue;
  final TextEditingController nameController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final String? age;
  final List<Map<String, String>> ageList;

  ProfileState({
    this.user = const AsyncLoading(),
    this.nutrition = const AsyncLoading(),
    this.loadingValue = const AsyncData(null),
    required this.nameController,
    required this.weightController,
    required this.heightController,
    this.age,
  }) : ageList = List.generate(91, (index) => index + 20)
            .map((e) => {'value': e.toString(), 'text': e.toString()})
            .toList();

  ProfileState copyWith({
    AsyncValue<User?>? user,
    AsyncValue<Nutrition?>? nutrition,
    AsyncValue<bool>? loadingValue,
    TextEditingController? nameController,
    TextEditingController? weightController,
    TextEditingController? heightController,
    String? age,
  }) {
    return ProfileState(
      user: user ?? this.user,
      nutrition: nutrition ?? this.nutrition,
      loadingValue: loadingValue ?? this.loadingValue,
      nameController: nameController ?? this.nameController,
      weightController: weightController ?? this.weightController,
      heightController: heightController ?? this.heightController,
      age: age ?? this.age,
    );
  }
}
