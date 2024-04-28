import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';

class ConsumeLog {
  final DateTime date;
  final List<ConsumeFood> foods;
  final int totalDrink;
  final int totalCalories;
  final int totalCarbs;
  final int totalFat;
  final int totalProtein;
  final int totalIron;
  final int totalCalcium;
  final int totalSugars;
  final int totalVitamin;

  ConsumeLog({
    required this.date,
    required this.foods,
    required this.totalDrink,
    required this.totalCalories,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalProtein,
    required this.totalIron,
    required this.totalCalcium,
    required this.totalSugars,
    required this.totalVitamin,
  });

  factory ConsumeLog.fromJson(Map<String, dynamic> json) {
    return ConsumeLog(
      date:
          json['date'] == null ? DateTime.now() : DateTime.parse(json['date']),
      foods: json['foods'] == null
          ? []
          : List<ConsumeFood>.from(
              json['foods'].map((x) => ConsumeFood.fromJson(x))),
      totalDrink: json['totalDrink'] ?? 0,
      totalCalories: json['totalCalories'] ?? 0,
      totalCarbs: json['totalCarbs'] ?? 0,
      totalFat: json['totalFat'] ?? 0,
      totalProtein: json['totalProtein'] ?? 0,
      totalIron: json['totalIron'] ?? 0,
      totalCalcium: json['totalCalcium'] ?? 0,
      totalSugars: json['totalSugars'] ?? 0,
      totalVitamin: json['totalVitamin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date.toYyyyMMDd,
      'foods': foods.map((x) => x.toJson()).toList(),
      'totalDrink': totalDrink,
      'totalCalories': totalCalories,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
      'totalProtein': totalProtein,
      'totalIron': totalIron,
      'totalCalcium': totalCalcium,
      'totalSugars': totalSugars,
      'totalVitamin': totalVitamin,
    };
  }

  ConsumeLog copyWith({
    DateTime? date,
    List<ConsumeFood>? foods,
    int? totalDrink,
    int? totalCalories,
    int? totalCarbs,
    int? totalFat,
    int? totalProtein,
    int? totalIron,
    int? totalCalcium,
    int? totalSugars,
    int? totalVitamin,
  }) {
    return ConsumeLog(
      date: date ?? this.date,
      foods: foods ?? this.foods,
      totalDrink: totalDrink ?? this.totalDrink,
      totalCalories: totalCalories ?? this.totalCalories,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalFat: totalFat ?? this.totalFat,
      totalProtein: totalProtein ?? this.totalProtein,
      totalIron: totalIron ?? this.totalIron,
      totalCalcium: totalCalcium ?? this.totalCalcium,
      totalSugars: totalSugars ?? this.totalSugars,
      totalVitamin: totalVitamin ?? this.totalVitamin,
    );
  }
}
