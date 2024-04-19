import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/journal/domain/journal.dart';
import 'package:nutrimama/src/services/remote/remote.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_repository.g.dart';

class JournalRepository {
  final userDb = FirebaseFirestore.instance.collection('user').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (User user, _) => user.toJson(),
      );

  Future<Result<List<Journal>>> getJournals(String uid) async {
    try {
      final resultJournals = await userDb.doc(uid).collection('journal').get();
      List<Journal> journals = resultJournals.docs
          .map((e) => Journal.fromJson(e.data()))
          .toList()
          .cast<Journal>();
      journals.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Result.success(journals);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addJournal(Journal journal, String uid) async {
    try {
      final ref = userDb.doc(uid).collection('journal').doc();
      await ref.set(journal.copyWith(id: ref.id).toJson());
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
