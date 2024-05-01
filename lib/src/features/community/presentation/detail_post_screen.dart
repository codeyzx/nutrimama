import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/gen/assets.gen.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/common/presentation/common_controller.dart';
import 'package:nutrimama/src/features/community/domain/comment.dart';
import 'package:nutrimama/src/features/community/presentation/community_controller.dart';
import 'package:nutrimama/src/shared/extensions/extensions.dart';

class DetailPostScreen extends ConsumerWidget {
  const DetailPostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(communityControllerProvider);
    final userState = ref.watch(commonControllerProvider);
    final user = userState.userValue.asData!.value;
    final post = state.post.asData!.value!;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Detail Post',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 20,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (post.imageUrl.isNotEmpty)
                CachedNetworkImage(
                  imageUrl: post.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    height: 200.h,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              SizedBox(height: 17.h),
              Row(
                children: [
                  post.userPhoto.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: post.userPhoto,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 42.h,
                            width: 42.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
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
                      : const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post.createdAt.pastDate,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // title post
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  post.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  post.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  'Komentar',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20.h,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    user.photoUrl.isEmpty
                        ? CircleAvatar(
                            backgroundImage:
                                Assets.images.profileDefaultImg.image().image,
                            radius: 20.0,
                          )
                        : CachedNetworkImage(
                            imageUrl: user.photoUrl,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 38.h,
                              width: 38.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
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
                          ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: TextField(
                          controller: state.commentController,
                          decoration: const InputDecoration(
                            hintText: 'Tambahkan komentar',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () async {
                          if (state.commentController.text.isNotEmpty) {
                            Comment comment = Comment(
                              userId: user.id,
                              userName: user.name,
                              userPhoto: user.photoUrl,
                              createdAt: DateTime.now(),
                              postId: post.id,
                              text: state.commentController.text,
                            );
                            await ref
                                .read(communityControllerProvider.notifier)
                                .addComment(post.id, comment);
                            await ref
                                .read(communityControllerProvider.notifier)
                                .getPost(post.id);
                            state.commentController.clear();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              post.comments.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: Text(
                        'Belum ada komentar',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: post.comments.length,
                      itemBuilder: (context, index) {
                        Comment comment = post.comments[index];
                        return Container(
                          margin: EdgeInsets.only(top: 20.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              comment.userPhoto.isEmpty
                                  ? CircleAvatar(
                                      radius: 30.r,
                                      backgroundImage:
                                          Assets.images.profileDefaultImg
                                              .image(
                                                width: 38.w,
                                                height: 38.h,
                                              )
                                              .image,
                                      backgroundColor: Colors.white,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: comment.userPhoto,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 38.h,
                                        width: 38.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                              Gap.w16,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        comment.userName,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Gap.w8,
                                      Text(
                                        comment.createdAt.pastDate,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    comment.text,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
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
      ),
    );
  }
}
