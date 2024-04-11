import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrimama/src/constants/constants.dart';

class AddFetalRecordScreen extends ConsumerWidget {
  const AddFetalRecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Janin (Fetal Record)'),
        backgroundColor: ColorApp.primary,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText:
                        'Contoh: 12', // Replace with appropriate hint based on image
                    labelText:
                        'Berat Badan', // Replace with appropriate label based on image
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText:
                        'Contoh: 18', // Replace with appropriate hint based on image
                    labelText:
                        'Panjang Janin (cm)', // Replace with appropriate label based on image
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText:
                        'Contoh: 110', // Replace with appropriate hint based on image
                    labelText:
                        'Detak Jantung per Menit', // Replace with appropriate label based on image
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  // This section might need to be adjusted based on your data model
                  decoration: InputDecoration(
                    labelText:
                        'Tanggal', // Replace with appropriate label based on image
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 100.0,
            child: ElevatedButton(
              onPressed: () {
                // Add functionality for the button (e.g., save data)
                print('Button pressed!');
              }, // Replace with appropriate text based on image
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorApp.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Konfirmasi & Tambahkan'),
            ),
          ),
        ],
      ),
    );
  }
}
