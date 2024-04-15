import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/src/features/medical_record/domain/mother.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

class MotherRecordScreen extends StatelessWidget {
  final List<Mother?> mothers;
  final Mother? mother;
  const MotherRecordScreen(
      {super.key, required this.mothers, required this.mother});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medikal Record Ibu'),
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
                  'Data Kesehatan Ibu',
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
                      '${mother?.weight ?? '0'} kg',
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
                      '${mother?.bloodPressure ?? '0'} (mm/hg)',
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
                      mother?.date.dateMonthYear ?? "-",
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
              'Riwayat Kesehatan Ibu',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: mothers.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final mother = mothers[index];
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
                          '${mother?.weight ?? '0'} kg',
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
                          '${mother?.bloodPressure ?? '0'} (mm/hg)',
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
                          mother?.date.dateMonthYear ?? "-",
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
