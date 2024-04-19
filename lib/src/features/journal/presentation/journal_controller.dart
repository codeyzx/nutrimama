import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/journal/data/journal_repository.dart';
import 'package:nutrimama/src/features/journal/domain/journal.dart';
import 'package:nutrimama/src/features/journal/presentation/journal_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_controller.g.dart';

@Riverpod(keepAlive: true)
class JournalController extends _$JournalController {
  @override
  JournalState build() {
    return JournalState(
      descriptionController: TextEditingController(),
      titleController: TextEditingController(),
    );
  }

  Future<void> getJournals(String uid) async {
    final result = await ref.read(journalRepositoryProvider).getJournals(uid);
    result.when(
      success: (data) {
        state = state.copyWith(
          journals: AsyncData(data),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          journals: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> addJournal(String uid) async {
    state = state.copyWith(
      journals: const AsyncLoading(),
    );
    final journal = Journal(
      id: '',
      title: state.titleController.text,
      description: state.descriptionController.text,
      createdAt: DateTime.now(),
    );
    final result =
        await ref.read(journalRepositoryProvider).addJournal(journal, uid);
    result.when(
      success: (data) {
        getJournals(uid);
        state = state.copyWith(
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          journals: AsyncError(error, stackTrace),
        );
      },
    );
  }
}
