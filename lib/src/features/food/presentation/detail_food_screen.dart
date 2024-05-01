import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/constants/themes/themes.dart';
import 'package:nutrimama/src/constants/themes/typography_app.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/consume_log/domain/consume_food.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/food/domain/food.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';

class DetailFoodScreen extends ConsumerWidget {
  final Food food;
  final String consumeAt;
  const DetailFoodScreen(
      {super.key, required this.food, required this.consumeAt});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isNutrisiActive = true;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detail Makanan', style: TypographyApp.appBarFoodSearch),
        centerTitle: true,
        leadingWidth: 78.w,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          iconSize: 20,
          padding: EdgeInsets.all(8.0),
          color: Colors.black,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(color: HexColor('#CCD1D6'), width: 0.3.w),
            ),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(8),
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
                          image: const DecorationImage(
                            image:
                                AssetImage('assets/images/question_img_2.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.r)),
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
              // btn tambahkan sarapan
              SizedBox(
                width: 377.w,
                child: ElevatedButton(
                    onPressed: () {
                      final uid =
                          ref.read(commonControllerProvider.notifier).getUid();
                      ConsumeFood consumeFood =
                          ConsumeFood.fromFood(food, consumeAt);
                      ref
                          .read(consumeLogControllerProvider.notifier)
                          .addConsumeFood(
                              uid, DateTime.now().toYyyyMMDd, consumeFood);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      backgroundColor: ColorApp.primary,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                    ),
                    child: Text(
                      'Tambahkan Sarapan',
                      style: TypographyApp.addOnBtnDetail,
                    )),
              ),
              // InkWell(
              //   onTap: () {
              //     final uid =
              //         ref.read(commonControllerProvider.notifier).getUid();
              //     ConsumeFood consumeFood =
              //         ConsumeFood.fromFood(food, consumeAt);
              //     ref
              //         .read(consumeLogControllerProvider.notifier)
              //         .addConsumeFood(
              //             uid, DateTime.now().toYyyyMMDd, consumeFood);
              // final consumeLogs = ref
              //         .read(consumeLogControllerProvider)
              //         .consumeLogs
              //         .asData
              //         ?.value ??
              //     [];
              // final todayConsumeLog = ref
              //     .read(consumeLogControllerProvider)
              //     .todayConsumeLog
              //     .asData
              //     ?.value;
              // final todayConsumeFoods = ref
              //         .read(consumeLogControllerProvider)
              //         .consumeFoods
              //         .asData
              //         ?.value ??
              //     [];
              // Logger().i(consumeLogs);
              // Logger().i(todayConsumeLog);
              // Logger().i(todayConsumeFoods);
              //   },
              //   child: Container(
              //     height: 50,
              //     margin: const EdgeInsets.symmetric(horizontal: 20),
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: const Center(
              //       child: Text(
              //         "Tambahkan Sarapan",
              //         style: TextStyle(color: Colors.white, fontSize: 16),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 32.h),
              // switching container, it can switch to Nutrisi or Panduan, switch can by swipe the container
              Container(
                width: 378.w,
                height: 42.h,
                padding: EdgeInsets.all(4),
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
                        onPressed: () {
                          // setState(() {
                          //   // Ketika Nutrisi diklik, set nutrisi sebagai aktif
                          //   isNutrisiActive = true;
                          // });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          backgroundColor: ColorApp.white,
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          elevation: 0,
                        ),
                        child: Text('Nutrisi', style: TypographyApp.switchOnBtnDetail,),
                      ),
                    ),
                    SizedBox(
                      width: 183.w,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          backgroundColor: HexColor('#E7E7E7'),
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          elevation: 0,
                        ),
                        child: Text('Panduan', style: TypographyApp.switchOffBtnDetail,),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
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
                      offset: Offset(0, 1)
                    ),
                  ]
                ),
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
                          '${food.calories}/330 Kkal',
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
                          value: food.calories/300,
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
                              '${food.calories}/140g',
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
                                width: 64.w,
                                child: LinearProgressIndicator(
                                  value: food.protein/140,
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
                              '${food.carbs}/140g',
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
                                width: 64.w,
                                child: LinearProgressIndicator(
                                  value: food.carbs/310,
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
                              '${food.fat}/140g',
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
                                width: 64.w,
                                child: LinearProgressIndicator(
                                  value: food.fat/140,
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
                              '${food.sugars}/140g',
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
                                width: 64.w,
                                child: LinearProgressIndicator(
                                  value: food.fat/140,
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
                              '${food.iron}/140g',
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
                                width: 64.w,
                                child: LinearProgressIndicator(
                                  value: food.iron/310,
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
                              '${food.calcium}/140g',
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
                                width: 64.w,
                                child: LinearProgressIndicator(
                                  value: food.calcium/140,
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
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   margin: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey),
              //       borderRadius: BorderRadius.circular(5)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         "Nutrisi",
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //       ),
              //       const SizedBox(height: 10),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text("Kalori"),
              //           Text(
              //             "${food.calories}/2000kcal",
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 5),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text("Protein"),
              //           Text(
              //             "${food.protein}/50g",
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 5),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text("Karbohidrat"),
              //           Text(
              //             "${food.carbs}/300g",
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 5),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text("Lemak"),
              //           Text(
              //             "${food.fat}/70g",
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 5),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text("Gula"),
              //           Text(
              //             "${food.sugars}/50g",
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 5),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text("Zat Besi"),
              //           Text(
              //             "${food.iron}/18mg",
              //           ),
              //         ],
              //       ),
              //       const SizedBox(height: 5),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           const Text("Kalsium"),
              //           Text(
              //             "${food.calcium}/1000mg",
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Gap.h20,
              //bagian panduan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bahan-Bahan', style: TypographyApp.panduanTitleDetail,),
                  SizedBox(height: 12.h,),
                  food.ingredients.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: food.ingredients
                        .map((ingredient) => Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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
                  Text(
                    "Instruksi",
                    style: TypographyApp.panduanTitleDetail
                  ),
                  SizedBox(height: 12.h),
                  food.instructions.isNotEmpty
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: food.instructions
                        .map((instruction) => Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
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
              ),
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsets.all(10),
              //   margin: const EdgeInsets.symmetric(horizontal: 20),
              //   decoration: BoxDecoration(
              //       border: Border.all(color: Colors.grey),
              //       borderRadius: BorderRadius.circular(5)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       const Text(
              //         "Bahan-bahan",
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //       ),
              //       const SizedBox(height: 10),
              //       food.ingredients.isNotEmpty
              //           ? Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: food.ingredients
              //                   .map((ingredient) => Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.spaceBetween,
              //                         children: [
              //                           // ingredient has name and amount
              //                           Text(
              //                             ingredient.name,
              //                             style: const TextStyle(fontSize: 14),
              //                           ),
              //                           const SizedBox(height: 5),
              //                           Text(
              //                             ingredient.total,
              //                             style: const TextStyle(fontSize: 14),
              //                           ),
              //                         ],
              //                       ))
              //                   .toList(),
              //             )
              //           : const Text(
              //               "Tidak ada bahan",
              //               style: TextStyle(fontSize: 16),
              //             ),
              //       const SizedBox(height: 10),
              //       const Text(
              //         "Panduan",
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //       ),
              //       const SizedBox(height: 10),
              //       food.instructions.isNotEmpty
              //           ? Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: food.instructions
              //                   .map((instruction) => Padding(
              //                         padding: const EdgeInsets.only(bottom: 8),
              //                         child: Column(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             // instruction has title and description
              //                             Text(
              //                               instruction.title,
              //                               style:
              //                                   const TextStyle(fontSize: 14),
              //                             ),
              //                             const SizedBox(height: 5),
              //                             Text(
              //                               instruction.description,
              //                               style:
              //                                   const TextStyle(fontSize: 14),
              //                             ),
              //                           ],
              //                         ),
              //                       ))
              //                   .toList(),
              //             )
              //           : const Text(
              //               "Tidak ada panduan",
              //               style: TextStyle(fontSize: 16),
              //             ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
