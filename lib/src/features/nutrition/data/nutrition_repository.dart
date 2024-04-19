import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/nutrition/domain/nutrition.dart';
import 'package:nutrimama/src/services/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nutrition_repository.g.dart';

class NutritionRepository {
  final userDb = FirebaseFirestore.instance.collection('user').withConverter(
        fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
        toFirestore: (User user, _) => user.toJson(),
      );

  Future<Result<Nutrition>> getNutrition(String uid) async {
    try {
      final resultNutrition =
          await userDb.doc(uid).collection('nutrition').get();
      final nutrition = Nutrition.fromJson(resultNutrition.docs.first.data());
      return Result.success(nutrition);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }

  Future<Result<Nutrition>> setNutrition(
      Map<String, dynamic> nutrition, String uid,
      {bool? isUpdate}) async {
    try {
      final ref = userDb.doc(uid).collection('nutrition').doc();
      Nutrition temp = Nutrition.fromJson(nutrition);
      temp = temp.copyWith(id: ref.id);
      if (isUpdate == null) {
        await userDb.doc(uid).update({
          'isSuccessRegister': true,
        });
      }
      await ref.set(temp.toJson());
      return Result.success(temp);
    } catch (e, st) {
      return Result.failure(NetworkExceptions.getFirebaseException(e), st);
    }
  }
}

@Riverpod(keepAlive: true)
NutritionRepository nutritionRepository(NutritionRepositoryRef ref) {
  return NutritionRepository();
}
