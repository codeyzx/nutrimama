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

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#3692FF'),
      appBar: AppBar(
        title: Text(
          'Sarapan',
          style: TypographyApp.appBarFood,
        ),
        centerTitle: true,
        backgroundColor: HexColor('#3692FF'),
        leadingWidth: 78.w,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          iconSize: 20,
          padding: EdgeInsets.all(8.0),
          color: Colors.white,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(8),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                            '270/330 Kkal',
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
                            value: 270 / 330,
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
                                '80/140g',
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
                                    value: 80 / 140,
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
                                '200/310g',
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
                                    value: 200 / 310,
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
                                '34/140g',
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
                                    value: 34 / 140,
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
                                '80/140g',
                                style: TypographyApp.nutrNeedsNumFood,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                'Folat',
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
                                    value: 80 / 140,
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
                                '200/310g',
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
                                    value: 200 / 310,
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
                                '34/140g',
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
                                    value: 34 / 140,
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
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 380.h,
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
                    SizedBox(
                      height: 12.h,
                    ),
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
                              elevation: 0
                            ),
                              onPressed: () {

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.search_rounded, color: HexColor('#8E9195'),),
                                      SizedBox(width: 8.w,),
                                      Text('Cari Makanan Minuman', style: TypographyApp.searchBtnFood,)
                                    ],
                                  ),
                                  Image.asset('assets/images/filter_img.png', width: 23.w, height: 23.h,),
                                ],
                              ),),),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.h,),
                            Text('Makanan Ditambahkan', style: TypographyApp.listLabelFood,),
                            SizedBox(height: 12.h,),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                        child: Image.network(
                                          'https://cdn1-production-images-kly.akamaized.net/UdGxQFOr-QQtc5wFZcl9mvZcfwM=/800x450/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3390091/original/047746000_1614610130-Croatian_Salad.jpg',
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
                                            'Semangkuk Salad',
                                            style:
                                            TypographyApp.foodNameHome,
                                          ),
                                          Text(
                                            '270 Kkal',
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
                            Text('Rekomendasi Makanan', style: TypographyApp.listLabelFood,),
                            SizedBox(height: 12.h,),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                        child: Image.network(
                                          'https://cdn1-production-images-kly.akamaized.net/UdGxQFOr-QQtc5wFZcl9mvZcfwM=/800x450/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3390091/original/047746000_1614610130-Croatian_Salad.jpg',
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
                                            'Semangkuk Salad',
                                            style:
                                            TypographyApp.foodNameHome,
                                          ),
                                          Text(
                                            '270 Kkal',
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
