import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/features/journal/domain/journal.dart';

class DetailJournalScreen extends ConsumerWidget {
  final Journal journal;
  final String imageUrl;
  const DetailJournalScreen(
      {super.key, required this.journal, required this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Detail Jurnal',
              style: TextStyle(fontWeight: FontWeight.bold)),
          leading: Container(
            margin: const EdgeInsets.only(
              left: 16,
              top: 10,
              bottom: 10,
              right: 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: .5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 20,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // image journal
              Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    alignment: Alignment.topLeft,
                    image: AssetImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // title journal
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  journal.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // content journal
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  journal.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
