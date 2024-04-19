import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/journal/presentation/journal_controller.dart';
import 'package:nutrimama/src/features/journal/presentation/widgets/journal_widget.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';

class JournalScreen extends ConsumerWidget {
  final User user;
  const JournalScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(journalControllerProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Jurnal',
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
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 16.w,
                right: 20.w,
                top: 10.h,
                bottom: 16.h,
              ),
              height: 80.h,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                color: ColorApp.primary,
                dashPattern: const [8, 4],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: InkWell(
                    onTap: () {
                      ref.read(goRouterProvider).pushNamed(
                            Routes.addJournal.name,
                            extra: Extras(
                              datas: {
                                ExtrasKey.user: user,
                              },
                            ),
                          );
                    },
                    child: Container(
                        color: HexColor('#0366DA').withOpacity(.2),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tambah Jurnal Hari Ini",
                                style: TextStyle(
                                  color: ColorApp.primary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                Icons.add,
                                color: ColorApp.primary,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ),
            AsyncValueWidget(
              value: state.journals,
              data: (journals) => Expanded(
                child: ListView.builder(
                  itemCount: journals!.length,
                  itemBuilder: (context, index) {
                    return JournalWidget(journal: journals[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
