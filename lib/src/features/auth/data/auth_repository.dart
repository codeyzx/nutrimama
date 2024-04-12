import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:nutrimama/src/features/auth/domain/request_login.dart';
import 'package:nutrimama/src/features/auth/domain/request_register.dart';
import 'package:nutrimama/src/features/auth/domain/request_user.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository(this._auth);
  final auth.FirebaseAuth _auth;

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

  Future<Result> login(RequestLogin requestLogin) async {
    try {
      final emailAddress = requestLogin.email;
      final password = requestLogin.password;
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      final user = credential.user;
      if (user == null) {
        return Result.failure(
            NetworkExceptions.getFirebaseException('User not found'),
            StackTrace.current);
      }

      return const Result.success(true);
    } catch (e, stackTrace) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), stackTrace);
    }
  }

  Future<Result> register(RequestRegister requestRegister) async {
    try {
      final emailAddress = requestRegister.email;
      final password = requestRegister.password;

      final credential = await _auth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);

      await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);

      final credUser = credential.user;
      Map<String, dynamic> user = {
        'id': credUser!.uid,
        'name': requestRegister.name,
        'email': requestRegister.email,
        'photoUrl': '',
        'fetalId': '',
        'isSuccessRegister': false,
        'fetalDate': null,
      };

      await FirebaseFirestore.instance
          .collection('user')
          .doc(credUser.uid)
          .set(user);

      return const Result.success(true);
    } catch (e, stackTrace) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), stackTrace);
    }
  }

  Future<Result> updateProfile(RequestUser user) async {
    try {
      await requestUserDb.doc(user.id).update(user.toJson());
      return const Result.success(true);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<Result> logout() async {
    try {
      await _auth.signOut();
      return const Result.success(true);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(auth.FirebaseAuth.instance);
}
