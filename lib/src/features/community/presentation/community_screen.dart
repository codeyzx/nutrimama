import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/common_widgets/common_widgets.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/community/presentation/community_controller.dart';
import 'package:nutrimama/src/features/community/presentation/widgets/post_widget.dart';
import 'package:nutrimama/src/routes/routes.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(communityControllerProvider);
    return StatusBarWidget(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Komunitas ☁️',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20.sp,
              ),
            ),
            centerTitle: false,
            actions: [
              InkWell(
                onTap: () {
                  ref.read(goRouterProvider).pushNamed(
                        Routes.addPost.name,
                        extra: Extras(
                          datas: {
                            ExtrasKey.user: ref
                                .read(commonControllerProvider)
                                .userValue
                                .asData!
                                .value,
                          },
                        ),
                      );
                },
                child: Container(
                  height: 30.h,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: ColorApp.primary,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Tambah Post',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24.sp,
                      )
                    ],
                  ),
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(6.h),
              child: Container(
                height: 1.h,
                color: Colors.grey[300],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await ref.read(communityControllerProvider.notifier).getPosts();
            },
            child: AsyncValueWidget(
              value: state.posts,
              data: (posts) => ListView.builder(
                shrinkWrap: true,
                itemCount: posts!.length,
                itemBuilder: (context, index) {
                  return PostWidget(
                    post: posts[index],
                    isLiked: true,
                    onTap: () {
                      ref.read(goRouterProvider).pushNamed(
                          Routes.detailPost.name,
                          extra: Extras(datas: {ExtrasKey.post: posts[index]}));
                    },
                  );
                },
              ),
            ),
          )),
    );
  }
}
