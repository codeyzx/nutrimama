import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/journal/domain/journal.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

class JournalWidget extends StatelessWidget {
  final Journal journal;

  const JournalWidget({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.detailJournal.name,
            extra: Extras(datas: {ExtrasKey.journal: journal}));
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10.h,
          right: 16.w,
          left: 16.w,
          top: 6.h,
        ),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    journal.createdAt.dateMonth,
                    style: TextStyle(
                      color: ColorApp.primary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      journal.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      journal.description,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 48.h,
              width: 48.w,
              margin: EdgeInsets.only(bottom: 20.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorApp.primary.withOpacity(.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '😁',
                style: TextStyle(fontSize: 28.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
