import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/common_widgets/input_form/dropdown_form_widget.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/question/question_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

// TODO: INI BELUM BERES, KETIKA SELESAI QUESTION SET FIREBASE TERUS BIKIN FIELD BUAT NARO DATA DIET
class QuestionPage extends ConsumerWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionControllerProvider);
    final controller = ref.read(questionControllerProvider.notifier);
    return StatusBarWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 5.h),
            margin: EdgeInsets.only(top: 60.h, bottom: 20.h),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/question_img_1.png',
                    width: 375.w,
                    height: 300.h,
                  ),
                ),
                SizedBox(
                  height: 13.46.h,
                ),
                Text(
                  ' Personal Information',
                  style: TypographyApp.onBoardTitle.copyWith(fontSize: 24.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Column(
                    children: [
                      Form(
                          key: state.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Gap.h28,
                              Text(
                                'Your Weight (kg)',
                                style: TextStyle(
                                  color: ColorApp.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Gap.h8,
                              InputFormWidget(
                                controller: state.weightController,
                                onChanged: (value) {},
                                hintText: 'Weight',
                                prefixIcon: Icons.monitor_weight,
                                validator: controller.validateWeight,
                                isWeight: true,
                              ),
                              Gap.h20,
                              Text(
                                'Your Height (cm)',
                                style: TextStyle(
                                  color: ColorApp.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Gap.h8,
                              InputFormWidget(
                                controller: state.heightController,
                                onChanged: (value) {},
                                hintText: 'Height',
                                prefixIcon: Icons.leaderboard,
                                validator: controller.validateHeight,
                                isHeight: true,
                              ),
                            ],
                          )),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap.h20,
                          Text(
                            'Your Age',
                            style: TextStyle(
                              color: ColorApp.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          DropdownFormWidget(
                            value: state.age,
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
                      Gap.h20,
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 40.h, left: 0.w, right: 0.w),
                        color: Colors.white,
                        child: SizedBox(
                          width: 320.w,
                          height: 50.h,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ColorApp.primary),
                            ),
                            onPressed: () async {
                              if (state.heightController.text.isEmpty ||
                                  state.weightController.text.isEmpty) {
                                hideSnackBar(context);
                                appSnackBar(
                                    context, Colors.red, 'Field do not empty');
                              } else {
                                //   final resultCalculate =
                                //       controller.calculateDiet(
                                //     gender: state.gender,
                                //     weight: double.parse(
                                //         controller.weightController.text),
                                //     height: double.parse(
                                //         controller.heightController.text),
                                //     age: int.tryParse(state.age) ?? 0,
                                //     weightGoal: state.weightGoal!,
                                //     activity: state.activity!,
                                //   );
                                //   resultCalculate['id'] = FirebaseAuth
                                //       .instance.currentUser!.uid
                                //       .toString();
//
                                //   resultCalculate['isSuccessRegister'] = true;
//
                                //   await controller.updateDiet(resultCalculate);
//
                                //   await controller.getProfile();

                                Future.delayed(const Duration(seconds: 1)).then(
                                    (value) => ref
                                        .read(goRouterProvider)
                                        .goNamed(Routes.botNavBar.name));
                              }
                            },
                            child: Text(
                              'Start',
                              style: TypographyApp.onBoardBtnText.copyWith(
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
