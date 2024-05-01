import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/constants/themes/themes.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/features/food/presentation/food_controller.dart';
import 'package:nutrimama/src/features/nutrition/domain/nutrition.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';
import 'package:quickalert/quickalert.dart';

class DetailFoodScreen extends ConsumerWidget {
  final Food food;
  final String consumeAt;
  const DetailFoodScreen(
      {super.key, required this.food, required this.consumeAt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(foodControllerProvider.notifier);
    final state = ref.watch(foodControllerProvider);
    final nutritionState = ref.watch(nutritionControllerProvider);
    final nutrition = nutritionState.nutrition.asData!.value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail ${food.type == 'food' ? 'Makanan' : 'Minuman'}',
            style: TypographyApp.appBarFoodSearch),
        centerTitle: true,
        leadingWidth: 78.w,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          iconSize: 20,
          padding: const EdgeInsets.all(8.0),
          color: Colors.black,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(color: HexColor('#CCD1D6'), width: 0.3.w),
            ),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.h,
              ),
              food.imageUrl.isEmpty
                  ? Container(
                      width: 378.w,
                      height: 180.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Assets.images.defaultFood.image(fit: BoxFit.cover),
                    )
                  : Container(
                      width: 378.w,
                      height: 180.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(food.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
              SizedBox(height: 24.h),
              Center(
                child: Text(food.name, style: TypographyApp.foodNameDetail),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                width: 377.w,
                child: ElevatedButton(
                    onPressed: () async {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        title: 'Berhasil',
                        text:
                            'Berhasil menambahkan ${consumeAt == 'lunch' ? 'Makan Siang' : consumeAt == 'dinner' ? 'Makan Malam' : 'Sarapan'}',
                        barrierDismissible: false,
                        confirmBtnColor: ColorApp.primary,
                        confirmBtnText: 'Kembali ke Beranda',
                        onConfirmBtnTap: () async {
                          final uid = ref
                              .read(commonControllerProvider.notifier)
                              .getUid();
                          ConsumeFood consumeFood =
                              ConsumeFood.fromFood(food, consumeAt);
                          await ref
                              .read(consumeLogControllerProvider.notifier)
                              .addConsumeFood(
                                  uid, DateTime.now().toYyyyMMDd, consumeFood);
                          ref
                              .read(goRouterProvider)
                              .goNamed(Routes.botNavBar.name);
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      backgroundColor: ColorApp.primary,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Text(
                      'Tambahkan ${consumeAt == 'lunch' ? 'Makan Siang' : consumeAt == 'dinner' ? 'Makan Malam' : 'Sarapan'}',
                      style: TypographyApp.addOnBtnDetail,
                    )),
              ),
              SizedBox(height: 32.h),
              Container(
                width: 378.w,
                height: 42.h,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: HexColor('#E7E7E7'),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 183.w,
                      child: ElevatedButton(
                        onPressed: state.isGuide ? controller.setGuide : () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          backgroundColor: state.isGuide
                              ? HexColor('#E7E7E7')
                              : Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          elevation: 0,
                        ),
                        child: Text(
                          'Nutrisi',
                          style: state.isGuide
                              ? TypographyApp.switchOffBtnDetail
                              : TypographyApp.switchOnBtnDetail,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 183.w,
                      child: ElevatedButton(
                        onPressed: !state.isGuide ? controller.setGuide : () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          backgroundColor: !state.isGuide
                              ? HexColor('#E7E7E7')
                              : Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          elevation: 0,
                        ),
                        child: Text(
                          'Panduan',
                          style: !state.isGuide
                              ? TypographyApp.switchOffBtnDetail
                              : TypographyApp.switchOnBtnDetail,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              state.isGuide
                  ? GuideWidget(food: food)
                  : NutritionWidget(food: food, nutrition: nutrition),
            ],
          ),
        ),
      ),
    );
  }
}

class GuideWidget extends StatelessWidget {
  const GuideWidget({
    super.key,
    required this.food,
  });

  final Food food;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bahan-Bahan',
          style: TypographyApp.panduanTitleDetail,
        ),
        SizedBox(
          height: 12.h,
        ),
        food.ingredients.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: food.ingredients
                    .map((ingredient) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ingredient has name and amount
                            Padding(
                              padding: EdgeInsets.only(bottom: 16.h),
                              child: Text(
                                ingredient.name,
                                style: TypographyApp.panduanBahanDetail,
                              ),
                            ),
                            Text(
                              ingredient.total,
                              style: TypographyApp.panduanBahanDetail,
                            ),
                          ],
                        ))
                    .toList(),
              )
            : const Text(
                "Tidak ada bahan",
                style: TextStyle(fontSize: 16),
              ),
        SizedBox(height: 24.h),
        Text("Instruksi", style: TypographyApp.panduanTitleDetail),
        SizedBox(height: 12.h),
        food.instructions.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: food.instructions
                    .map((instruction) => Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // instruction has title and description
                              Text(
                                instruction.title,
                                style: TypographyApp.panduanStepsDetail,
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                instruction.description,
                                style: TypographyApp.panduanStepsDescDetail,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              )
            : const Text(
                "Tidak ada panduan",
                style: TextStyle(fontSize: 16),
              ),
      ],
    );
  }
}

class NutritionWidget extends StatelessWidget {
  const NutritionWidget({
    super.key,
    required this.food,
    required this.nutrition,
  });

  final Food food;
  final Nutrition nutrition;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 377.w,
      height: 222.h,
      padding: EdgeInsets.only(top: 16.h, left: 9.w, right: 9.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: HexColor('#CCD1D6'),
            width: 0.3.w,
          ),
          boxShadow: [
            BoxShadow(
                color: HexColor('#000000').withOpacity(0.10),
                blurRadius: 4,
                offset: const Offset(0, 1)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Kalori',
                style: TypographyApp.calorieNeedsFood,
              ),
              Text(
                '${food.calories}/${nutrition.calories} Kkal',
                style: TypographyApp.calorieNeedsNumFood,
              ),
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            child: SizedBox(
              width: 358.w,
              child: LinearProgressIndicator(
                value: food.calories / nutrition.calories,
                minHeight: 8.h,
                borderRadius: BorderRadius.circular(6.r),
                backgroundColor: HexColor('#D9D9D9'),
                valueColor: AlwaysStoppedAnimation<Color>(HexColor('#0366DA')),
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${food.protein}/${nutrition.protein}g',
                    style: TypographyApp.nutrNeedsNumFood,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Protein',
                    style: TypographyApp.nutrNeedsLabelFood,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    child: SizedBox(
                      width: 64.w,
                      child: LinearProgressIndicator(
                        value: food.protein / nutrition.protein,
                        minHeight: 7.h,
                        borderRadius: BorderRadius.circular(6.r),
                        backgroundColor: HexColor('#D9D9D9'),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#03DA8D')),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${food.carbs}/${nutrition.carbs}g',
                    style: TypographyApp.nutrNeedsNumFood,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Karbohidrat',
                    style: TypographyApp.nutrNeedsLabelFood,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    child: SizedBox(
                      width: 64.w,
                      child: LinearProgressIndicator(
                        value: food.carbs / nutrition.carbs,
                        minHeight: 7.h,
                        borderRadius: BorderRadius.circular(6.r),
                        backgroundColor: HexColor('#D9D9D9'),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#DA9E03')),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${food.fat}/${nutrition.fat}g',
                    style: TypographyApp.nutrNeedsNumFood,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Lemak',
                    style: TypographyApp.nutrNeedsLabelFood,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    child: SizedBox(
                      width: 64.w,
                      child: LinearProgressIndicator(
                        value: food.fat / nutrition.fat,
                        minHeight: 7.h,
                        borderRadius: BorderRadius.circular(6.r),
                        backgroundColor: HexColor('#D9D9D9'),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#7B03DA')),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${food.sugars}/${nutrition.sugars}g',
                    style: TypographyApp.nutrNeedsNumFood,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Sugar',
                    style: TypographyApp.nutrNeedsLabelFood,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    child: SizedBox(
                      width: 64.w,
                      child: LinearProgressIndicator(
                        value: food.sugars / nutrition.sugars,
                        minHeight: 7.h,
                        borderRadius: BorderRadius.circular(6.r),
                        backgroundColor: HexColor('#D9D9D9'),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#6EDA03')),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${food.iron}/${nutrition.iron}mg',
                    style: TypographyApp.nutrNeedsNumFood,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Zat Besi',
                    style: TypographyApp.nutrNeedsLabelFood,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    child: SizedBox(
                      width: 64.w,
                      child: LinearProgressIndicator(
                        value: food.iron / nutrition.iron,
                        minHeight: 7.h,
                        borderRadius: BorderRadius.circular(6.r),
                        backgroundColor: HexColor('#D9D9D9'),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#DA3603')),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${food.calcium}/${nutrition.calcium}mg',
                    style: TypographyApp.nutrNeedsNumFood,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Kalsium',
                    style: TypographyApp.nutrNeedsLabelFood,
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                    child: SizedBox(
                      width: 64.w,
                      child: LinearProgressIndicator(
                        value: food.calcium / nutrition.calcium,
                        minHeight: 7.h,
                        borderRadius: BorderRadius.circular(6.r),
                        backgroundColor: HexColor('#D9D9D9'),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#039ADA')),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
