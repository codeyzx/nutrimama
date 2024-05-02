import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/common_widgets/async_value/async_value_widget.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/common/presentation/profile/presentation/profile_controller.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              AsyncValueWidget(
                value: state.user,
                loading: (loadingWidget) => const SizedBox(),
                data: (data) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data?.photoUrl != null && data?.photoUrl != ''
                          ? CircleAvatar(
                              radius: 30.r,
                              backgroundImage: CachedNetworkImageProvider(
                                data?.photoUrl ?? '',
                              ),
                              backgroundColor: Colors.white,
                            )
                          : CircleAvatar(
                              radius: 30.r,
                              backgroundImage: Assets.images.profileDefaultImg
                                  .image(
                                    width: 60.w,
                                    height: 60.h,
                                  )
                                  .image,
                              backgroundColor: Colors.white,
                            ),
                      SizedBox(
                        width: 14.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 220.w,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${data?.name}',
                                  style: TypographyApp.homeDetName,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            '${data?.email}',
                            style: TypographyApp.profileJob,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                width: 1.sw,
                height: 0.6.h,
                color: HexColor('#929DAB'),
              ),
              SizedBox(
                height: 18.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Akun Kamu",
                    style: TypographyApp.profileItemTitle,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () async {
                      final nutritionController =
                          ref.read(nutritionControllerProvider.notifier);

                      await nutritionController
                          .getNutrition(state.user.asData?.value?.id ?? '');

                      nutritionController.setTextFieldValue();
                      controller.setTextField();
                      ref
                          .read(goRouterProvider)
                          .pushNamed(Routes.profileEdit.name);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: HexColor('#5F6C7B'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 0.8.sw,
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: HexColor('#E5E5E5'),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ubah Profil",
                                style: TypographyApp.profileItem,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: HexColor('#606060'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () async {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lock_rounded,
                          color: HexColor('#5F6C7B'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 0.8.sw,
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: HexColor('#E5E5E5'),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Ubah Password",
                                style: TypographyApp.profileItem,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: HexColor('#606060'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Bantuan",
                    style: TypographyApp.profileItemTitle,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: _sendEmail,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.email_rounded,
                          color: HexColor('#5F6C7B'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 0.8.sw,
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: HexColor('#E5E5E5'),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Kontak Kami",
                                style: TypographyApp.profileItem,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: HexColor('#606060'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: _sendEmail,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.report_rounded,
                          color: HexColor('#5F6C7B'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 0.8.sw,
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: HexColor('#E5E5E5'),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Laporkan Masalah",
                                style: TypographyApp.profileItem,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: HexColor('#606060'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Lainnya",
                    style: TypographyApp.profileItemTitle,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed(Routes.snk.name);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.library_books_rounded,
                          color: HexColor('#5F6C7B'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 0.8.sw,
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: HexColor('#E5E5E5'),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Syarat & Ketentuan",
                                style: TypographyApp.profileItem,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: HexColor('#606060'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  InkWell(
                    onTap: () {
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          title: 'Apakah kamu ingin keluar?',
                          backgroundColor: Colors.white,
                          showCancelBtn: true,
                          cancelBtnText: 'Batal',
                          confirmBtnText: 'Keluar',
                          confirmBtnColor: HexColor('#DB3F3F'),
                          onConfirmBtnTap: () {
                            controller.logout();
                            ref
                                .read(goRouterProvider)
                                .goNamed(Routes.login.name);
                            ref
                                .read(commonControllerProvider.notifier)
                                .setPage(0);
                          });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.logout_rounded,
                          color: HexColor('#DB3F3F'),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 0.8.sw,
                          padding: EdgeInsets.only(bottom: 16.h),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: HexColor('#E5E5E5'),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Keluar",
                                style: TypographyApp.profileItem.copyWith(
                                  color: HexColor('#DB3F3F'),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: HexColor('#DB3F3F'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _sendEmail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'orbit.dev@gmail.com',
  );
  if (await canLaunchUrl(Uri.parse(emailLaunchUri.toString()))) {
    await launchUrl(Uri.parse(emailLaunchUri.toString()));
  } else {
    throw 'Could not launch email';
  }
}
