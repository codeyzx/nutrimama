import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/education/presentation/education_controller.dart';
import 'package:nutrimama/src/features/journal/presentation/journal_controller.dart';
import 'package:nutrimama/src/routes/routes.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'dart:math' as math;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commonState = ref.watch(commonControllerProvider);

    return StatusBarWidget(
      child: Scaffold(
        body: Center(
            child: AsyncValueWidget(
          value: commonState.userValue,
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
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
                                    height: 45.h,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: CircularProgressIndicator(
                                        value: 12 / 40,
                                        strokeWidth: 5,
                                        strokeCap: StrokeCap.round,
                                        backgroundColor: HexColor('#CCD1D6'),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
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
                                          "12/",
                                          style: TypographyApp.homeDateOn,
                                        ),
                                        Text(
                                          "40",
                                          style: TypographyApp.homeDateOff,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Minggu 12",
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
                                border: Border.all(color: HexColor('#CCD1D6'))),
                            child: Center(
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
                  SizedBox(
                    height: 111.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 61.w,
                                height: 84.h,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: HexColor('#0366DA'),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sen',
                                      style: TypographyApp.dayHome,
                                    ),
                                    Text(
                                      '22',
                                      style: TypographyApp.dateHome,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text('Hari Ini', style: TypographyApp.todayHome),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 41.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: ColorApp.primary,
                                    borderRadius: BorderRadius.circular(6.r)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 61.w,
                                height: 84.h,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: HexColor('#F3F3F3'),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sel',
                                      style: TypographyApp.dayOffHome,
                                    ),
                                    Text(
                                      '23',
                                      style: TypographyApp.dateOffHome,
                                    ),
                                  ],
                                ),
                              ),
                              //ini sengaja ada supaya ukuran container atas ga berubah
                              SizedBox(
                                height: 4.h,
                              ),
                              Text('', style: TypographyApp.todayHome),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 41.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: ColorApp.white,
                                    borderRadius: BorderRadius.circular(6.r)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 61.w,
                                height: 84.h,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: HexColor('#F3F3F3'),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rab',
                                      style: TypographyApp.dayOffHome,
                                    ),
                                    Text(
                                      '24',
                                      style: TypographyApp.dateOffHome,
                                    ),
                                  ],
                                ),
                              ),
                              //ini sengaja ada supaya ukuran container atas ga berubah
                              SizedBox(
                                height: 4.h,
                              ),
                              Text('', style: TypographyApp.todayHome),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 41.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: ColorApp.white,
                                    borderRadius: BorderRadius.circular(6.r)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 61.w,
                                height: 84.h,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: HexColor('#F3F3F3'),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sel',
                                      style: TypographyApp.dayOffHome,
                                    ),
                                    Text(
                                      '23',
                                      style: TypographyApp.dateOffHome,
                                    ),
                                  ],
                                ),
                              ),
                              //ini sengaja ada supaya ukuran container atas ga berubah
                              SizedBox(
                                height: 4.h,
                              ),
                              Text('', style: TypographyApp.todayHome),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 41.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: ColorApp.white,
                                    borderRadius: BorderRadius.circular(6.r)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 61.w,
                                height: 84.h,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: HexColor('#F3F3F3'),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sel',
                                      style: TypographyApp.dayOffHome,
                                    ),
                                    Text(
                                      '23',
                                      style: TypographyApp.dateOffHome,
                                    ),
                                  ],
                                ),
                              ),
                              //ini sengaja ada supaya ukuran container atas ga berubah
                              SizedBox(
                                height: 4.h,
                              ),
                              Text('', style: TypographyApp.todayHome),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 41.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: ColorApp.white,
                                    borderRadius: BorderRadius.circular(6.r)),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                width: 61.w,
                                height: 84.h,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: HexColor('#F3F3F3'),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sel',
                                      style: TypographyApp.dayOffHome,
                                    ),
                                    Text(
                                      '23',
                                      style: TypographyApp.dateOffHome,
                                    ),
                                  ],
                                ),
                              ),
                              //ini sengaja ada supaya ukuran container atas ga berubah
                              SizedBox(
                                height: 4.h,
                              ),
                              Text('', style: TypographyApp.todayHome),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                width: 41.w,
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: ColorApp.white,
                                    borderRadius: BorderRadius.circular(6.r)),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
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
                                        offset: Offset(0, 1),
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
                            InkWell(
                              onTap: () {},
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
                                        offset: Offset(0, 1),
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
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        InkWell(
                          onTap: () {
                            ref.read(goRouterProvider).pushNamed(
                              Routes.medicalRecord.name,
                              extra: Extras(
                                datas: {
                                  ExtrasKey.user: data,
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
                                    offset: Offset(0, 1),
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
                                  offset: Offset(0, 1),
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
                                        '1200 Kkal',
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
                                      progress: 800 / 1600,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '800 Kcal',
                                            style: TypographyApp.btnBlackHome,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Text(
                                            'Tersisa',
                                            style: TypographyApp.consumedHome,
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
                                        '2000 Kkal',
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
                                            value: 80 / 140,
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
                                        '80/140g',
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
                                            value: 200 / 310,
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
                                        '200/310g',
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
                                            value: 34 / 140,
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
                                        '34/140g',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  offset: Offset(0, 1),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //ini yang udah minum
                                  Image.asset(
                                    'assets/images/drink_img.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  Image.asset(
                                    'assets/images/drink_img.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  Image.asset(
                                    'assets/images/drink_img.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  //ini yang gelas tambah
                                  SizedBox(
                                    width: 40.w,
                                    height: 40.h,
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
                                              onPressed: () {
                                                print('Clied');
                                              },
                                              icon: Icon(
                                                Icons.add_rounded,
                                                color: HexColor('#001C34'),
                                                size: 20,
                                              )))
                                    ]),
                                  ),
                                  //ini yang belum minum
                                  Image.asset(
                                    'assets/images/drink_not_img.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  Image.asset(
                                    'assets/images/drink_not_img.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  Image.asset(
                                    'assets/images/drink_not_img.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  Image.asset(
                                    'assets/images/drink_not_img.png',
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                ],
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
                                  offset: Offset(0, 1),
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
                                                '270 Kkal',
                                                style: TypographyApp.eatCalHome,
                                              ),
                                              Text(
                                                '/330 Kkal',
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
                                    onPressed: () {},
                                    elevation: 0.0,
                                    fillColor: HexColor('#E5F6FD'),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 30,
                                      color: ColorApp.primary,
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    shape: CircleBorder(),
                                  )
                                ],
                              ),
                              SizedBox(height: 18.h),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.r),
                                          child: Image.network(
                                            'https://asset.kompas.com/crops/st5mFloK5rTZk0Q00L_SWLbjUYs=/0x61:800x594/750x500/data/photo/2022/05/15/6280f7d231bd6.jpg',
                                            width: 64.w,
                                            height: 64.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 18.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Semangkuk Salad', style: TypographyApp.foodNameHome,),
                                            Text('270 Kkal', style: TypographyApp.foodCalHome,)
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
                                  offset: Offset(0, 1),
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
                                                '300 Kkal',
                                                style: TypographyApp.eatCalHome,
                                              ),
                                              Text(
                                                '/330 Kkal',
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
                                    onPressed: () {},
                                    elevation: 0.0,
                                    fillColor: HexColor('#E5F6FD'),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 30,
                                      color: ColorApp.primary,
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    shape: CircleBorder(),
                                  )
                                ],
                              ),
                              SizedBox(height: 18.h,),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 1,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.r),
                                          child: Image.network(
                                            'https://asset.kompas.com/crops/st5mFloK5rTZk0Q00L_SWLbjUYs=/0x61:800x594/750x500/data/photo/2022/05/15/6280f7d231bd6.jpg',
                                            width: 64.w,
                                            height: 64.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 18.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Dada Ayam', style: TypographyApp.foodNameHome,),
                                            Text('300 Kkal', style: TypographyApp.foodCalHome,)
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
                                  offset: Offset(0, 1),
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
                                                '0 Kkal',
                                                style: TypographyApp.eatCalHome,
                                              ),
                                              Text(
                                                '/330 Kkal',
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
                                    onPressed: () {},
                                    elevation: 0.0,
                                    fillColor: HexColor('#E5F6FD'),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 30,
                                      color: ColorApp.primary,
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    shape: CircleBorder(),
                                  )
                                ],
                              ),
                              SizedBox(height: 18.h,),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 0,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.r),
                                          child: Image.network(
                                            'https://asset.kompas.com/crops/st5mFloK5rTZk0Q00L_SWLbjUYs=/0x61:800x594/750x500/data/photo/2022/05/15/6280f7d231bd6.jpg',
                                            width: 64.w,
                                            height: 64.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 18.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Dada Ayam', style: TypographyApp.foodNameHome,),
                                            Text('300 Kkal', style: TypographyApp.foodCalHome,)
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
                        SizedBox(height: 12.h,),
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
                                  offset: Offset(0, 1),
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
                                                '1 Pil',
                                                style: TypographyApp.eatCalHome,
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
                                    onPressed: () {},
                                    elevation: 0.0,
                                    fillColor: HexColor('#E5F6FD'),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 30,
                                      color: ColorApp.primary,
                                    ),
                                    padding: EdgeInsets.all(5.0),
                                    shape: CircleBorder(),
                                  )
                                ],
                              ),
                              SizedBox(height: 18.h,),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 0,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8.r),
                                          child: Image.network(
                                            'https://asset.kompas.com/crops/st5mFloK5rTZk0Q00L_SWLbjUYs=/0x61:800x594/750x500/data/photo/2022/05/15/6280f7d231bd6.jpg',
                                            width: 64.w,
                                            height: 64.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 18.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Dada Ayam', style: TypographyApp.foodNameHome,),
                                            Text('300 Kkal', style: TypographyApp.foodCalHome,)
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
                      ],
                    ),
                  ),
                  Text('Welcome ${data.name}',
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(goRouterProvider).pushNamed(
                            Routes.medicalRecord.name,
                            extra: Extras(
                              datas: {
                                ExtrasKey.user: data,
                              },
                            ),
                          );
                    },
                    child: const Text('Medical Record'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(goRouterProvider)
                          .pushNamed(Routes.searchFood.name);
                    },
                    child: const Text('Search Food'),
                  ),
                ],
              ),);
          },
        )),
      ),
    );
  }
}
