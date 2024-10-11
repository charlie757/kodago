import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:shimmer/shimmer.dart';

class CommentShimmer extends StatefulWidget {
  const CommentShimmer({super.key});

  @override
  State<CommentShimmer> createState() => _CommentShimmerState();
}

class _CommentShimmerState extends State<CommentShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context,sp){
        return ScreenSize.height(20);
      },
        itemCount: 8,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: Container(
                  height: 32,
                  width: 32,
                  decoration: const BoxDecoration(shape: BoxShape.circle,color: AppColor.whiteColor),
                ),
              ),
              ScreenSize.width(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      height: 8,
                      width: 150,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  ScreenSize.height(10),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      height: 8,
                      width: 200,
                      color: AppColor.whiteColor,
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }
}
