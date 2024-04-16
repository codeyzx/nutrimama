import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';

class FetalRecordScreen extends StatelessWidget {
  final List<Fetal?> fetals;
  final Fetal? fetal;
  const FetalRecordScreen(
      {super.key, required this.fetals, required this.fetal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medikal Record Janin'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
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
                  'Data Kesehatan Janin',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      '${fetal?.weight ?? '0'} kg',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Panjang Janin',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '${fetal?.length ?? '0'} cm',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Detak Jantung per Menit',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      '${fetal?.heartRate ?? '0'} bpm',
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
                      fetal?.date?.dateMonthYear ?? "-",
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              'Riwayat Kesehatan Janin',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: fetals.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final fetal = fetals[index];
              return Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Berat Badan',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '${fetal?.weight ?? '0'} gram',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Panjang Janin',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '${fetal?.length ?? '0'} cm',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Detak Jantung per Menit',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '${fetal?.heartRate ?? '0'} bpm',
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
                          fetal?.date?.dateMonthYear ?? "-",
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
