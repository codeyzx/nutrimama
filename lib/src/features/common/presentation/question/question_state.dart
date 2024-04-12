import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';

class QuestionState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<User?> user;
  final AsyncValue<bool?> loadingValue;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController nameController;
  final TextEditingController ageController;
  final bool isLastPage;
  final List<Map<String, String>> ageList;
  final String age;

  QuestionState({
    this.user = const AsyncLoading(),
    this.loadingValue = const AsyncData(null),
    required this.nameController,
    required this.weightController,
    required this.heightController,
    required this.ageController,
    this.isLastPage = false,
    this.age = '10',
  }) : ageList = List.generate(91, (index) => index + 10)
            .map((e) => {'value': e.toString(), 'text': e.toString()})
            .toList();

  QuestionState copyWith({
    AsyncValue<User?>? user,
    AsyncValue<bool>? loadingValue,
    TextEditingController? nameController,
    TextEditingController? weightController,
    TextEditingController? heightController,
    TextEditingController? ageController,
    bool? isLastPage,
    String? age,
  }) {
    return QuestionState(
      user: user ?? this.user,
      loadingValue: loadingValue ?? this.loadingValue,
      nameController: nameController ?? this.nameController,
      weightController: weightController ?? this.weightController,
      heightController: heightController ?? this.heightController,
      ageController: ageController ?? this.ageController,
      isLastPage: isLastPage ?? this.isLastPage,
      age: age ?? this.age,
    );
  }
}
