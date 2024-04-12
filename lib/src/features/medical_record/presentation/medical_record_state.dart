import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/features/medical_record/domain/mother.dart';

class MedicalRecordState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AsyncValue<List<Mother>?> mothers;
  final AsyncValue<List<Fetal>?> fetals;
  final AsyncValue<List<Fetal>?> allFetals;
  final AsyncValue<Mother?> mother;
  final AsyncValue<Fetal?> fetal;
  final TextEditingController weightController;
  final TextEditingController bloodPressureController;
  final TextEditingController lengthController;
  final TextEditingController heartRateController;
  final String? date;

  MedicalRecordState({
    this.mothers = const AsyncLoading(),
    this.fetals = const AsyncLoading(),
    this.allFetals = const AsyncLoading(),
    this.mother = const AsyncLoading(),
    this.fetal = const AsyncLoading(),
    required this.weightController,
    required this.bloodPressureController,
    required this.lengthController,
    required this.heartRateController,
    this.date,
  });

  MedicalRecordState copyWith({
    AsyncValue<List<Mother>?>? mothers,
    AsyncValue<List<Fetal>?>? fetals,
    AsyncValue<List<Fetal>?>? allFetals,
    AsyncValue<Mother?>? mother,
    AsyncValue<Fetal?>? fetal,
    TextEditingController? weightController,
    TextEditingController? bloodPressureController,
    TextEditingController? lengthController,
    TextEditingController? heartRateController,
    String? date,
  }) {
    return MedicalRecordState(
      mothers: mothers ?? this.mothers,
      fetals: fetals ?? this.fetals,
      allFetals: allFetals ?? this.allFetals,
      mother: mother ?? this.mother,
      fetal: fetal ?? this.fetal,
      weightController: weightController ?? this.weightController,
      bloodPressureController:
          bloodPressureController ?? this.bloodPressureController,
      lengthController: lengthController ?? this.lengthController,
      heartRateController: heartRateController ?? this.heartRateController,
      date: date ?? this.date,
    );
  }
}
