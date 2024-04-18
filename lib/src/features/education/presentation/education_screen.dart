import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/education/domain/article.dart';
import 'package:nutrimama/src/features/education/presentation/education_controller.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/routes.dart';

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
              // Chip bar for filtering
              Container(
                margin: EdgeInsets.only(left: 16.w),
                height: 60.h,
                child: ChipBar(
                  selectedChipIndex: state.selectedIndex,
                  enumValues:
                      ArticleCategory.values.map((e) => e.value).toList(),
                  onChipSelected: controller.onChipSelected,
                  chips:
                      ArticleCategory.values.map((e) => Text(e.value)).toList(),
                ),
              ),

              // List view to display articles
              AsyncValueWidget(
                value: state.filteredArticles,
                data: (data) => Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return ArticleItem(article: data[index]);
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

// Widget to display an article item
class ArticleItem extends StatelessWidget {
  final Article article;

  const ArticleItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(Routes.detailArticle.name,
            extra: Extras(datas: {ExtrasKey.article: article}));
      },
      child: Container(
        // parent is row, separated by text and image, the text is column has 3 children: category, title, description. Image at right side.
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Row(
          children: [
            // Text
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category
                    Text(
                      article.category.value,
                      style: TextStyle(
                        color: ColorApp.primary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      article.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),

                    SizedBox(
                      width: 230.w,
                      child: Text(
                        article.description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Image
            article.imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/500/300?random=2',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 72.h,
                      width: 72.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// Chip bar widget
class ChipBar extends StatelessWidget {
  final String selectedChipIndex;
  final Function(String) onChipSelected;
  final List<Widget> chips;
  final List<String> enumValues;

  const ChipBar({
    super.key,
    required this.selectedChipIndex,
    required this.onChipSelected,
    required this.chips,
    required this.enumValues,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: chips.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final chip = chips[index];
        return Container(
          margin: EdgeInsets.only(right: 8.w),
          child: FilterChip(
            color: selectedChipIndex == enumValues[index]
                ? MaterialStateProperty.all(ColorApp.primary)
                : MaterialStateProperty.all(Colors.grey[200]),
            showCheckmark: false,
            label: chip,
            labelStyle: TextStyle(
              color: selectedChipIndex == enumValues[index]
                  ? Colors.white
                  : Colors.black,
            ),
            selected: selectedChipIndex == enumValues[index],
            onSelected: (_) {
              onChipSelected(enumValues[index]);
            },
            side: BorderSide.none,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        );
      },
    );
  }
}
