import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'food_repository.g.dart';

class FoodRepository {
  final foodDb = FirebaseFirestore.instance.collection('foods').withConverter(
        fromFirestore: (snapshot, _) => Food.fromJson(snapshot.data()!),
        toFirestore: (Food food, _) => food.toJson(),
      );

  Future<Result<List<Food>>> getFoods() async {
    try {
      final resultFoods = await foodDb.get();
      final foods = resultFoods.docs.map((e) => e.data()).toList();
      return Result.success(foods);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<Food>> getFood(String id) async {
    try {
      final resultFood = await foodDb.doc(id).get();
      final food = resultFood.data();
      return Result.success(food!);
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }

  Future<Result<String>> addFood() async {
    try {
      Food food =
          Food.fromJson({'name': 'Salad Buah', 'calories': 270, 'id': ''});
      final ref = foodDb.doc();
      food.copyWith(id: ref.id);
      await ref.set(food);
      return const Result.success('Success');
    } catch (e) {
      return Result.failure(
          NetworkExceptions.getFirebaseException(e), StackTrace.current);
    }
  }
}

@Riverpod(keepAlive: true)
FoodRepository foodRepository(FoodRepositoryRef ref) {
  return FoodRepository();
}
