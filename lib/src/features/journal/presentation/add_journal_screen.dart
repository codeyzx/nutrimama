import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/journal/presentation/journal_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:nutrimama/src/shared/extensions/dynamic.dart';
import 'package:quickalert/quickalert.dart';

class AddJournalScreen extends ConsumerWidget {
  final User user;
  const AddJournalScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(journalControllerProvider.notifier);
    final state = ref.watch(journalControllerProvider);
    return StatusBarWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Tambah Jurnal',
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
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Judul Jurnal",
                style: TypographyApp.eprofileLabel,
              ),
              Gap.h8,
              Form(
                key: state.formKey,
                child: InputFormWidget(
                  controller: state.titleController,
                  onChanged: (value) {},
                  hintText: '',
                  prefixIcon: null,
                  validator: (value) {
                    if (value.isNull() || value == '') {
                      return 'Judul tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Konten Jurnal",
                style: TypographyApp.eprofileLabel,
              ),
              Gap.h8,
              SizedBox(
                height: 200.h,
                child: InputFormWidget(
                  controller: state.descriptionController,
                  onChanged: (value) {},
                  hintText: '',
                  prefixIcon: null,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.all(16),
          width: 1.sw,
          height: 98.h,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: HexColor('#929DAB').withOpacity(0.10),
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ]),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorApp.primary,
              padding: EdgeInsets.symmetric(horizontal: 87.w, vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: state.journals is AsyncLoading
                ? null
                : () async {
                    if (!state.formKey.currentState!.validate()) {
                      return;
                    }
                    await controller.addJournal(user.id);

                    Future.delayed(const Duration(seconds: 1), () {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: 'Success',
                          showCancelBtn: false,
                          barrierDismissible: false,
                          confirmBtnText: 'Go to Home',
                          onConfirmBtnTap: () {
                            ref
                                .read(goRouterProvider)
                                .goNamed(Routes.botNavBar.name);
                          });
                    });
                  },
            child: state.journals is AsyncLoading
                ? const LoadingWidget()
                : Text(
                    "Tambahkan Jurnal",
                    style: TypographyApp.homeOnBtn,
                  ),
          ),
        ),
      ),
    );
  }
}
