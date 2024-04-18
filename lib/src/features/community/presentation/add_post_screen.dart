import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/community/presentation/community_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:nutrimama/src/shared/extensions/dynamic.dart';
import 'package:quickalert/quickalert.dart';
import 'package:dotted_border/dotted_border.dart';

class AddPostScreen extends ConsumerWidget {
  final User user;
  const AddPostScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(communityControllerProvider.notifier);
    final state = ref.watch(communityControllerProvider);
    return StatusBarWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Tambah Post',
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
              SizedBox(
                height: 200,
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  color: ColorApp.primary,
                  dashPattern: const [8, 4],
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: InkWell(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Choose Image',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                )),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      try {
                                        await controller.pickImage(
                                            isCamera: false);
                                      } catch (e) {
                                        Logger().e(e);
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () => showSnackBar(context,
                                                Colors.red, e.toString()));
                                      }
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.image,
                                            ),
                                          ),
                                          TextSpan(
                                              text: '  From Gallery',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(context);
                                      try {
                                        await controller.pickImage(
                                            isCamera: true);
                                      } catch (e) {
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () => showSnackBar(context,
                                                ColorApp.red, e.toString()));
                                      }
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.camera_alt,
                                            ),
                                          ),
                                          TextSpan(
                                              text: '  From Camera',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: state.imageUrl != null &&
                              state.imageUrl!.isNotEmpty
                          ? SizedBox(
                              height: 200,
                              width: 1.sw,
                              child: Image.file(
                                File(state.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              height: 200,
                              color: HexColor('#0366DA').withOpacity(.2),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Tambahkan Foto",
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
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Judul Post",
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
                "Konten Post",
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
            onPressed: state.posts is AsyncLoading
                ? null
                : () async {
                    if (!state.formKey.currentState!.validate()) {
                      return;
                    }
                    await controller.addPost(user);

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
            child: state.posts is AsyncLoading
                ? const LoadingWidget()
                : Text(
                    "Tambahkan Post",
                    style: TypographyApp.homeOnBtn,
                  ),
          ),
        ),
      ),
    );
  }
}
