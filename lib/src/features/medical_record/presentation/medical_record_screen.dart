import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/common_widgets/async_value/async_value_widget.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/auth/domain/user.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/medical_record/domain/fetal.dart';
import 'package:nutrimama/src/features/medical_record/presentation/medical_record_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';
import 'package:quickalert/quickalert.dart';

class MedicalRecordScreen extends ConsumerWidget {
  final User user;
  const MedicalRecordScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(medicalRecordControllerProvider);
    final controller = ref.read(medicalRecordControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Medikal Record',
            style: TypographyApp.appBarMedrec,
          ),
          leading: Container(
            margin: const EdgeInsets.only(
              left: 16,
              top: 10,
              bottom: 10,
              right: 2,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: .5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          margin: EdgeInsets.only(
            bottom: 72.h,
            top: 12.h,
          ),
          child: Column(
            children: [
              AsyncValueWidget(
                value: state.trimester,
                data: (trimester) => Visibility(
                  visible: trimester?.week != 0,
                  child: Container(
                    width: 374.w,
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                        color: ColorApp.primary.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: HexColor('#0366DA'))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trimester ${state.trimester.asData?.value?.type}: Minggu ${state.trimester.asData?.value?.week}',
                          style: TypographyApp.trisMedrec,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/baby_img.png',
                                width: 86.w,
                                height: 86.h,
                              ),
                              SizedBox(
                                  width: 258.w,
                                  child: Text(
                                    '${trimester?.desc}',
                                    style: TypographyApp.trisDescMedrec,
                                    textAlign: TextAlign.justify,
                                  )),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
              AsyncValueWidget(
                value: state.trimester,
                data: (trimester) => Visibility(
                  visible: trimester?.week != 0,
                  child: Container(
                    width: 374.w,
                    margin: EdgeInsets.only(bottom: 26.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                    decoration: BoxDecoration(
                        color: ColorApp.primary.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: HexColor('#0366DA'))),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/lamp_img.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(
                            width: 6.w,
                          ),
                          SizedBox(
                              width: 300.w,
                              child: Text(
                                'Trimester ${trimester?.type}: ${trimester?.tips}',
                                style: TypographyApp.tipsMedrec,
                                textAlign: TextAlign.justify,
                              )),
                        ]),
                  ),
                ),
              ),
              AsyncValueWidget(
                value: state.mother,
                data: (data) => data.isNull()
                    ? Container(
                        width: 374.w,
                        height: 192.h,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: HexColor('#CCD1D6'),
                              width: 0.3.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.09),
                                offset: const Offset(0, 1),
                                blurRadius: 4,
                              )
                            ]),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Data ibu belum ada',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 10.0),
                              ElevatedButton(
                                onPressed: () {
                                  ref.read(goRouterProvider).pushNamed(
                                        Routes.addMotherRecord.name,
                                        extra: Extras(
                                          datas: {
                                            ExtrasKey.user: user,
                                          },
                                        ),
                                      );
                                },
                                child: const Text('Tambahkan Data Ibu'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          ref
                              .read(goRouterProvider)
                              .pushNamed(Routes.motherRecord.name,
                                  extra: Extras(datas: {
                                    ExtrasKey.mothers:
                                        state.mothers.asData?.value ?? [],
                                    ExtrasKey.mother: data,
                                  }));
                        },
                        child: Container(
                          width: 374.w,
                          height: 192.h,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: HexColor('#CCD1D6'),
                                width: 0.3.w,
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
                                'Data Ibu',
                                style: TypographyApp.dataTitleMedrec,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 48.w,
                                      height: 48.w,
                                      decoration: BoxDecoration(
                                        color:
                                            ColorApp.primary.withOpacity(0.20),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Center(
                                          child: Image.asset(
                                        'assets/images/mom_img.png',
                                        width: 32.w,
                                        height: 32.h,
                                      )),
                                    ),
                                    SizedBox(
                                      width: 16.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 280.w,
                                          height: 102.h,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 22.w, vertical: 13.h),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6.r),
                                            border: Border.all(
                                              color: HexColor('#CCD1D6'),
                                              width: 0.3.w,
                                            ),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text: data?.weight
                                                              .toString()
                                                              .replaceAll(
                                                                  RegExp(
                                                                      r'\.0'),
                                                                  '') ??
                                                          '-',
                                                      style: TypographyApp
                                                          .weightNumMedrec,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: ' Kg',
                                                          style: TypographyApp
                                                              .weightKgMedrec,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Berat Badan',
                                                    style: TypographyApp
                                                        .weightSubtitleMedrec,
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                width: 14
                                                    .w, // Jarak total termasuk ketebalan garis
                                                thickness:
                                                    0.3.w, // Ketebalan garis
                                                color: HexColor(
                                                    '#CCD1D6'), // Warna garis
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      text:
                                                          '${data?.bloodPressure}',
                                                      style: TypographyApp
                                                          .bloodNumMedrec,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text: ' (mm/hg)',
                                                          style: TypographyApp
                                                              .bloodNumUnitMedrec,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Tekanan Darah',
                                                    style: TypographyApp
                                                        .weightSubtitleMedrec,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                        Text(
                                          data!.date.dateMonthYear,
                                          style: TypographyApp.dataDateMedrec,
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                error: (errorWidget) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Gagal memuat data ibu',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          controller.getMother(user);
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 19.h,
              ),
              if (user.fetalId.isEmpty &&
                  state.allFetals.asData?.value?.isNotEmpty == true)
                Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: .3.w,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    margin: EdgeInsets.only(
                      bottom: 20.h,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 40.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ingin menambahkan data janin lagi?',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(goRouterProvider).pushNamed(
                                  Routes.addFetalRecord.name,
                                  extra: Extras(
                                    datas: {
                                      ExtrasKey.user: user,
                                      ExtrasKey.isNewFetal: true,
                                    },
                                  ),
                                );
                          },
                          child: const Text('Tambahkan Data Janin'),
                        ),
                      ],
                    ),
                  ),
                ),
              AsyncValueWidget(
                value: state.allFetals,
                data: (data) {
                  final fetals = _groupAndSelectLatestFetals(data ?? []);
                  return data!.isEmpty
                      ? Container(
                          width: 374.w,
                          height: 192.h,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: HexColor('#CCD1D6'),
                                width: 0.3.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.09),
                                  offset: const Offset(0, 1),
                                  blurRadius: 4,
                                )
                              ]),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Data janin belum ada',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(height: 10.0),
                                ElevatedButton(
                                  onPressed: () {
                                    ref.read(goRouterProvider).pushNamed(
                                          Routes.addFetalRecord.name,
                                          extra: Extras(
                                            datas: {
                                              ExtrasKey.user: user,
                                              ExtrasKey.isNewFetal: true,
                                            },
                                          ),
                                        );
                                  },
                                  child: const Text('Tambahkan Data Janin'),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: fetals.length,
                          itemBuilder: (context, index) {
                            final fetal = fetals[index];
                            return InkWell(
                              onTap: () {
                                ref.read(goRouterProvider).pushNamed(
                                    Routes.fetalRecord.name,
                                    extra: Extras(datas: {
                                      ExtrasKey.fetals: state
                                              .allFetals.asData?.value
                                              ?.where((e) =>
                                                  e.fetalId == fetal.fetalId)
                                              .toList() ??
                                          [],
                                      ExtrasKey.fetal: fetal,
                                    }));
                              },
                              child: Container(
                                width: 374.w,
                                height: 192.h,
                                margin: fetals.length == 1
                                    ? EdgeInsets.zero
                                    : EdgeInsets.only(bottom: 20.h),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6.r),
                                    border: Border.all(
                                      color: HexColor('#CCD1D6'),
                                      width: 0.3.w,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Data Janin ${fetals.length == 1 ? '' : index + 1}',
                                          style: TypographyApp.dataTitleMedrec,
                                        ),
                                        if (fetal.isBorn)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 5.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Text(
                                              'Sudah Lahir',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 48.w,
                                            height: 48.w,
                                            decoration: BoxDecoration(
                                              color: ColorApp.primary
                                                  .withOpacity(0.20),
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Center(
                                                child: Image.asset(
                                              'assets/images/child_img.png',
                                              width: 32.w,
                                              height: 32.h,
                                            )),
                                          ),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 280.w,
                                                height: 102.h,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 22.w,
                                                    vertical: 13.h),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.r),
                                                  border: Border.all(
                                                    color: HexColor('#CCD1D6'),
                                                    width: 0.3.w,
                                                  ),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text: '${fetal.weight}'
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r'\.0'),
                                                                    ''),
                                                            style: TypographyApp
                                                                .babyWeightMedrec,
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: ' g',
                                                                style: TypographyApp
                                                                    .babyWeightUnitMedrec,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          'Berat',
                                                          style: TypographyApp
                                                              .babySubtitleMedrec,
                                                        ),
                                                      ],
                                                    ),
                                                    VerticalDivider(
                                                      width: 14
                                                          .w, // Jarak total termasuk ketebalan garis
                                                      thickness: 0.3
                                                          .w, // Ketebalan garis
                                                      color: HexColor(
                                                          '#CCD1D6'), // Warna garis
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text: '${fetal.length}'
                                                                .replaceAll(
                                                                    RegExp(
                                                                        r'\.0'),
                                                                    ''),
                                                            style: TypographyApp
                                                                .babyWeightMedrec,
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                text: ' cm',
                                                                style: TypographyApp
                                                                    .babyWeightUnitMedrec,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          'Panjang',
                                                          style: TypographyApp
                                                              .babySubtitleMedrec,
                                                        ),
                                                      ],
                                                    ),
                                                    VerticalDivider(
                                                      width: 14
                                                          .w, // Jarak total termasuk ketebalan garis
                                                      thickness: 0.3
                                                          .w, // Ketebalan garis
                                                      color: HexColor(
                                                          '#CCD1D6'), // Warna garis
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text:
                                                                '${fetal.heartRate} bpm',
                                                            style: TypographyApp
                                                                .babyWeightMedrec,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Detak Jantung',
                                                          style: TypographyApp
                                                              .babySubtitleMedrec,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12.h,
                                              ),
                                              SizedBox(
                                                width: 280.w,
                                                child: Row(
                                                  mainAxisAlignment: (fetal.date
                                                              .isNotNull() &&
                                                          fetal.fetalDate
                                                              .add(
                                                                  const Duration(
                                                                      days:
                                                                          280))
                                                              .isBefore(DateTime
                                                                  .now()) &&
                                                          !fetal.isBorn)
                                                      ? MainAxisAlignment
                                                          .spaceBetween
                                                      : MainAxisAlignment.end,
                                                  children: [
                                                    if (fetal.date.isNotNull())
                                                      if (fetal.fetalDate
                                                              .add(
                                                                  const Duration(
                                                                      days:
                                                                          280))
                                                              .isBefore(DateTime
                                                                  .now()) &&
                                                          !fetal.isBorn)
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green,
                                                                width: 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          child: Material(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                            child: InkWell(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(Colors
                                                                          .green
                                                                          .withOpacity(
                                                                              0.2)),
                                                              onTap: () {
                                                                QuickAlert.show(
                                                                  context:
                                                                      context,
                                                                  type: QuickAlertType
                                                                      .confirm,
                                                                  title:
                                                                      'Konfirmasi Kelahiran',
                                                                  text:
                                                                      'Apakah janin ini sudah lahir?',
                                                                  confirmBtnText:
                                                                      "Ya",
                                                                  cancelBtnText:
                                                                      "Tidak",
                                                                  onConfirmBtnTap:
                                                                      () async {
                                                                    await controller
                                                                        .setBorn(
                                                                            fetal.fetalId,
                                                                            user);
                                                                    await ref
                                                                        .read(commonControllerProvider
                                                                            .notifier)
                                                                        .getProfile();
                                                                    final conceptionDate = ref
                                                                            .read(
                                                                                commonControllerProvider)
                                                                            .userValue
                                                                            .asData
                                                                            ?.value
                                                                            .fetalDate ??
                                                                        DateTime
                                                                            .now();
                                                                    ref
                                                                        .read(medicalRecordControllerProvider
                                                                            .notifier)
                                                                        .getTrimester(
                                                                            conceptionDate);
                                                                    ref
                                                                        .read(
                                                                            goRouterProvider)
                                                                        .goNamed(Routes
                                                                            .botNavBar
                                                                            .name);
                                                                  },
                                                                );
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10.0,
                                                                    vertical:
                                                                        5.0),
                                                                child: Center(
                                                                  child: Text(
                                                                    'Sudah Lahir?',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14.sp,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    Text(
                                                      fetal.isBorn
                                                          ? fetal.fetalDate
                                                              .dateMonthYear
                                                          : fetal.date == null
                                                              ? '-'
                                                              : fetal.date!
                                                                  .dateMonthYear,
                                                      style: TypographyApp
                                                          .dataDateMedrec,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                },
                error: (errorWidget) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Gagal memuat data janin',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          controller.getFetal(user);
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                  top: 30.0.h,
                  left: 16.0.w,
                  right: 16.0.w,
                ),
                height: 175.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.green,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                        onPressed: () {
                          ref.read(goRouterProvider).pushNamed(
                                Routes.addMotherRecord.name,
                                extra: Extras(
                                  datas: {
                                    ExtrasKey.user: user,
                                  },
                                ),
                              );
                        },
                        child: Text(
                          'Tambah Data Ibu',
                          style: TypographyApp.addMomDataMedrec,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorApp.primary,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                        ),
                        onPressed: () {
                          ref.read(goRouterProvider).pushNamed(
                                Routes.addFetalRecord.name,
                                extra: Extras(
                                  datas: {
                                    ExtrasKey.user: user,
                                    ExtrasKey.isNewFetal:
                                        user.fetalId.isEmpty &&
                                                state.allFetals.asData?.value
                                                        ?.isEmpty ==
                                                    true ||
                                            user.fetalId.isEmpty &&
                                                state.allFetals.asData?.value
                                                        ?.isNotEmpty ==
                                                    true
                                  },
                                ),
                              );
                        },
                        child: Text(
                          'Tambah Data Janin',
                          style: TypographyApp.addMomDataMedrec,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: ColorApp.primary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}

List<Fetal> _groupAndSelectLatestFetals(List<Fetal> data) {
  final List<Fetal> groupedFetals = [];
  final Map<String, List<Fetal>> grouped = {};

  // Grouping fetals by fetalId
  for (var fetal in data) {
    if (!grouped.containsKey(fetal.fetalId)) {
      grouped[fetal.fetalId] = [];
    }
    grouped[fetal.fetalId]!.add(fetal);
  }

  // Selecting the latest fetal for each group
  grouped.forEach((key, value) {
    final latestFetal = value.reduce((a, b) => a.date == null
        ? b
        : b.date == null
            ? a
            : a.date!.isAfter(b.date!)
                ? a
                : b);
    groupedFetals.add(latestFetal);
  });

  return groupedFetals;
}
