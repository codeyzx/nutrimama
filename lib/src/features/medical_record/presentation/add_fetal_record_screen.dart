import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_controller.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_state.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:quickalert/quickalert.dart';

class AddFetalRecordScreen extends ConsumerWidget {
  final User user;
  final bool isNewFetal;
  const AddFetalRecordScreen({
    super.key,
    required this.user,
    required this.isNewFetal,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(medicalRecordControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Data Janin',
          style: TypographyApp.appBarMedrec,
        ),
        backgroundColor: ColorApp.white,
        leading: IconButton(
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: isNewFetal
          ? FormNewFetalWidget(state: state, user: user)
          : FormFetalWidget(state: state, user: user),
    );
  }
}

class FormFetalWidget extends ConsumerWidget {
  const FormFetalWidget({
    super.key,
    required this.state,
    required this.user,
  });

  final MedicalRecordState state;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Berat Badan',
                    style: TypographyApp.appBarMedrec,
                  ),
                  SizedBox(height: 8.h),
                  InputFormWidget(
                    controller: state.weightController,
                    onChanged: (value) {},
                    hintText: 'Contoh: 120',
                    prefixIcon: null,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Berat badan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Tulis saja angka berat badan dalam gram',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Panjang Janin',
                    style: TypographyApp.appBarMedrec,
                  ),
                  const SizedBox(height: 10.0),
                  InputFormWidget(
                    controller: state.lengthController,
                    onChanged: (value) {},
                    hintText: 'Contoh: 30',
                    prefixIcon: null,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Panjang janin tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Tulis saja angka panjang janin dalam cm',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Detak Jantung per Menit',
                    style: TypographyApp.appBarMedrec,
                  ),
                  const SizedBox(height: 10.0),
                  InputFormWidget(
                    controller: state.heartRateController,
                    onChanged: (value) {},
                    hintText: 'Contoh: 110',
                    prefixIcon: null,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Detak jantung tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Tulis saja angka satuan detak jantung per menit',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Tanggal Pemeriksaan',
                    style: TypographyApp.appBarMedrec,
                  ),
                  const SizedBox(height: 10.0),
                  // using date picker not text field
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.date == null
                              ? DateTime.now().dateMonthYear
                              : DateTime.parse(state.date!).dateMonthYear,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                ref
                                    .read(medicalRecordControllerProvider
                                        .notifier)
                                    .setDate(value.toString());
                              }
                            });
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: ColorApp.primary,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 53.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.fetals is AsyncLoading
                  ? () {}
                  : () async {
                      if (!state.formKey.currentState!.validate()) {
                        return;
                      }
                      await ref
                          .read(medicalRecordControllerProvider.notifier)
                          .addFetal(user, false);
                      await ref
                          .read(commonControllerProvider.notifier)
                          .getProfile();
                      Future.delayed(const Duration(seconds: 1), () {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Success',
                            showCancelBtn: false,
                            barrierDismissible: false,
                            confirmBtnText: 'Go to Home',
                            onConfirmBtnTap: () {
                              ref.read(goRouterProvider).pop();
                              ref.read(goRouterProvider).pop();
                              ref.read(goRouterProvider).pop();
                              ref.read(goRouterProvider).pop();
                            });
                      });
                    },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorApp.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: state.fetals is AsyncLoading
                  ? const LoadingWidget()
                  : const Text('Konfirmasi & Tambahkan'),
            ),
          ),
        ],
      ),
    );
  }
}

class FormNewFetalWidget extends ConsumerWidget {
  const FormNewFetalWidget({
    super.key,
    required this.state,
    required this.user,
  });

  final MedicalRecordState state;
  final User user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Mengandung Janin',
                    style: TypographyApp.appBarMedrec,
                  ),
                  const SizedBox(height: 10.0),
                  // using date picker not text field
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.date == null
                              ? DateTime.now().dateMonthYear
                              : DateTime.parse(state.date!).dateMonthYear,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                ref
                                    .read(medicalRecordControllerProvider
                                        .notifier)
                                    .setDate(value.toString());
                              }
                            });
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: ColorApp.primary,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: 53.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: state.fetals is AsyncLoading
                  ? () {}
                  : () async {
                      if (!state.formKey.currentState!.validate()) {
                        return;
                      }
                      await ref
                          .read(medicalRecordControllerProvider.notifier)
                          .addFetal(user, true);
                      await ref
                          .read(commonControllerProvider.notifier)
                          .getProfile();
                      Future.delayed(const Duration(seconds: 1), () {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.success,
                            title: 'Success',
                            showCancelBtn: false,
                            barrierDismissible: false,
                            confirmBtnText: 'Go to Home',
                            onConfirmBtnTap: () {
                              ref.read(goRouterProvider).pop();
                              ref.read(goRouterProvider).pop();
                              ref.read(goRouterProvider).pop();
                              ref.read(goRouterProvider).pop();
                            });
                      });
                    },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorApp.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: state.fetals is AsyncLoading
                  ? const LoadingWidget()
                  : const Text('Konfirmasi & Tambahkan'),
            ),
          ),
        ],
      ),
    );
  }
}
