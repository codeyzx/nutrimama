import 'package:nutrimama/src/features/consume_log/data/consume_log_repository.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'consume_log_controller.g.dart';

@riverpod
class ConsumeLogController extends _$ConsumeLogController {
  @override
  ConsumeLogState build() {
    return ConsumeLogState();
  }

  Future<void> getConsumeLogs(String uid) async {
    final result =
        await ref.read(consumeLogRepositoryProvider).getConsumeLogs(uid);
    result.when(
      success: (foods) {
        state = state.copyWith(
          consumeLogs: AsyncData(foods),
        );
      },
      failure: (e, s) {
        state = state.copyWith(
          consumeLogs: AsyncError(e, s),
        );
      },
    );
  }

  Future<void> getTodayConsumeLog(String uid, String date) async {
    final result = await ref
        .read(consumeLogRepositoryProvider)
        .getTodayConsumeLog(uid, date);
    result.when(
      success: (log) {
        state = state.copyWith(
          todayConsumeLog: AsyncData(log),
        );
      },
      failure: (e, s) {
        state = state.copyWith(
          todayConsumeLog: AsyncError(e, s),
        );
      },
    );
  }

  Future<void> getTodayConsumeFood(String uid, String date) async {
    final result = await ref
        .read(consumeLogRepositoryProvider)
        .getTodayConsumeFood(uid, date);
    result.when(
      success: (foods) {
        state = state.copyWith(
          consumeFoods: AsyncData(foods),
        );
      },
      failure: (e, s) {
        state = state.copyWith(
          consumeFoods: AsyncError(e, s),
        );
      },
    );
  }

  Future<void> addConsumeFood(String uid, String date, ConsumeFood food) async {
    final result = await ref
        .read(consumeLogRepositoryProvider)
        .addConsumeFood(uid, date, food);
    result.when(
      success: (_) {
        getTodayConsumeLog(uid, date);
        getTodayConsumeFood(uid, date);
      },
      failure: (e, s) {
        state = state.copyWith(
          todayConsumeLog: AsyncError(e, s),
        );
      },
    );
  }

  Future<void> addDrink(String uid, String docId) async {
    final result =
        await ref.read(consumeLogRepositoryProvider).addDrink(uid, docId);
    result.when(
      success: (_) {
        getTodayConsumeLog(uid, docId);
      },
      failure: (e, s) {
        state = state.copyWith(
          todayConsumeLog: AsyncError(e, s),
        );
      },
    );
  }

  Future<void> addVitamin(String uid, String docId) async {
    final result =
        await ref.read(consumeLogRepositoryProvider).addVitamin(uid, docId);
    result.when(
      success: (_) {
        getTodayConsumeLog(uid, docId);
      },
      failure: (e, s) {
        state = state.copyWith(
          todayConsumeLog: AsyncError(e, s),
        );
      },
    );
  }
}
