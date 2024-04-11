import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddMotherRecordScreen extends ConsumerWidget {
  const AddMotherRecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Ibu'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambah Data Ibu',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 68',
                    labelText: 'Berat Badan (Weight)',
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Contoh: 110/80',
                    labelText: 'Tekanan Darah (Blood Pressure)',
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Tanggal Periksa (Date)',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            height: 100.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
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
