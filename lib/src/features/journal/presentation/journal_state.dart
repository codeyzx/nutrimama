import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/journal/domain/journal.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class JournalState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<List<Journal>?> journals;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  JournalState({
    this.journals = const AsyncLoading(),
    required this.titleController,
    required this.descriptionController,
  });

  JournalState copyWith({
    AsyncValue<List<Journal>?>? journals,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
  }) {
    return JournalState(
      journals: journals ?? this.journals,
      titleController: titleController ?? this.titleController,
      descriptionController:
          descriptionController ?? this.descriptionController,
    );
  }
}
