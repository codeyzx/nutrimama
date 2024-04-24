import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_log.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consume_log_repository.g.dart';

class ConsumeLogRepository {
  final userDb = FirebaseFirestore.instance.collection('user').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (User user, _) => user.toJson(),
      );

  Future<Result<List<ConsumeFood>>> getTodayConsumeFood(
      String uid, String date) async {
    try {
      final result =
          await userDb.doc(uid).collection('consumeLog').doc(date).get();
      List<ConsumeFood> foods = [];
      if (result.exists) {
        foods = List<ConsumeFood>.from(
            result.data()!['foods'].map((x) => ConsumeFood.fromJson(x)));
      }
      return Result.success(foods);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<Result<ConsumeLog>> getTodayConsumeLog(String uid, String date) async {
    try {
      final result =
          await userDb.doc(uid).collection('consumeLog').doc(date).get();
      if (result.exists) {
        return Result.success(ConsumeLog.fromJson(result.data()!));
      } else {
        return Result.success(ConsumeLog(
          date: DateTime.now(),
          foods: [],
          totalCalories: 0,
          totalCarbs: 0,
          totalFat: 0,
          totalProtein: 0,
          totalIron: 0,
          totalCalcium: 0,
          totalSugars: 0,
          totalVitamin: 0,
          totalDrink: 0,
        ));
      }
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<Result<List<ConsumeLog>>> getConsumeLogs(String uid) async {
    try {
      final result = await userDb.doc(uid).collection('consumeLog').get();
      final logs = result.docs
          .map((e) => ConsumeLog.fromJson(e.data()))
          .toList()
          .reversed
          .toList();
      return Result.success(logs);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<Result<void>> addDrink(String uid, String docId) async {
    try {
      await userDb.doc(uid).collection('consumeLog').doc(docId).update({
        'totalDrink': FieldValue.increment(1),
      });
      return const Result.success(null);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<Result<void>> addVitamin(String uid, String docId) async {
    try {
      await userDb.doc(uid).collection('consumeLog').doc(docId).update({
        'totalVitamin': FieldValue.increment(1),
      });
      return const Result.success(null);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<Result<List<ConsumeFood>>> addConsumeFood(
      String uid, String date, ConsumeFood food) async {
    try {
      await userDb.doc(uid).collection('consumeLog').doc(date).set({
        'date': date,
        'foods': FieldValue.arrayUnion([food.toJson()]),
        'totalCalories': FieldValue.increment(food.calories),
        'totalCarbs': FieldValue.increment(food.carbs),
        'totalFat': FieldValue.increment(food.fat),
        'totalProtein': FieldValue.increment(food.protein),
        'totalIron': FieldValue.increment(food.iron),
        'totalCalcium': FieldValue.increment(food.calcium),
        'totalSugars': FieldValue.increment(food.sugars),
      }, SetOptions(merge: true));

      final result =
          await userDb.doc(uid).collection('consumeLog').doc(date).get();
      List<ConsumeFood> foods = [];
      if (result.exists) {
        foods = List<ConsumeFood>.from(
            result.data()!['foods'].map((x) => ConsumeFood.fromJson(x)));
      }

      return Result.success(foods);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }
}

@Riverpod(keepAlive: true)
ConsumeLogRepository consumeLogRepository(ConsumeLogRepositoryRef ref) {
  return ConsumeLogRepository();
}
