import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:nutrimama/src/features/auth/domain/request_user.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common_repository.g.dart';

class CommonRepository {
  final userDb = FirebaseFirestore.instance.collection('user').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (User user, _) => user.toJson(),
      );

  final requestUserDb = FirebaseFirestore.instance
      .collection('user')
      .withConverter(
        fromFirestore: (snapshot, _) => RequestUser.fromJson(snapshot.data()!),
        toFirestore: (RequestUser user, _) => user.toJson(),
      );

  String? getUid() {
    return auth.FirebaseAuth.instance.currentUser?.uid;
  }

  Future<Result<User>> getProfile() async {
    String? uid = auth.FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return Result.failure(
        const NetworkExceptions.notFound('User not found'),
        StackTrace.current,
      );
    }
    try {
      final resultUser = await userDb.doc(uid).get();
      final user = resultUser.data()!;
      return Result.success(user);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  bool isLogin() {
    return auth.FirebaseAuth.instance.currentUser != null;
  }

  Future<Result<String>> updateProfile(RequestUser user) async {
    try {
      await requestUserDb.doc(user.id).update(user.toJson());
      return const Result.success('Success');
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }
}

@Riverpod(keepAlive: true)
CommonRepository commonRepository(CommonRepositoryRef ref) {
  return CommonRepository();
}
