import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_log.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ConsumeLogState {
  final AsyncValue<List<ConsumeLog>?> consumeLogs;
  final AsyncValue<List<ConsumeFood>?> consumeFoods;
  final AsyncValue<ConsumeLog?> todayConsumeLog;
  final DateTime? selectedDate;
  final AsyncValue<List<DateTime>> date;

  ConsumeLogState({
    this.consumeLogs = const AsyncLoading(),
    this.consumeFoods = const AsyncLoading(),
    this.todayConsumeLog = const AsyncLoading(),
    this.selectedDate,
    this.date = const AsyncLoading(),
  });

  ConsumeLogState copyWith({
    AsyncValue<List<ConsumeLog>?>? consumeLogs,
    AsyncValue<List<ConsumeFood>?>? consumeFoods,
    AsyncValue<ConsumeLog?>? todayConsumeLog,
    DateTime? selectedDate,
    AsyncValue<List<DateTime>>? date,
  }) {
    return ConsumeLogState(
      consumeLogs: consumeLogs ?? this.consumeLogs,
      consumeFoods: consumeFoods ?? this.consumeFoods,
      todayConsumeLog: todayConsumeLog ?? this.todayConsumeLog,
      selectedDate: selectedDate ?? this.selectedDate,
      date: date ?? this.date,
    );
  }
}
