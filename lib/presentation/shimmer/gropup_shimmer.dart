import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:shimmer/shimmer.dart';

class GropupShimmer extends StatelessWidget {
  const GropupShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(14);
        },
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.whiteColor),
                ),
              ),
              ScreenSize.width(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      width: 8,
                      height: 100,
                      decoration:
                          const BoxDecoration(color: AppColor.whiteColor),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 120,
                    decoration: const BoxDecoration(color: AppColor.whiteColor),
                  ),
                ],
              ),
              Container(
                width: 8,
                height: 50,
                decoration: const BoxDecoration(color: AppColor.whiteColor),
              ),
            ],
          );
        });
  }
}
