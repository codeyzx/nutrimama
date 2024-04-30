import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/consume_log/presentation/consume_log_controller.dart';
import 'package:nutrimama/src/features/education/presentation/education_controller.dart';
import 'package:nutrimama/src/features/journal/presentation/journal_controller.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_controller.dart';
import 'package:nutrimama/src/features/nutrition/presentation/nutrition_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:quickalert/quickalert.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'dart:math' as math;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commonState = ref.watch(commonControllerProvider);
    final consumeLogState = ref.watch(consumeLogControllerProvider);
    final nutritionState = ref.watch(nutritionControllerProvider);
    final medicalRecordState = ref.watch(medicalRecordControllerProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Center(
          child: AsyncValueWidget(
            value: consumeLogState.todayConsumeLog,
            data: (food) {
              final consume = consumeLogState.todayConsumeLog.asData!.value;
              final user = commonState.userValue.asData!.value;
              final nutrition = nutritionState.nutrition.asData!.value;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap.h36,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AsyncValueWidget(
                            value: medicalRecordState.trimester,
                            loading: (_) => Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Transform.scale(
                                        scale: 1.01,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: 50.w,
                                              height: 42.h,
                                              child: Transform(
                                                alignment: Alignment.center,
                                                transform:
                                                    Matrix4.rotationY(math.pi),
                                                child:
                                                    CircularProgressIndicator(
                                                  value: 1 / 42,
                                                  strokeWidth: 5,
                                                  strokeCap: StrokeCap.round,
                                                  backgroundColor:
                                                      HexColor('#CCD1D6'),
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    HexColor('#0366DA'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                                child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "1/",
                                                    style: TypographyApp
                                                        .homeDateOn,
                                                  ),
                                                  Text(
                                                    "42",
                                                    style: TypographyApp
                                                        .homeDateOff,
                                                  ),
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Minggu 1",
                                              style: TypographyApp.homeTitleOn,
                                            ),
                                            Text(
                                              "Trimester Pertama",
                                              style: TypographyApp.homeTitleOff,
                                            ),
                                          ]),
                                    ],
                                  ),
                                ),
                            data: (trimester) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Transform.scale(
                                      scale: 1.01,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: 50.w,
                                            height: 42.h,
                                            child: Transform(
                                              alignment: Alignment.center,
                                              transform:
                                                  Matrix4.rotationY(math.pi),
                                              child: CircularProgressIndicator(
                                                value: trimester!.week! / 42,
                                                strokeWidth: 5,
                                                strokeCap: StrokeCap.round,
                                                backgroundColor:
                                                    HexColor('#CCD1D6'),
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  HexColor('#0366DA'),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                              child: Center(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${trimester.week}/",
                                                  style:
                                                      TypographyApp.homeDateOn,
                                                ),
                                                Text(
                                                  "42",
                                                  style:
                                                      TypographyApp.homeDateOff,
                                                ),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Minggu ${trimester.week}",
                                            style: TypographyApp.homeTitleOn,
                                          ),
                                          Text(
                                            "Trimester ${trimester.type == 2 ? "Kedua" : trimester.type == 3 ? "Ketiga" : "Pertama"}",
                                            style: TypographyApp.homeTitleOff,
                                          ),
                                        ]),
                                  ],
                                ),
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r),
                                  border:
                                      Border.all(color: HexColor('#CCD1D6'))),
                              child: const Center(
                                child: Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AsyncValueWidget(
                      value: consumeLogState.date,
                      data: (data) => Container(
                        height: 111.h,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: ListView(
                            controller: ScrollController(
                                initialScrollOffset: (8) * (30)),
                            scrollDirection: Axis.horizontal,
                            children: data
                                .map(
                                  (date) => consumeLogState
                                              .selectedDate?.toYyyyMMDd ==
                                          date.toYyyyMMDd
                                      ? GestureDetector(
                                          onTap: () async {
                                            await ref
                                                .read(
                                                    consumeLogControllerProvider
                                                        .notifier)
                                                .getTodayConsumeLog(
                                                    user.id, date.toYyyyMMDd);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                width: 61.w,
                                                height: 75.h,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.h),
                                                decoration: BoxDecoration(
                                                  color: HexColor('#0366DA'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      date.dayNameShort,
                                                      style:
                                                          TypographyApp.dayHome,
                                                    ),
                                                    Text(
                                                      date.day.toString(),
                                                      style: TypographyApp
                                                          .dateHome,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: date.toYyyyMMDd ==
                                                    DateTime.now().toYyyyMMDd,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Text('Hari Ini',
                                                        style: TypographyApp
                                                            .todayHome),
                                                    SizedBox(
                                                      height: 2.h,
                                                    ),
                                                    Container(
                                                      width: 41.w,
                                                      height: 6.h,
                                                      decoration: BoxDecoration(
                                                        color: ColorApp.primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.r),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await ref
                                                .read(
                                                    consumeLogControllerProvider
                                                        .notifier)
                                                .getTodayConsumeLog(
                                                    user.id, date.toYyyyMMDd);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                width: 61.w,
                                                height: 75.h,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16.h),
                                                decoration: BoxDecoration(
                                                  color: HexColor('#F3F3F3'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      date.dayNameShort,
                                                      style: TypographyApp
                                                          .dayOffHome,
                                                    ),
                                                    Text(
                                                      date.day.toString(),
                                                      style: TypographyApp
                                                          .dateOffHome,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //ini sengaja ada supaya ukuran container atas ga berubah
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Text('',
                                                  style:
                                                      TypographyApp.todayHome),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Container(
                                                width: 41.w,
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                    color: ColorApp.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.r)),
                                              ),
                                            ],
                                          ),
                                        ),
                                )
                                .toList()),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await ref
                                      .read(
                                          educationControllerProvider.notifier)
                                      .getVideos();
                                  ref
                                      .read(goRouterProvider)
                                      .pushNamed(Routes.video.name);
                                },
                                child: Container(
                                  width: 181.w,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                        color: HexColor('#CCD1D6'),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.09),
                                          offset: const Offset(0, 1),
                                          blurRadius: 4,
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Image.asset(
                                        'assets/images/girl_img.png',
                                        width: 28.w,
                                        height: 28.h,
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Text(
                                        'Aktivitas',
                                        style: TypographyApp.btnBlackHome,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: InkWell(
                                  onTap: () async {
                                    await ref
                                        .read(
                                            journalControllerProvider.notifier)
                                        .getJournals(user.id);
                                    ref.read(goRouterProvider).pushNamed(
                                        Routes.journal.name,
                                        extra: Extras(
                                            datas: {ExtrasKey.user: user}));
                                  },
                                  child: Container(
                                    width: 181.w,
                                    height: 55.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                        border: Border.all(
                                          color: HexColor('#CCD1D6'),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.09),
                                            offset: const Offset(0, 1),
                                            blurRadius: 4,
                                          )
                                        ]),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        Image.asset(
                                          'assets/images/book_img.png',
                                          width: 29.w,
                                          height: 30.h,
                                        ),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                        Text(
                                          'Jurnal',
                                          style: TypographyApp.btnBlackHome,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          InkWell(
                            onTap: () async {
                              final controller = ref.read(
                                  medicalRecordControllerProvider.notifier);
                              await controller.getFetal(user);
                              await controller.getMother(user);
                              controller.getTrimester(
                                  user.fetalDate ?? DateTime.now());
                              controller.clear();
                              ref.read(goRouterProvider).pushNamed(
                                    Routes.medicalRecord.name,
                                    extra: Extras(
                                      datas: {
                                        ExtrasKey.user: user,
                                      },
                                    ),
                                  );
                            },
                            child: Container(
                              width: 377.w,
                              height: 64.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.r),
                                  border: Border.all(
                                    color: HexColor('#CCD1D6'),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.09),
                                      offset: const Offset(0, 1),
                                      blurRadius: 4,
                                    )
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Image.asset(
                                    'assets/images/medrec_img.png',
                                    width: 29.w,
                                    height: 30.h,
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Text(
                                    'Rekam Medis',
                                    style: TypographyApp.btnBlackHome,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 377.w,
                            height: 295.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 17.w,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: HexColor('#CCD1D6'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/fork_img.png',
                                          width: 26.w,
                                          height: 26.h,
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Text(
                                          '${consume?.totalCalories} Kkal',
                                          style: TypographyApp.btnBlackHome,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          'Terkonsumsi',
                                          style: TypographyApp.consumedHome,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 140.w,
                                      height: 140.h,
                                      child: SemicircularIndicator(
                                        radius: 70.r,
                                        backgroundColor: HexColor('#D9D9D9'),
                                        color: ColorApp.primary,
                                        strokeWidth: 13.w,
                                        progress:
                                            (consume?.totalCalories == null
                                                    ? 0
                                                    : consume!.totalCalories >
                                                            nutrition.calories
                                                        ? nutrition.calories
                                                        : consume.totalCalories
                                                            .toDouble()) /
                                                nutrition.calories,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${nutrition.calories - consume!.totalCalories < 0 ? (nutrition.calories - consume.totalCalories) * -1 : nutrition.calories - consume.totalCalories} Kcal',
                                              style: TypographyApp.btnBlackHome,
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                              nutrition.calories -
                                                          consume
                                                              .totalCalories <
                                                      0
                                                  ? 'Berlebih'
                                                  : 'Tersisa',
                                              style: nutrition.calories -
                                                          consume
                                                              .totalCalories <
                                                      0
                                                  ? TypographyApp.consumedHome
                                                      .copyWith(
                                                      color: ColorApp.red,
                                                    )
                                                  : TypographyApp.consumedHome,
                                            ),
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/target_img.png',
                                          width: 26.w,
                                          height: 26.h,
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Text(
                                          '${nutrition.calories} Kkal',
                                          style: TypographyApp.btnBlackHome,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          'Target',
                                          style: TypographyApp.consumedHome,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.r)),
                                          child: SizedBox(
                                            width: 84.w,
                                            child: LinearProgressIndicator(
                                              value: consume.totalProtein /
                                                  nutrition.protein,
                                              minHeight: 7.h,
                                              backgroundColor:
                                                  HexColor('#D9D9D9'),
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      HexColor('#03DA8D')),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Text(
                                          '${consume.totalProtein}/${nutrition.protein}g',
                                          style: TypographyApp.btnBlackHome,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          'Protein',
                                          style: TypographyApp.consumedHome,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.r)),
                                          child: SizedBox(
                                            width: 84.w,
                                            child: LinearProgressIndicator(
                                              value: consume.totalCarbs /
                                                  nutrition.carbs,
                                              minHeight: 7.h,
                                              backgroundColor:
                                                  HexColor('#D9D9D9'),
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      HexColor('#DA9E03')),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Text(
                                          '${consume.totalCarbs}/${nutrition.carbs}g',
                                          style: TypographyApp.btnBlackHome,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          'Karbohidrat',
                                          style: TypographyApp.consumedHome,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6.r)),
                                          child: SizedBox(
                                            width: 84.w,
                                            child: LinearProgressIndicator(
                                              value: consume.totalFat /
                                                  nutrition.fat,
                                              minHeight: 7.h,
                                              backgroundColor:
                                                  HexColor('#D9D9D9'),
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      HexColor('#7B03DA')),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Text(
                                          '${consume.totalFat}/${nutrition.fat}g',
                                          style: TypographyApp.btnBlackHome,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          'Lemak',
                                          style: TypographyApp.consumedHome,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                Divider(
                                  height: 0.7.h,
                                  color: HexColor('#CCD1D6'),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Lihat Selengkapnya',
                                          style: TypographyApp.primaryOnBtn,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: ColorApp.primary,
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 374.w,
                            height: 104.h,
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: HexColor('#CCD1D6'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  'Air Minum',
                                  style: TypographyApp.titleHome,
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                SizedBox(
                                  height: 40.h,
                                  child: ListView.builder(
                                    itemCount: 8,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final totalDrink = consume.totalDrink;
                                      if (index < totalDrink) {
                                        return Container(
                                          width: 40.w,
                                          height: 40.h,
                                          margin: EdgeInsets.only(right: 3.w),
                                          child: Image.asset(
                                            'assets/images/drink_img.png',
                                          ),
                                        );
                                      } else if (index == totalDrink) {
                                        return Container(
                                          width: 40.w,
                                          height: 40.h,
                                          margin: EdgeInsets.only(right: 3.w),
                                          child: Stack(children: [
                                            Image.asset(
                                              'assets/images/drink_not_img.png',
                                              width: 40.w,
                                              height: 40.h,
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: -6,
                                                child: IconButton(
                                                    onPressed: consumeLogState
                                                                .selectedDate
                                                                ?.toYyyyMMDd !=
                                                            DateTime.now()
                                                                .toYyyyMMDd
                                                        ? () {}
                                                        : () {
                                                            QuickAlert.show(
                                                              context: context,
                                                              type:
                                                                  QuickAlertType
                                                                      .confirm,
                                                              title:
                                                                  "Tambah Air Minum",
                                                              text:
                                                                  "Apakah anda ingin menambah air minum?",
                                                              confirmBtnText:
                                                                  "Ya",
                                                              cancelBtnText:
                                                                  "Tidak",
                                                              onConfirmBtnTap:
                                                                  () {
                                                                ref
                                                                    .read(consumeLogControllerProvider
                                                                        .notifier)
                                                                    .addDrink(
                                                                        user.id,
                                                                        DateTime.now()
                                                                            .toYyyyMMDd);
                                                                context.pop();
                                                              },
                                                            );
                                                          },
                                                    icon: Icon(
                                                      Icons.add_rounded,
                                                      color:
                                                          HexColor('#001C34'),
                                                      size: 20,
                                                    )))
                                          ]),
                                        );
                                      } else {
                                        return Container(
                                          width: 40.w,
                                          height: 40.h,
                                          margin: EdgeInsets.only(right: 3.w),
                                          child: Image.asset(
                                            'assets/images/drink_not_img.png',
                                            width: 40.w,
                                            height: 40.h,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 374.w,
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 0.w,
                              top: 18.h,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: HexColor('#CCD1D6'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sarapan',
                                  style: TypographyApp.titleHome,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/breakfast_img.png',
                                          width: 38.w,
                                          height: 38.h,
                                        ),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${consume.foods.where((element) => element.consumeAt == "breakfast").fold(0, (previousValue, element) => previousValue + element.calories)} Kkal',
                                                  style:
                                                      TypographyApp.eatCalHome,
                                                ),
                                                Text(
                                                  '/${(nutrition.calories * 0.25).toInt()} Kkal',
                                                  style: TypographyApp
                                                      .eatCalTotalHome,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Terkonsumsi',
                                              style:
                                                  TypographyApp.eatCalTotalHome,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    RawMaterialButton(
                                      onPressed: consumeLogState
                                                  .selectedDate?.toYyyyMMDd !=
                                              DateTime.now().toYyyyMMDd
                                          ? () {}
                                          : () {
                                              ref
                                                  .read(goRouterProvider)
                                                  .pushNamed(
                                                      Routes.searchFood.name,
                                                      extra: const Extras(
                                                          datas: {
                                                            ExtrasKey.consumeAt:
                                                                "breakfast"
                                                          }));
                                            },
                                      elevation: 0.0,
                                      fillColor: HexColor('#E5F6FD'),
                                      padding: const EdgeInsets.all(5.0),
                                      shape: const CircleBorder(),
                                      child: Icon(
                                        Icons.add_rounded,
                                        size: 30,
                                        color: ColorApp.primary,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 18.h),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: consume.foods
                                      .where((element) =>
                                          element.consumeAt == "breakfast")
                                      .length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final food = consume.foods
                                        .where((element) =>
                                            element.consumeAt == "breakfast")
                                        .toList()[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            child: Image.network(
                                              food.imageUrl,
                                              width: 72.w,
                                              height: 64.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 18.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                food.name,
                                                style:
                                                    TypographyApp.foodNameHome,
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
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 374.w,
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 0.w,
                              top: 18.h,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: HexColor('#CCD1D6'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Makan Siang',
                                  style: TypographyApp.titleHome,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/lunch_img.png',
                                          width: 38.w,
                                          height: 38.h,
                                        ),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${consume.foods.where((element) => element.consumeAt == "lunch").fold(0, (previousValue, element) => previousValue + element.calories)} Kkal',
                                                  style:
                                                      TypographyApp.eatCalHome,
                                                ),
                                                Text(
                                                  '/${(nutrition.calories * 0.35).toInt()} Kkal',
                                                  style: TypographyApp
                                                      .eatCalTotalHome,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Terkonsumsi',
                                              style:
                                                  TypographyApp.eatCalTotalHome,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    RawMaterialButton(
                                      onPressed: consumeLogState
                                                  .selectedDate?.toYyyyMMDd !=
                                              DateTime.now().toYyyyMMDd
                                          ? () {}
                                          : () {
                                              ref
                                                  .read(goRouterProvider)
                                                  .pushNamed(
                                                      Routes.searchFood.name,
                                                      extra: const Extras(
                                                          datas: {
                                                            ExtrasKey.consumeAt:
                                                                "lunch"
                                                          }));
                                            },
                                      elevation: 0.0,
                                      fillColor: HexColor('#E5F6FD'),
                                      padding: const EdgeInsets.all(5.0),
                                      shape: const CircleBorder(),
                                      child: Icon(
                                        Icons.add_rounded,
                                        size: 30,
                                        color: ColorApp.primary,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: consume.foods
                                      .where((element) =>
                                          element.consumeAt == "lunch")
                                      .length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final food = consume.foods
                                        .where((element) =>
                                            element.consumeAt == "lunch")
                                        .toList()[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            child: Image.network(
                                              food.imageUrl,
                                              width: 72.w,
                                              height: 64.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 18.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                food.name,
                                                style:
                                                    TypographyApp.foodNameHome,
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
                          SizedBox(height: 12.h),
                          Container(
                            width: 374.w,
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 0.w,
                              top: 18.h,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: HexColor('#CCD1D6'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Makan Malam',
                                  style: TypographyApp.titleHome,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/dinner_img.png',
                                          width: 38.w,
                                          height: 38.h,
                                        ),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${consume.foods.where((element) => element.consumeAt == "dinner").fold(0, (previousValue, element) => previousValue + element.calories)} Kkal',
                                                  style:
                                                      TypographyApp.eatCalHome,
                                                ),
                                                Text(
                                                  '/${(nutrition.calories * 0.4).toInt()} Kkal',
                                                  style: TypographyApp
                                                      .eatCalTotalHome,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Terkonsumsi',
                                              style:
                                                  TypographyApp.eatCalTotalHome,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    RawMaterialButton(
                                      onPressed: consumeLogState
                                                  .selectedDate?.toYyyyMMDd !=
                                              DateTime.now().toYyyyMMDd
                                          ? () {}
                                          : () {
                                              ref
                                                  .read(goRouterProvider)
                                                  .pushNamed(
                                                      Routes.searchFood.name,
                                                      extra: const Extras(
                                                          datas: {
                                                            ExtrasKey.consumeAt:
                                                                "dinner"
                                                          }));
                                            },
                                      elevation: 0.0,
                                      fillColor: HexColor('#E5F6FD'),
                                      padding: const EdgeInsets.all(5.0),
                                      shape: const CircleBorder(),
                                      child: Icon(
                                        Icons.add_rounded,
                                        size: 30,
                                        color: ColorApp.primary,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: consume.foods
                                      .where((element) =>
                                          element.consumeAt == "dinner")
                                      .length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final food = consume.foods
                                        .where((element) =>
                                            element.consumeAt == "dinner")
                                        .toList()[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            child: Image.network(
                                              food.imageUrl,
                                              width: 72.w,
                                              height: 64.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 18.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                food.name,
                                                style:
                                                    TypographyApp.foodNameHome,
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
                          SizedBox(
                            height: 12.h,
                          ),
                          Container(
                            width: 374.w,
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 0.w,
                              top: 18.h,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: HexColor('#CCD1D6'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.09),
                                    offset: const Offset(0, 1),
                                    blurRadius: 4,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vitamin',
                                  style: TypographyApp.titleHome,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/vitamin_img.png',
                                          width: 38.w,
                                          height: 38.h,
                                        ),
                                        SizedBox(
                                          width: 26.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${consume.totalVitamin} Pil',
                                                  style:
                                                      TypographyApp.eatCalHome,
                                                ),
                                                Text(
                                                  '/1 Pil',
                                                  style: TypographyApp
                                                      .eatCalTotalHome,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Terkonsumsi',
                                              style:
                                                  TypographyApp.eatCalTotalHome,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    RawMaterialButton(
                                      onPressed: consumeLogState
                                                  .selectedDate?.toYyyyMMDd !=
                                              DateTime.now().toYyyyMMDd
                                          ? () {}
                                          : () {
                                              QuickAlert.show(
                                                context: context,
                                                type: QuickAlertType.confirm,
                                                title: "Tambah Vitamin",
                                                text:
                                                    'Apakah anda ingin menambah vitamin?',
                                                confirmBtnText: "Ya",
                                                cancelBtnText: "Tidak",
                                                onConfirmBtnTap: () {
                                                  ref
                                                      .read(
                                                          consumeLogControllerProvider
                                                              .notifier)
                                                      .addVitamin(
                                                          user.id,
                                                          DateTime.now()
                                                              .toYyyyMMDd);
                                                  context.pop();
                                                },
                                              );
                                            },
                                      elevation: 0.0,
                                      fillColor: HexColor('#E5F6FD'),
                                      padding: const EdgeInsets.all(5.0),
                                      shape: const CircleBorder(),
                                      child: Icon(
                                        Icons.add_rounded,
                                        size: 30,
                                        color: ColorApp.primary,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap.h32,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
