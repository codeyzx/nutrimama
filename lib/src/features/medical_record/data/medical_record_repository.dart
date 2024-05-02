import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/features/medical_record/domain/mother.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medical_record_repository.g.dart';

class MedicalRecordRepository {
  final userDb = FirebaseFirestore.instance.collection('user').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (User user, _) => user.toJson(),
      );

  Future<Result<List<Fetal>>> getFetal(User user) async {
    try {
      final resultFetals = await userDb
          .doc(user.id)
          .collection('fetal')
          .withConverter(
              fromFirestore: (snapshot, _) => Fetal.fromJson(snapshot.data()!),
              toFirestore: (Fetal fetal, _) => fetal.toJson())
          .get();
      final fetals = resultFetals.docs.map((e) => e.data()).toList();
      return Result.success(fetals);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addNewFetal(Fetal fetal, User user) async {
    try {
      final ref = userDb.doc(user.id).collection('fetal').doc();
      Fetal temp = fetal.copyWith(id: ref.id);
      String fetalId = 'fetal-${DateTime.now().millisecondsSinceEpoch}';
      temp = temp.copyWith(fetalId: fetalId);
      await userDb.doc(user.id).update({
        'fetalId': fetalId,
        'fetalDate': fetal.fetalDate.millisecondsSinceEpoch
      });
      await ref.set(temp.toJson());
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addFetal(Fetal fetal, User user) async {
    try {
      final ref = userDb.doc(user.id).collection('fetal').doc();
      Fetal temp = fetal.copyWith(id: ref.id);
      await ref.set(temp.toJson());
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> setBorn(String fetalId, String uid) async {
    try {
      final result = await userDb
          .doc(uid)
          .collection('fetal')
          .where('fetalId', isEqualTo: fetalId)
          .get();
      final docs = result.docs;
      final batch = userDb.doc(uid).collection('fetal').firestore.batch();
      for (final post in docs) {
        batch.update(post.reference, {'isBorn': true});
      }
      batch.commit();
      await userDb.doc(uid).update({'fetalId': '', 'fetalDate': null});
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<List<Mother>>> getMother(User user) async {
    try {
      final resultMother = await userDb
          .doc(user.id)
          .collection('mother')
          .withConverter(
              fromFirestore: (snapshot, _) => Mother.fromJson(snapshot.data()!),
              toFirestore: (Mother mother, _) => mother.toJson())
          .get();
      final mother = resultMother.docs.map((e) => e.data()).toList();
      return Result.success(mother);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addMother(Mother mother, User user) async {
    try {
      final ref = userDb.doc(user.id).collection('mother').doc();
      final temp = mother.copyWith(id: ref.id);
      await ref.set(temp.toJson());
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
MedicalRecordRepository medicalRecordRepository(
    MedicalRecordRepositoryRef ref) {
  return MedicalRecordRepository();
}
