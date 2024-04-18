import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/journal/domain/journal.dart';
import 'package:nutrimama/src/services/remote/remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_repository.g.dart';

class JournalRepository {
  final journalDb =
      FirebaseFirestore.instance.collection('journals').withConverter(
            fromFirestore: (snapshot, _) => Journal.fromJson(snapshot.data()!),
            toFirestore: (Journal journal, _) => journal.toJson(),
          );

  Future<Result<List<Journal>>> getJournals() async {
    try {
      final resultJournals = await journalDb.get();
      final journals = resultJournals.docs.map((e) => e.data()).toList();
      return Result.success(journals);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addJournal(Journal journal) async {
    try {
      final ref = journalDb.doc();
      journal = journal.copyWith(id: ref.id);
      await ref.set(journal);
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
JournalRepository journalRepository(JournalRepositoryRef ref) {
  return JournalRepository();
}
