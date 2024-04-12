import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/question/question_controller.dart';
import 'package:nutrimama/src/features/common/presentation/question/widget/widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// TODO: INI BELUM BERES, KETIKA SELESAI QUESTION SET FIREBASE TERUS BIKIN FIELD BUAT NARO DATA DIET
class QuestionPage extends ConsumerWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(questionControllerProvider);
    final controller = ref.read(questionControllerProvider.notifier);
    final pageControler = PageController();

    return StatusBarWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: PageView(
            controller: pageControler,
            onPageChanged: (index) {
              controller.setLastPage(index == 2);
            },
            children: [
              QuestionContent(
                  imageAsset: 'assets/images/question_img_1.png',
                  imageWidth: 375,
                  imageHeight: 281,
                  title: 'Your Personal Information',
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: const Column(
                      children: [
                        QuestionDropDownForm(),
                        QuestionInputForm(),
                      ],
                    ),
                  )),
              QuestionContent(
                  imageAsset: 'assets/images/question_img_1.png',
                  imageWidth: 375,
                  imageHeight: 281,
                  title: 'Your Personal Information',
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: const Column(
                      children: [
                        QuestionDropDownForm(),
                        QuestionInputForm(),
                      ],
                    ),
                  )),
              QuestionContent(
                  imageAsset: 'assets/images/question_img_1.png',
                  imageWidth: 375,
                  imageHeight: 281,
                  title: 'Your Personal Information',
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: const Column(
                      children: [
                        QuestionDropDownForm(),
                        QuestionInputForm(),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        bottomSheet: state.isLastPage
            ? Container(
                padding: EdgeInsets.only(bottom: 52.h, left: 34.w, right: 34.w),
                height: 140.h,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageControler,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorApp.primary,
                          dotColor: ColorApp.primary.withOpacity(0.30),
                          dotWidth: 12.w,
                          dotHeight: 12.h,
                        ),
                        onDotClicked: (index) => pageControler.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 320.w,
                      height: 50.h,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorApp.primary),
                        ),
                        onPressed: () async {
                          // if (state.heightController.text.isEmpty ||
                          //     state.weightController.text.isEmpty) {
                          //   hideSnackBar(context);
                          //   appSnackBar(
                          //       context, Colors.red, 'Field do not empty');
                          // } else {
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
//
                          //   Future.delayed(const Duration(seconds: 1)).then(
                          //       (value) =>
                          //           context.goNamed(Routes.botNavBar.name));
                          // }
                        },
                        child: Text(
                          'Start',
                          style: TypographyApp.onBoardBtnText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.only(bottom: 52.h, left: 34.w, right: 34.w),
                height: 140.h,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageControler,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorApp.primary,
                          dotColor: ColorApp.primary.withOpacity(0.30),
                          dotWidth: 12.w,
                          dotHeight: 12.h,
                        ),
                        onDotClicked: (index) => pageControler.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120.w,
                          height: 50.h,
                          child: TextButton(
                            onPressed: () {
                              pageControler.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Back',
                              style: TypographyApp.onBoardUnBtnText,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 120.w,
                          height: 50.h,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ColorApp.primary),
                            ),
                            onPressed: () {
                              pageControler.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: Text(
                              'Next',
                              style: TypographyApp.onBoardBtnText,
                            ),
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
