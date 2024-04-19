import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nutrimama/src/constants/constants.dart';
import 'package:nutrimama/src/features/education/domain/video.dart';
import 'package:nutrimama/src/routes/app_routes.dart';
import 'package:nutrimama/src/routes/extras.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatelessWidget {
  final Video video;
  final void Function() onTap;

  const VideoWidget({super.key, required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(12.w),
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
          children: [
            video.videoUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: YoutubePlayer.getThumbnail(
                        quality: ThumbnailQuality.max,
                        videoId:
                            YoutubePlayer.convertUrlToId(video.videoUrl) ?? ""),
                    imageBuilder: (context, imageProvider) => Container(
                      height: 72.h,
                      width: 80.w,
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
                    width: 107.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.category.value,
                    style: TextStyle(
                      color: ColorApp.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      video.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      video.description,
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
            Container(
              decoration: BoxDecoration(
                color: HexColor('#E5F6FD'),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: ColorApp.primary),
              ),
              child: IconButton(
                icon: Icon(Icons.play_arrow,
                    color: ColorApp.primary, size: 34.sp),
                onPressed: () {
                  context.pushNamed(Routes.detailVideo.name,
                      extra: Extras(datas: {ExtrasKey.video: video}));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
