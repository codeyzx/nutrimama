import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/common_widgets/input_form/dropdown_form_widget.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_controller.dart';
import 'package:nutrimama/src/features/community/presentation/community_controller.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:nutrimama/src/shared/utils/picker.dart';
import 'package:quickalert/quickalert.dart';

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(profileControllerProvider.notifier);
    final state = ref.watch(profileControllerProvider);
    final nutritionController = ref.read(nutritionControllerProvider.notifier);
    final nutritionState = ref.watch(nutritionControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorApp.secondary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "Edit Profil",
          style: TypographyApp.homeAppbarSmall,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AsyncValueWidget(
            value: nutritionState.nutrition,
            data: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                state.imageUrl == null || state.imageUrl == ''
                    ? Center(
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundImage: const AssetImage(
                              'assets/images/profile_default_img.png'),
                          backgroundColor: Colors.white,
                        ),
                      )
                    :
                    // check if state.imageUrl is contain https or not
                    state.imageUrl!.contains('https')
                        ? Center(
                            child: CachedNetworkImage(
                              imageUrl: state.imageUrl!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 50.r,
                                backgroundImage: imageProvider,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )
                        : Center(
                            child: CircleAvatar(
                              radius: 50.r,
                              backgroundImage: Image.file(
                                File(state.imageUrl!),
                                fit: BoxFit.cover,
                              ).image,
                              backgroundColor: Colors.white,
                            ),
                          ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors.white,
                          title: const Text(
                            'Pilih Foto',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  try {
                                    final imageUrl =
                                        await pickImage(isCamera: false);
                                    if (imageUrl != null) {
                                      controller.setImageUrl(imageUrl);
                                    }
                                  } catch (e) {
                                    Future.delayed(
                                      const Duration(milliseconds: 500),
                                      () => showSnackBar(
                                          context, Colors.red, e.toString()),
                                    );
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Dari Galeri',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  try {
                                    final imageUrl =
                                        await pickImage(isCamera: true);
                                    if (imageUrl != null) {
                                      controller.setImageUrl(imageUrl);
                                    }
                                  } catch (e) {
                                    Future.delayed(
                                      const Duration(milliseconds: 500),
                                      () => showSnackBar(
                                          context, Colors.red, e.toString()),
                                    );
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Dari Kamera',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Ubah Foto",
                      style: TextStyle(
                        color: ColorApp.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Nama",
                  style: TypographyApp.eprofileLabel,
                ),
                TextFormField(
                  controller: state.nameController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor('#E5E5E5'),
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor('#E5E5E5'),
                        width: 1.w,
                      ),
                    ),
                  ),
                  style: TypographyApp.eprofileValue,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Tinggi Badan (cm)",
                  style: TypographyApp.eprofileLabel,
                ),
                TextFormField(
                  controller: nutritionState.heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor('#E5E5E5'),
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor('#E5E5E5'),
                        width: 1.w,
                      ),
                    ),
                  ),
                  style: TypographyApp.eprofileValue,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Berat Badan (kg)",
                  style: TypographyApp.eprofileLabel,
                ),
                TextFormField(
                  controller: nutritionState.weightController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor('#E5E5E5'),
                        width: 1.w,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: HexColor('#E5E5E5'),
                        width: 1.w,
                      ),
                    ),
                  ),
                  style: TypographyApp.eprofileValue,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap.h20,
                    Text(
                      'Usia',
                      style: TextStyle(
                        color: ColorApp.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Gap.h12,
                    DropdownFormWidget(
                      value: nutritionState.age.toString(),
                      list: nutritionState.ageList,
                      prefixIcon: null,
                      onChanged: (value) {
                        if (value.isNotNull()) {
                          nutritionController.setAge(value.toString());
                        }
                      },
                    ),
                    Gap.h12,
                  ],
                ),
                SizedBox(
                  height: 150.h,
                )
              ],
            ),
          ),
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
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          onPressed: state.loadingValue is AsyncLoading
              ? null
              : () async {
                  if (state.nameController.text ==
                          state.user.asData?.value?.name &&
                      state.imageUrl == state.user.asData?.value?.photoUrl &&
                      nutritionState.heightController.text ==
                          nutritionState.nutrition.asData?.value.height
                              .toString() &&
                      nutritionState.weightController.text ==
                          nutritionState.nutrition.asData?.value.weight
                              .toString() &&
                      nutritionState.age.toString() ==
                          nutritionState.nutrition.asData?.value.age
                              .toString()) {
                    return;
                  }
                  await controller.updateProfile();
                  await controller.getProfile();
                  await nutritionController.updateNutrition(
                      state.user.asData?.value?.id.toString() ?? '');
                  await ref
                      .read(communityControllerProvider.notifier)
                      .getPosts();

                  Future.delayed(const Duration(seconds: 1), () {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Berhasil',
                        showCancelBtn: false,
                        barrierDismissible: false,
                        confirmBtnText: 'Kembali ke Beranda',
                        onConfirmBtnTap: () {
                          ref
                              .read(goRouterProvider)
                              .goNamed(Routes.botNavBar.name);
                        });
                  });
                },
          child: state.loadingValue is AsyncLoading
              ? const LoadingWidget()
              : Text(
                  "Simpan",
                  style: TypographyApp.homeOnBtn.copyWith(fontSize: 18.sp),
                ),
        ),
      ),
    );
  }
}
