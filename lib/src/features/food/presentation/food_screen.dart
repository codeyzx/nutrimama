import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/features/food/presentation/food_controller.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';

class FoodScreen extends ConsumerWidget {
  final String consumeAt;
  const FoodScreen({super.key, required this.consumeAt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nutritionState = ref.watch(nutritionControllerProvider);
    final consumeLogState = ref.watch(consumeLogControllerProvider);
    final nutrition = nutritionState.nutrition.asData!.value;
    final consume = consumeLogState.todayConsumeLog.asData!.value;
    final foodState = ref.watch(foodControllerProvider);

    return StatusBarWidget(
      child: Scaffold(
        backgroundColor: HexColor('#3692FF'),
        appBar: AppBar(
            title: Text(
              consumeAt == 'lunch'
                  ? 'Makan Siang'
                  : consumeAt == 'dinner'
                      ? 'Makan Malam'
                      : 'Sarapan',
              style: TypographyApp.appBarFood,
            ),
            centerTitle: true,
            backgroundColor: HexColor('#3692FF'),
            leading: Container(
              margin: const EdgeInsets.only(
                left: 16,
                top: 10,
                bottom: 10,
                right: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () {
                  context.pop();
                },
              ),
            )),
        body: Stack(
          alignment: Alignment.center,
          children:[
            Positioned(
              top: 10,
              child: Container(
                width: 377.w,
                height: 222.h,
                padding: EdgeInsets.only(top: 16.h, left: 9.w, right: 9.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Kebutuhan Kalori',
                          style: TypographyApp.calorieNeedsFood,
                        ),
                        Text(
                          '${consume?.totalCalories}/${nutrition.calories} Kkal',
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
                          value: consume?.totalCalories.toDouble() ??
                              0.0 / nutrition.calories,
                          minHeight: 8.h,
                          borderRadius: BorderRadius.circular(6.r),
                          backgroundColor: HexColor('#D9D9D9'),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              HexColor('#0366DA')),
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
                              '${consume?.totalProtein}/${nutrition.protein}g',
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.r)),
                              child: SizedBox(
                                width: 84.w,
                                child: LinearProgressIndicator(
                                  value: consume?.totalProtein.toDouble() ??
                                      0.0 / nutrition.protein,
                                  minHeight: 7.h,
                                  borderRadius: BorderRadius.circular(6.r),
                                  backgroundColor: HexColor('#D9D9D9'),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      HexColor('#03DA8D')),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${consume?.totalCarbs}/${nutrition.carbs}g',
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.r)),
                              child: SizedBox(
                                width: 84.w,
                                child: LinearProgressIndicator(
                                  value: consume?.totalCarbs.toDouble() ??
                                      0.0 / nutrition.carbs,
                                  minHeight: 7.h,
                                  borderRadius: BorderRadius.circular(6.r),
                                  backgroundColor: HexColor('#D9D9D9'),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      HexColor('#DA9E03')),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${consume?.totalFat}/${nutrition.fat}g',
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.r)),
                              child: SizedBox(
                                width: 84.w,
                                child: LinearProgressIndicator(
                                  value: consume?.totalFat.toDouble() ??
                                      0.0 / nutrition.fat,
                                  minHeight: 7.h,
                                  borderRadius: BorderRadius.circular(6.r),
                                  backgroundColor: HexColor('#D9D9D9'),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      HexColor('#7B03DA')),
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
                              '${consume?.totalSugars}/${nutrition.sugars}g',
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.r)),
                              child: SizedBox(
                                width: 84.w,
                                child: LinearProgressIndicator(
                                  value: consume?.totalSugars.toDouble() ??
                                      0.0 / nutrition.sugars,
                                  minHeight: 7.h,
                                  borderRadius: BorderRadius.circular(6.r),
                                  backgroundColor: HexColor('#D9D9D9'),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      HexColor('#6EDA03')),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${consume?.totalIron}/${nutrition.iron}g',
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.r)),
                              child: SizedBox(
                                width: 84.w,
                                child: LinearProgressIndicator(
                                  value: consume?.totalIron.toDouble() ??
                                      0.0 / nutrition.iron,
                                  minHeight: 7.h,
                                  borderRadius: BorderRadius.circular(6.r),
                                  backgroundColor: HexColor('#D9D9D9'),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      HexColor('#DA3603')),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${consume?.totalCalcium}/${nutrition.calcium}g',
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
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.r)),
                              child: SizedBox(
                                width: 84.w,
                                child: LinearProgressIndicator(
                                  value: consume?.totalCalcium.toDouble() ??
                                      0.0 / nutrition.calcium,
                                  minHeight: 7.h,
                                  borderRadius: BorderRadius.circular(6.r),
                                  backgroundColor: HexColor('#D9D9D9'),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      HexColor('#039ADA')),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 1.sw,
                height: 380.h,
                padding: EdgeInsets.only(top: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap.h4,
                      Center(
                        child: Container(
                          width: 103.w,
                          height: 6.h,
                          decoration: BoxDecoration(
                            color: HexColor('#CCD1D6'),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: SizedBox(
                          width: 378.w,
                          height: 47.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('#F2F2F2'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 0),
                            onPressed: () {
                              ref.read(goRouterProvider).pushNamed(
                                  Routes.searchFood.name,
                                  extra: Extras(
                                      datas: {ExtrasKey.consumeAt: consumeAt}));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_rounded,
                                      color: HexColor('#8E9195'),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      'Cari Makanan Minuman',
                                      style: TypographyApp.searchBtnFood,
                                    )
                                  ],
                                ),
                                Image.asset(
                                  'assets/images/filter_img.png',
                                  width: 23.w,
                                  height: 23.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 24.h,
                            ),
                            Visibility(
                              visible: consume?.foods.where(
                                      (element) => element.type == "food") !=
                                  null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Makanan Ditambahkan',
                                    style: TypographyApp.listLabelFood,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: consume?.foods.where((element) =>
                                                element.type == "food") !=
                                            null
                                        ? consume!.foods
                                                    .where((element) =>
                                                        element.type == "food")
                                                    .length >
                                                3
                                            ? 3
                                            : consume.foods
                                                .where((element) =>
                                                    element.type == "food")
                                                .length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      final food = consume!.foods
                                          .where((element) =>
                                              element.type == "food")
                                          .toList()[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: CachedNetworkImage(
                                                imageUrl: food.imageUrl,
                                                width: 64.w,
                                                height: 56.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  food.name,
                                                  style: TypographyApp
                                                      .foodNameHome,
                                                ),
                                                Text(
                                                  '${food.calories} Kkal',
                                                  style:
                                                      TypographyApp.foodCalHome,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: consume?.foods.where(
                                      (element) => element.type == "drink") !=
                                  null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Minuman Ditambahkan',
                                    style: TypographyApp.listLabelFood,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: consume?.foods.where((element) =>
                                                element.type == "drink") !=
                                            null
                                        ? consume!.foods
                                                    .where((element) =>
                                                        element.type == "drink")
                                                    .length >
                                                3
                                            ? 3
                                            : consume.foods
                                                .where((element) =>
                                                    element.type == "drink")
                                                .length
                                        : 0,
                                    itemBuilder: (context, index) {
                                      final food = consume!.foods
                                          .where((element) =>
                                              element.type == "drink")
                                          .toList()[index];
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 20.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: CachedNetworkImage(
                                                imageUrl: food.imageUrl,
                                                width: 64.w,
                                                height: 56.h,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  food.name,
                                                  style: TypographyApp
                                                      .foodNameHome,
                                                ),
                                                Text(
                                                  '${food.calories} Kkal',
                                                  style:
                                                      TypographyApp.foodCalHome,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Rekomendasi',
                              style: TypographyApp.listLabelFood,
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  foodState.foods.asData?.value?.length != null
                                      ? 4
                                      : 0,
                              itemBuilder: (context, index) {
                                List<Food> foodType = foodState
                                    .foods.asData!.value!
                                    .where((element) => element.type == "food")
                                    .toList()
                                    .sublist(0, 2);
                                List<Food> drinkType = foodState
                                    .foods.asData!.value!
                                    .where((element) => element.type == "drink")
                                    .toList()
                                    .sublist(0, 2);
                                List<Food> foodAndDrink = [];
                                for (int i = 0; i < 2; i++) {
                                  foodAndDrink.add(foodType[i]);
                                  foodAndDrink.add(drinkType[i]);
                                }
                                final food = foodAndDrink[index];

                                return InkWell(
                                  onTap: () {
                                    ref.read(goRouterProvider).pushNamed(
                                          Routes.detailFood.name,
                                          extra: Extras(
                                            datas: {
                                              ExtrasKey.food: food,
                                              ExtrasKey.consumeAt: consumeAt,
                                            },
                                          ),
                                        );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 20.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: CachedNetworkImage(
                                            imageUrl: food.imageUrl,
                                            width: 64.w,
                                            height: 56.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 14.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              food.name,
                                              style: TypographyApp.foodNameHome,
                                            ),
                                            Text(
                                              '${food.calories} Kkal',
                                              style: TypographyApp.foodCalHome,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
