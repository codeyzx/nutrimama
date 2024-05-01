import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/common_widgets/input_form/dropdown_form_widget.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/common/presentation/question/question_controller.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_controller.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

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
                Text(
                  'Informasi Kesehatan Anda',
                  style: TypographyApp.onBoardTitle.copyWith(fontSize: 24.sp),
                  textAlign: TextAlign.center,
                ),
                Gap.h12,
                Center(
                  child: Assets.images.question.svg(
                    width: 300.w,
                    height: 200.h,
                  ),
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
                                'Tinggi Badan Anda (cm)',
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
                                keyboardType: TextInputType.number,
                                hintText: '160',
                                prefixIcon: Icons.leaderboard,
                                validator: controller.validateHeight,
                                isHeight: true,
                              ),
                              Gap.h20,
                              Text(
                                'Berat Badan Anda (kg)',
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
                                keyboardType: TextInputType.number,
                                hintText: '50',
                                prefixIcon: Icons.monitor_weight,
                                validator: controller.validateWeight,
                                isWeight: true,
                              ),
                            ],
                          )),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap.h20,
                          Text(
                            'Usia Anda',
                            style: TextStyle(
                              color: ColorApp.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          DropdownFormWidget(
                            value: state.age,
                            list: state.ageList,
                            prefixIcon: null,
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
                            onPressed: state.loadingValue is AsyncLoading
                                ? () {}
                                : () async {
                                    if (state.heightController.text.isEmpty ||
                                        state.weightController.text.isEmpty) {
                                      hideSnackBar(context);
                                      appSnackBar(context, Colors.red,
                                          'Field do not empty');
                                    } else {
                                      controller.setLoading();
                                      final resultCalculate = ref
                                          .read(nutritionControllerProvider
                                              .notifier)
                                          .calculateNutrition(
                                              weight: double.parse(
                                                  state.weightController.text),
                                              height: double.parse(
                                                  state.heightController.text),
                                              age: int.parse(state.age));

                                      await ref
                                          .read(
                                              commonControllerProvider.notifier)
                                          .getProfile();

                                      String uid = ref
                                          .read(
                                              commonControllerProvider.notifier)
                                          .getUid();

                                      final conceptionDate = ref
                                              .read(commonControllerProvider)
                                              .userValue
                                              .asData
                                              ?.value
                                              .fetalDate ??
                                          DateTime.now();

                                      await ref
                                          .read(nutritionControllerProvider
                                              .notifier)
                                          .setNutrition(resultCalculate, uid);

                                      await ref
                                          .read(nutritionControllerProvider
                                              .notifier)
                                          .getNutrition(uid);

                                      await ref
                                          .read(consumeLogControllerProvider
                                              .notifier)
                                          .getConsumeLogs(uid);
                                      await ref
                                          .read(consumeLogControllerProvider
                                              .notifier)
                                          .getTodayConsumeLog(
                                              uid, DateTime.now().toYyyyMMDd);
                                      await ref
                                          .read(consumeLogControllerProvider
                                              .notifier)
                                          .getTodayConsumeFood(
                                              uid, DateTime.now().toYyyyMMDd);
                                      ref
                                          .read(consumeLogControllerProvider
                                              .notifier)
                                          .getDate();
                                      ref
                                          .read(medicalRecordControllerProvider
                                              .notifier)
                                          .getTrimester(conceptionDate);

                                      controller.setSuccess();

                                      Future.delayed(const Duration(seconds: 1))
                                          .then((value) => ref
                                              .read(goRouterProvider)
                                              .goNamed(Routes.botNavBar.name));
                                    }
                                  },
                            child: state.loadingValue is AsyncLoading
                                ? const LoadingWidget()
                                : Text(
                                    'Mulai',
                                    style:
                                        TypographyApp.onBoardBtnText.copyWith(
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
