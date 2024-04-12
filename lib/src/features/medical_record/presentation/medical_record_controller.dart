import 'package:flutter/material.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/medical_record/data/medical_record_repository.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/features/medical_record/domain/mother.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'medical_record_controller.g.dart';

@riverpod
class MedicalRecordController extends _$MedicalRecordController {
  @override
  MedicalRecordState build() {
    return MedicalRecordState(
      weightController: TextEditingController(),
      bloodPressureController: TextEditingController(),
      lengthController: TextEditingController(),
      heartRateController: TextEditingController(),
    );
  }

  Future<void> getFetal(User user) async {
    final result =
        await ref.read(medicalRecordRepositoryProvider).getFetal(user);
    result.when(
      success: (data) {
        for (var element in data) {
          Logger().i(element.toJson());
        }
        data.sort((a, b) => b.date.compareTo(a.date));
        state = state.copyWith(
          allFetals: AsyncData(data),
          fetals: AsyncData(getFetalsById(user.fetalId, data)),
          fetal: AsyncData(getLatestFetal(user.fetalId, data)),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          allFetals: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> addFetal(User user) async {
    state = state.copyWith(
      fetals: const AsyncLoading(),
    );

    final fetal = Fetal(
      id: '',
      fetalId: user.fetalId,
      weight: double.tryParse(state.weightController.text) ?? 0.0,
      date: state.date == null
          ? DateTime.now()
          : DateTime.parse(state.date.toString()),
      length: double.tryParse(state.lengthController.text) ?? 0.0,
      heartRate: int.tryParse(state.heartRateController.text) ?? 0,
    );

    final result =
        await ref.read(medicalRecordRepositoryProvider).addFetal(fetal, user);
    result.when(
      success: (data) {
        getFetal(user);
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          fetals: AsyncError(error, stackTrace),
        );
      },
    );
  }

  List<Fetal> getFetalsById(String fetalId, List<Fetal> fetals) {
    return fetals.where((element) => element.fetalId == fetalId).toList();
  }

  Fetal? getLatestFetal(String fetalId, List<Fetal> fetals) {
    final fetalsById = getFetalsById(fetalId, fetals);
    if (fetalsById.isEmpty) return null;
    fetalsById.sort((a, b) => a.date.compareTo(b.date));
    return fetalsById.last;
  }

  Future<void> getMother(User user) async {
    final result =
        await ref.read(medicalRecordRepositoryProvider).getMother(user);
    result.when(
      success: (data) {
        for (var element in data) {
          Logger().i(element.toJson());
        }
        data.sort((a, b) => b.date.compareTo(a.date));
        state = state.copyWith(
          mothers: AsyncData(data),
          mother: AsyncData(data.first),
        );
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          mothers: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Future<void> addMother(User user) async {
    state = state.copyWith(
      mothers: const AsyncLoading(),
    );

    final mother = Mother(
      id: '',
      date: state.date == null
          ? DateTime.now()
          : DateTime.parse(state.date.toString()),
      weight: double.tryParse(state.weightController.text) ?? 0.0,
      bloodPressure: state.bloodPressureController.text,
    );

    final result =
        await ref.read(medicalRecordRepositoryProvider).addMother(mother, user);
    result.when(
      success: (data) {
        getMother(user);
      },
      failure: (error, stackTrace) {
        state = state.copyWith(
          mothers: AsyncError(error, stackTrace),
        );
      },
    );
  }

  Mother? getLatestMother(List<Mother> data) {
    if (data.isEmpty) return null;
    data.sort((a, b) => a.date.compareTo(b.date));
    return data.last;
  }

  void setDate(String date) {
    state = state.copyWith(date: date);
  }
}
