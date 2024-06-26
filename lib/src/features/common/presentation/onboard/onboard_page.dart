import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/common/presentation/onboard/widget/onboarding_content.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardPage extends ConsumerWidget {
  const OnboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(commonControllerProvider);
    final controller = ref.read(commonControllerProvider.notifier);
    final pageController = PageController();

    return StatusBarWidget(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              controller.setLastPage(index == 2);
            },
            children: [
              OnboardingContent(
                  imageAsset: Assets.images.onboard1,
                  imageWidth: 300,
                  imageHeight: 230,
                  title: "Pemantauan Nutrisi Harian",
                  subtitle:
                      "Pantau makanan dan minumanmu sesuai rekomendasi nutrisi ibu hamil"),
              OnboardingContent(
                imageAsset: Assets.images.onboard2,
                imageWidth: 300,
                imageHeight: 230,
                title: "Konsultasi Kesehatanmu Bersama AI",
                subtitle:
                    "AI kami memberikan jawaban atas pertanyaan kesehatan kamu dengan data terpercaya",
              ),
              OnboardingContent(
                imageAsset: Assets.images.onboard3,
                imageWidth: 300,
                imageHeight: 230,
                title: "Pantau Kesehatan Janinmu",
                subtitle:
                    "Lacak perkembangan janin dan kesehatanmu dengan mudah dan sistematis",
              ),
            ],
          ),
        ),
        bottomSheet: state.isLastPage
            ? Container(
                padding: EdgeInsets.only(bottom: 52.h, left: 34.w, right: 34.w),
                height: 170.h,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorApp.primary,
                          dotColor: ColorApp.primary.withOpacity(0.30),
                          dotWidth: 12.w,
                          dotHeight: 12.h,
                        ),
                        onDotClicked: (index) => pageController.animateToPage(
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
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          context.goNamed(Routes.login.name);
                        },
                        child: Text(
                          'Start Now',
                          style: TypographyApp.onBoardBtnText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.only(bottom: 52.h, left: 34.w, right: 34.w),
                height: 170.h,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorApp.primary,
                          dotColor: ColorApp.primary.withOpacity(0.30),
                          dotWidth: 12.w,
                          dotHeight: 12.h,
                        ),
                        onDotClicked: (index) => pageController.animateToPage(
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
                              pageController.jumpToPage(2);
                            },
                            child: Text(
                              'Skip',
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
                              pageController.nextPage(
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
