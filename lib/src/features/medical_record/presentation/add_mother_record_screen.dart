import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:quickalert/quickalert.dart';

class AddMotherRecordScreen extends ConsumerWidget {
  final User user;
  const AddMotherRecordScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(medicalRecordControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Ibu'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: state.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Berat Badan',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10.0),
                  InputFormWidget(
                    controller: state.weightController,
                    onChanged: (value) {},
                    hintText: 'Contoh: 60',
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
                    'Tulis saja angka berat badan dalam kilogram',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Tekanan Darah',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10.0),
                  InputFormWidget(
                    controller: state.bloodPressureController,
                    onChanged: (value) {},
                    hintText: 'Contoh: 110/80',
                    prefixIcon: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tekanan darah tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Tulis saja angka tekanan darah dalam mmHg',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Tanggal',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10.0),
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
                              color: Colors.teal,
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
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 100.0,
            child: ElevatedButton(
              onPressed: state.mothers is AsyncLoading
                  ? () {}
                  : () async {
                      if (!state.formKey.currentState!.validate()) {
                        return;
                      }
                      await ref
                          .read(medicalRecordControllerProvider.notifier)
                          .addMother(user);
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
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: state.mothers is AsyncLoading
                  ? const LoadingWidget()
                  : const Text('Konfirmasi & Tambahkan'),
            ),
          ),
        ],
      ),
    );
  }
}
