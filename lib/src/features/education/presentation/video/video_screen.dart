import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/education/domain/category.dart';
import 'package:nutrimama/src/features/education/presentation/education_controller.dart';
import 'package:nutrimama/src/features/education/presentation/widgets/chip_bar_widget.dart';
import 'package:nutrimama/src/features/education/presentation/widgets/video_widget.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';

class VideoScreen extends ConsumerWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(educationControllerProvider.notifier);
    final state = ref.watch(educationControllerProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Aktivitas',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getVideos();
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w),
              height: 60.h,
              child: ChipBarWidget(
                selectedChipIndex: state.selectedIndexVideos,
                enumValues:
                    EducationCategory.values.map((e) => e.value).toList(),
                onChipSelected: (index) {
                  controller.onChipSelected(index, isVideo: true);
                },
                chips:
                    EducationCategory.values.map((e) => Text(e.value)).toList(),
              ),
            ),
            AsyncValueWidget(
              value: state.filteredVideos,
              data: (data) => Expanded(
                child: ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return VideoWidget(
                      video: data[index],
                      onTap: () {
                        context.pushNamed(Routes.detailVideo.name,
                            extra:
                                Extras(datas: {ExtrasKey.video: data[index]}));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
