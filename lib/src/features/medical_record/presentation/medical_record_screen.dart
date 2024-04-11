import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/routes/app_routes.dart';

class MedicalRecordScreen extends ConsumerWidget {
  const MedicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            InkWell(
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Ibu',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Berat Badan',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '68 Kg',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tekanan Darah',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '110/80 (mm/hg)',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal Periksa',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '20 Januari 2024',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Janin',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Berat',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '100 g',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Panjang',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '15 cm',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Detak Jantung/Menit',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '120',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal Periksa',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '20 Januari 2024',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
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
