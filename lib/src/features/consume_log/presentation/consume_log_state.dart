import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ConsumeLogState {
  final AsyncValue<List<ConsumeLog>?> consumeLogs;
  final AsyncValue<List<ConsumeFood>?> consumeFoods;
  final AsyncValue<ConsumeLog?> todayConsumeLog;

  ConsumeLogState({
    this.consumeLogs = const AsyncLoading(),
    this.consumeFoods = const AsyncLoading(),
    this.todayConsumeLog = const AsyncLoading(),
  });

  ConsumeLogState copyWith({
    AsyncValue<List<ConsumeLog>?>? consumeLogs,
    AsyncValue<List<ConsumeFood>?>? consumeFoods,
    AsyncValue<ConsumeLog?>? todayConsumeLog,
  }) {
    return ConsumeLogState(
      consumeLogs: consumeLogs ?? this.consumeLogs,
      consumeFoods: consumeFoods ?? this.consumeFoods,
      todayConsumeLog: todayConsumeLog ?? this.todayConsumeLog,
    );
  }
}
