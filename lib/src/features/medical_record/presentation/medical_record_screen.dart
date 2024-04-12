import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/common_widgets/async_value/async_value_widget.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_controller.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_state.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';
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
              data: (data) => data.isNull()
                  ? Center(
                      child: Container(
                        width: double.infinity,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Data ibu belum ada',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 10.0),
                            ElevatedButton(
                              onPressed: () {
                                ref.read(goRouterProvider).pushNamed(
                                      Routes.addMotherRecord.name,
                                      extra: Extras(
                                        datas: {
                                          ExtrasKey.user: widget.user,
                                        },
                                      ),
                                    );
                              },
                              child: const Text('Tambahkan Data Ibu'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        ref
                            .read(goRouterProvider)
                            .pushNamed(Routes.motherRecord.name,
                                extra: Extras(datas: {
                                  ExtrasKey.mothers:
                                      state.mothers.asData?.value ?? [],
                                  ExtrasKey.mother: data,
                                }));
                      },
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
                                  '${data?.weight ?? '0'} kg',
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
                                  '${data?.bloodPressure ?? '0'} (mm/hg)',
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
              error: (errorWidget) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Gagal memuat data ibu',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        controller.getMother(widget.user);
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.user.fetalId.isEmpty &&
                state.allFetals.asData?.value?.isNotEmpty == true)
              Center(
                child: Container(
                  width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Ingin menambahkan data janin lagi?',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(goRouterProvider).pushNamed(
                                Routes.addFetalRecord.name,
                                extra: Extras(
                                  datas: {
                                    ExtrasKey.user: widget.user,
                                    ExtrasKey.isNewFetal: true,
                                  },
                                ),
                              );
                        },
                        child: const Text('Tambahkan Data Janin'),
                      ),
                    ],
                  ),
                ),
              ),
            AsyncValueWidget(
              value: state.allFetals,
              data: (data) {
                final fetals = _groupAndSelectLatestFetals(data ?? []);
                return data!.isEmpty
                    ? Center(
                        child: Container(
                          width: double.infinity,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Data janin belum ada',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 10.0),
                              ElevatedButton(
                                onPressed: () {
                                  ref.read(goRouterProvider).pushNamed(
                                        Routes.addFetalRecord.name,
                                        extra: Extras(
                                          datas: {
                                            ExtrasKey.user: widget.user,
                                            ExtrasKey.isNewFetal: true,
                                          },
                                        ),
                                      );
                                },
                                child: const Text('Tambahkan Data Janin'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: fetals.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final fetal = data[index];
                          return InkWell(
                            onTap: () {
                              ref
                                  .read(goRouterProvider)
                                  .pushNamed(Routes.fetalRecord.name,
                                      extra: Extras(datas: {
                                        ExtrasKey.fetals: state
                                                .allFetals.asData?.value
                                                ?.where((e) =>
                                                    e.fetalId == fetal.fetalId)
                                                .toList() ??
                                            [],
                                        ExtrasKey.fetal: fetal,
                                      }));
                            },
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
                                  Row(
                                    children: [
                                      Text(
                                        'Data Janin ${fetals.length == 1 ? '' : fetals.length - index}',
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      if (fetal.isBorn)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0,
                                            vertical: 5.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: const Text(
                                            'Sudah Lahir',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Berat Badan',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '${fetal.weight} gram',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Panjang',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '${fetal.length} cm',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Detak Jantung',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        '${fetal.heartRate} bpm',
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Tanggal Periksa',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Text(
                                        fetal.date?.dateMonthYear ?? "-",
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Tanggal Mengandung',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      AutoSizeText(
                                        fetal.fetalDate.dateMonthYear,
                                      )
                                    ],
                                  ),
                                  if (fetal.date.isNotNull())
                                    if (fetal.fetalDate
                                            .add(const Duration(days: 280))
                                            .isBefore(DateTime.now()) &&
                                        !fetal.isBorn)
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Apakah janin sudah lahir?',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 10.0,
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  // TODO: Add logic to update fetal status on repository too
                                                },
                                                child: const Text(
                                                  'Ya',
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
              error: (errorWidget) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Gagal memuat data janin',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        controller.getFetal(widget.user);
                      },
                      child: const Text('Coba Lagi'),
                    ),
                  ],
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
                  padding: const EdgeInsets.only(
                    top: 30.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  height: 180.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.green,
                            shape: const BeveledRectangleBorder(),
                          ),
                          onPressed: () {
                            ref.read(goRouterProvider).pushNamed(
                                  Routes.addMotherRecord.name,
                                  extra: Extras(
                                    datas: {
                                      ExtrasKey.user: widget.user,
                                    },
                                  ),
                                );
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
                      const SizedBox(height: 12.0),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorApp.primary,
                            shape: const BeveledRectangleBorder(),
                          ),
                          onPressed: () {
                            ref.read(goRouterProvider).pushNamed(
                                  Routes.addFetalRecord.name,
                                  extra: Extras(
                                    datas: {
                                      ExtrasKey.user: widget.user,
                                      ExtrasKey.isNewFetal:
                                          widget.user.fetalId.isEmpty &&
                                              state.allFetals.asData?.value
                                                      ?.isEmpty ==
                                                  true,
                                    },
                                  ),
                                );
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

List<Fetal> _groupAndSelectLatestFetals(List<Fetal> data) {
  final List<Fetal> groupedFetals = [];
  final Map<String, List<Fetal>> grouped = {};

  // Grouping fetals by fetalId
  for (var fetal in data) {
    if (!grouped.containsKey(fetal.fetalId)) {
      grouped[fetal.fetalId] = [];
    }
    grouped[fetal.fetalId]!.add(fetal);
  }

  // Selecting the latest fetal for each group
  grouped.forEach((key, value) {
    final latestFetal = value.reduce((a, b) => a.date == null
        ? b
        : b.date == null
            ? a
            : a.date!.isAfter(b.date!)
                ? a
                : b);
    groupedFetals.add(latestFetal);
  });

  return groupedFetals;
}
