import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:shimmer/shimmer.dart';

class StoryShimmer extends StatelessWidget {
  const StoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          separatorBuilder: (context, sp) {
            return ScreenSize.width(20);
          },
          shrinkWrap: true,
          itemCount: 8,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                              color: AppColor.whiteColor,
                              shape: BoxShape.circle),
                        ),
                      ),
                      ScreenSize.height(3),
                      Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 6,
                              width: 60,
                              color: AppColor.whiteColor,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
