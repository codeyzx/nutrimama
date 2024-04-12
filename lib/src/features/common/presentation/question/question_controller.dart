import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/common/presentation/question/question_state.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_controller.g.dart';

@riverpod
class QuestionController extends _$QuestionController {
  @override
  QuestionState build() {
    return QuestionState(
      nameController: TextEditingController(),
      weightController: TextEditingController(),
      heightController: TextEditingController(),
      ageController: TextEditingController(),
    );
  }

  void setLastPage(bool value) {
    state = state.copyWith(
      isLastPage: value,
    );
  }

  void setAge(String? age) {
    state = state.copyWith(
      age: age,
    );
  }

  String? validateWeight(String? value) {
    if (value.isNullOrEmpty()) {
      return "Cannot be empty";
    }
    return null;
  }

  String? validateHeight(String? value) {
    if (value.isNullOrEmpty()) {
      return "Cannot be empty";
    }
    return null;
  }
}
