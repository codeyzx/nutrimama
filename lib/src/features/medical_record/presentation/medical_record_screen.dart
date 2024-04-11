import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/async_value/async_value_widget.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_controller.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_state.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

class MedicalRecordScreen extends ConsumerStatefulWidget {
  final User user;
  const MedicalRecordScreen({super.key, required this.user});

  @override
  ConsumerState<MedicalRecordScreen> createState() =>
      _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends ConsumerState<MedicalRecordScreen> {
  MedicalRecordState get state => ref.watch(medicalRecordControllerProvider);
  MedicalRecordController get controller =>
      ref.read(medicalRecordControllerProvider.notifier);

  @override
  void initState() {
    controller.getFetal(widget.user);
    controller.getMother(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Medikal Record'),
          backgroundColor: ColorApp.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
            onPressed: () {
              ref.read(goRouterProvider).pop();
            },
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medikal Record',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Trimester 1: Minggu 12',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Pada tahap ini janin telah, Lorem ipsum dolor sit amet consectetur. Interdum consectetur a metus eget.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Trimester 1: ini isinya nanti tips',
                    style: TextStyle(fontSize: 16.0, color: Colors.teal),
                  ),
                ],
              ),
            ),
            AsyncValueWidget(
              value: state.mother,
              data: (data) => InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Ibu',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Berat Badan',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            '${data?.weight ?? '0'} kg', // Change '0' to appropriate default value
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tekanan Darah',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            '${data?.bloodPressure ?? '0'} (mm/hg)', // Change '0' to appropriate default value
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tanggal Periksa',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            data?.date.dateMonthYear ?? "-",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AsyncValueWidget(
              value: state.fetal,
              data: (data) => InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Janin',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Berat',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            '${data?.weight ?? '0'} kg', // Change '0' to appropriate default value
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Panjang',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            '${data?.length ?? '0'} cm', // Change '0' to appropriate default value
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Detak Jantung/Menit',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${data?.heartRate ?? '0'}', // Change '0' to appropriate default value
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tanggal Periksa',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            data?.date.dateMonthYear ?? "-",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.all(20.0),
                  height: 200.0,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // button tambah data ibu dan janin width 100%
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.green,
                          ),
                          onPressed: () {
                            ref
                                .read(goRouterProvider)
                                .pushNamed(Routes.addMotherRecord.name);
                          },
                          child: const Text(
                            'Tambah Data Ibu',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.primary,
                          ),
                          onPressed: () {
                            ref
                                .read(goRouterProvider)
                                .pushNamed(Routes.addFetalRecord.name);
                          },
                          child: const Text(
                            'Tambah Data Janin',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          backgroundColor: ColorApp.primary,
          child: const Icon(Icons.add),
        ));
  }
}
