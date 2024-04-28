import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/constants/constants.dart';

class TypographyApp {
  static TextStyle headline1 = TextStyle(
    fontSize: ScreenUtil().setSp(26),
    fontWeight: FontWeight.w700,
    color: ColorApp.black,
  );

  static TextStyle headline2 = TextStyle(
    fontSize: ScreenUtil().setSp(22),
    fontWeight: FontWeight.w700,
    color: ColorApp.black,
  );

  static TextStyle headline3 = TextStyle(
    fontSize: ScreenUtil().setSp(15),
    fontWeight: FontWeight.w600,
    color: ColorApp.black,
  );

  static TextStyle text1 = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w500,
    color: ColorApp.black,
  );

  static TextStyle text2 = TextStyle(
    fontSize: ScreenUtil().setSp(14),
    fontWeight: FontWeight.w400,
    color: ColorApp.black,
  );

  static TextStyle subText1 = TextStyle(
    fontSize: ScreenUtil().setSp(12),
    fontWeight: FontWeight.w300,
    color: ColorApp.black,
  );

  static TextStyle splashLogoName = TextStyle(
    color: ColorApp.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 24.sp,
  );

  static TextStyle splashBy = TextStyle(
      color: ColorApp.splash,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      letterSpacing: 0.6.sp);

  static TextStyle splashTeamName = TextStyle(
      color: ColorApp.primary,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      letterSpacing: 0.48.sp);

  static TextStyle onBoardTitle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );

  static TextStyle onBoardSubTitle = TextStyle(
    color: Colors.black.withOpacity(0.80),
    fontWeight: FontWeight.w300,
    fontSize: 14.sp,
  );

  static TextStyle onBoardBtnText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle onBoardUnBtnText = TextStyle(
    color: ColorApp.primary,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle loginAppName = TextStyle(
    color: ColorApp.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
  );

  static TextStyle loginTitle = TextStyle(
    color: ColorApp.black,
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
  );

  static TextStyle loginBtn = TextStyle(
    color: ColorApp.white,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle loginOffInput = TextStyle(
    color: HexColor('#9D9D9D'),
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle loginOnInput = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle loginForgot = TextStyle(
    color: ColorApp.primary,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle whiteOnBtnSmall = TextStyle(
    fontSize: 13.sp,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  static TextStyle homeDetName = TextStyle(
    color: ColorApp.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );

  static TextStyle profileJob = TextStyle(
    color: ColorApp.primary,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  static TextStyle profileItemTitle = TextStyle(
    color: Colors.black.withOpacity(0.70),
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );
  static TextStyle profileItem = TextStyle(
    color: HexColor('#231F20'),
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  static TextStyle homeAppbarSmall = TextStyle(
    color: ColorApp.secondary,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
  static TextStyle eprofileBlueBtn = TextStyle(
    color: ColorApp.blue,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  static TextStyle eprofileLabel = TextStyle(
    color: ColorApp.black,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  static TextStyle eprofileValue = TextStyle(
    color: HexColor('231F20'),
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );

  static TextStyle homeOnBtn = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle homeDateOn = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontSize: 12.sp,
  );

  static TextStyle homeDateOff = TextStyle(
    color: HexColor('#B0B0B0'),
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
  );

  static TextStyle homeTitleOn = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w800,
    fontSize: 18.sp,
  );

  static TextStyle homeTitleOff = TextStyle(
    color: HexColor('#B0B0B0'),
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
  );

  static TextStyle dayHome = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
  );

  static TextStyle dateHome = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
  );

  static TextStyle todayHome= TextStyle(
    color: ColorApp.primary,
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
  );

  static TextStyle dayOffHome = TextStyle(
    color: HexColor('#393939'),
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
  );

  static TextStyle dateOffHome = TextStyle(
    color:  HexColor('#393939'),
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
  );

  static TextStyle btnBlackHome = TextStyle(
    color:  HexColor('#001C34'),
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle consumedHome = TextStyle(
    color:  HexColor('#B0B0B0'),
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
  );

  static TextStyle primaryOnBtn = TextStyle(
    color:  ColorApp.primary,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );

  static TextStyle titleHome = TextStyle(
    color:  HexColor('#001C34'),
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );

  static TextStyle eatCalHome = TextStyle(
    color:  HexColor('#000000'),
    fontWeight: FontWeight.w700,
    fontSize: 20.sp,
  );
  static TextStyle eatCalTotalHome = TextStyle(
    color:  HexColor('#B0B0B0'),
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );

  static TextStyle foodNameHome = TextStyle(
    color:  HexColor('#000000'),
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle foodCalHome = TextStyle(
    color:  HexColor('#8E8E8E'),
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
  );

  static TextStyle trisMedrec = TextStyle(
    color:  ColorApp.primary,
    fontWeight: FontWeight.w600,
    fontSize: 13.sp,
  );

  static TextStyle trisDescMedrec = TextStyle(
    color:  HexColor('#001C34'),
    fontWeight: FontWeight.w400,
    fontSize: 13.sp,
  );

  static TextStyle tipsMedrec = TextStyle(
    color:  ColorApp.primary,
    fontWeight: FontWeight.w600,
    fontSize: 13.sp,
  );

  static TextStyle dataTitleMedrec = TextStyle(
    color:  ColorApp.primary,
    fontWeight: FontWeight.w700,
    fontSize: 15.sp,
  );

  static TextStyle weightNumMedrec = TextStyle(
    color:  ColorApp.black,
    fontWeight: FontWeight.w600,
    fontSize: 24.sp,
  );

  static TextStyle weightKgMedrec = TextStyle(
    color:  ColorApp.black,
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static TextStyle weightSubtitleMedrec = TextStyle(
    color:  HexColor('#8E8E8E'),
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
  );

  static TextStyle bloodNumMedrec = TextStyle(
    color:  HexColor('#000000'),
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );

  static TextStyle bloodNumUnitMedrec = TextStyle(
    color:  HexColor('#000000'),
    fontWeight: FontWeight.w600,
    fontSize: 10.sp,
  );

  static TextStyle dataDateMedrec = TextStyle(
    color:  ColorApp.primary,
    fontWeight: FontWeight.w600,
    fontSize: 13.sp,
  );

  static TextStyle babyWeightMedrec = TextStyle(
    color:  ColorApp.black,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );

  static TextStyle babyWeightUnitMedrec = TextStyle(
    color:  ColorApp.black,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );

  static TextStyle babySubtitleMedrec = TextStyle(
    color: HexColor('#8E8E8E'),
    fontWeight: FontWeight.w500,
    fontSize: 10.sp,
  );

  static TextStyle addMomDataMedrec = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
}
