import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/features/education/domain/category.dart';
import 'package:nutrimama/src/features/education/presentation/education_controller.dart';
import 'package:nutrimama/src/features/education/presentation/widgets/article_widget.dart';
import 'package:nutrimama/src/features/education/presentation/widgets/chip_bar_widget.dart';

class EducationScreen extends ConsumerWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(educationControllerProvider.notifier);
    final state = ref.watch(educationControllerProvider);
    return StatusBarWidget(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Edukasi 📚',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20.sp,
            ),
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(6.h),
            child: Container(
              height: 1.h,
              color: Colors.grey[300],
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 16.w),
                height: 60.h,
                child: ChipBarWidget(
                  selectedChipIndex: state.selectedIndex,
                  enumValues:
                      EducationCategory.values.map((e) => e.value).toList(),
                  onChipSelected: controller.onChipSelected,
                  chips: EducationCategory.values
                      .map((e) => Text(e.value))
                      .toList(),
                ),
              ),
              AsyncValueWidget(
                value: state.filteredArticles,
                data: (data) => Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return ArticleWidget(article: data[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
