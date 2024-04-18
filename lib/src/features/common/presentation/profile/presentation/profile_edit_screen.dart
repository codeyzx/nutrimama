import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/common_widgets/input_form/dropdown_form_widget.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:quickalert/quickalert.dart';

// TODO: tambahin field buat input weight, age, height (update profile) dan gunain logic update nutrition
class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(profileControllerProvider.notifier);
    final state = ref.watch(profileControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
          "Edit Profile",
          style: TypographyApp.homeAppbarSmall,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              // state.user?.profileUrl == ''
              //     ? Center(
              //         child: CircleAvatar(
              //           radius: 50.r,
              //           backgroundImage: const AssetImage(
              //               'assets/images/profile_default_img.png'),
              //           backgroundColor: Colors.white,
              //         ),
              //       )
              //     : Center(
              //         child: CachedNetworkImage(
              //           imageUrl: state.user?.profileUrl ?? '',
              //           progressIndicatorBuilder:
              //               (context, url, downloadProgress) =>
              //                   CircularProgressIndicator(
              //                       value: downloadProgress.progress),
              //           errorWidget: (context, url, error) =>
              //               const Icon(Icons.error),
              //           imageBuilder: (context, imageProvider) => CircleAvatar(
              //             radius: 50.r,
              //             backgroundImage: imageProvider,
              //             backgroundColor: Colors.white,
              //           ),
              //         ),
              //       ),
              Center(
                child: Assets.images.profileDefaultImg.image(
                  width: 100.w,
                  height: 100.h,
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Change Photo",
                    style: TypographyApp.eprofileBlueBtn,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Name",
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
                "Height (cm)",
                style: TypographyApp.eprofileLabel,
              ),
              TextFormField(
                // controller: height,
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
                "Weight (kg)",
                style: TypographyApp.eprofileLabel,
              ),
              TextFormField(
                // controller: weight,
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
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap.h20,
                  Text(
                    'Age',
                    style: TextStyle(
                      color: ColorApp.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  DropdownFormWidget(
                    value: state.age ?? '20',
                    list: state.ageList,
                    prefixIcon: Icons.cake,
                    onChanged: (value) {
                      if (value.isNotNull()) {
                        controller.setAge(value.toString());
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
          ),
          onPressed: state.loadingValue is AsyncLoading
              ? null
              : () async {
                  await controller.updateProfile();
                  await controller.getProfile();

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
          child: state.loadingValue is AsyncLoading
              ? const LoadingWidget()
              : Text(
                  "Save",
                  style: TypographyApp.homeOnBtn,
                ),
        ),
      ),
    );
  }
}
