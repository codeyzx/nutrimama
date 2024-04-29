import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nutrimama/src/features/community/domain/post.dart';
import 'package:nutrimama/src/shared/extensions/date_time.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final bool isLiked;
  final Function() onTap;

  const PostWidget({
    super.key,
    required this.post,
    required this.isLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: 16.w,
        right: 20.w,
        top: 20.h,
      ),
      color: Colors.white,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  post.userPhoto.isNotEmpty
                      ? Container(
                          height: 42.h,
                          width: 42.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(post.userPhoto),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.person),
                        ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post.createdAt.pastDate,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post.title,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
            ),
            if (post.imageUrl.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )),
          ],
        ),
      ),
    );
  }
}
