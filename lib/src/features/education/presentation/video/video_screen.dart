import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/features/education/domain/article.dart';
import 'package:nutrimama/src/features/education/domain/video.dart';
import 'package:nutrimama/src/features/education/presentation/education_controller.dart';
import 'package:nutrimama/src/features/education/presentation/widgets/article_widget.dart';
import 'package:nutrimama/src/features/education/presentation/widgets/chip_bar_widget.dart';
import 'package:nutrimama/src/features/education/presentation/widgets/video_widget.dart';

class VideoScreen extends ConsumerWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(educationControllerProvider.notifier);
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
        onRefresh: () async {},
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w),
              height: 60.h,
              child: ChipBarWidget(
                selectedChipIndex: 'Semua',
                enumValues: ArticleCategory.values.map((e) => e.value).toList(),
                onChipSelected: (String index) {},
                chips:
                    ArticleCategory.values.map((e) => Text(e.value)).toList(),
              ),
            ),
            AsyncValueWidget(
              value: state.filteredArticles,
              data: (data) => Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    List<Video> videos = [
                      const Video(
                          id: '1',
                          title: 'How To',
                          description: 'lorem ipsum',
                          videoUrl: '',
                          imageUrl: '',
                          category: VideoCategory.kehamilan),
                      const Video(
                          id: '2',
                          title: 'How To',
                          description: 'lorem ipsum',
                          videoUrl: '',
                          imageUrl: '',
                          category: VideoCategory.kehamilan),
                      const Video(
                          id: '3',
                          title: 'Tips dan Trik Merawat Bayi',
                          description: 'lorem ipsum',
                          videoUrl: '',
                          imageUrl: '',
                          category: VideoCategory.kehamilan),
                    ];

                    return VideoWidget(video: videos[index]);
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
