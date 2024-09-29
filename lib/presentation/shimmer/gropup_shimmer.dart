import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:shimmer/shimmer.dart';

class GropupShimmer extends StatelessWidget {
  final String route;
  const GropupShimmer({this.route = 'group'});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(14);
        },
        itemCount: 15,
        padding: const EdgeInsets.only(top: 20, bottom: 30),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        width: 100,
                        height: 8,
                        decoration:
                            const BoxDecoration(color: AppColor.whiteColor),
                      ),
                    ),
                    ScreenSize.height(7),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        width: 150,
                        height: 8,
                        decoration:
                            const BoxDecoration(color: AppColor.whiteColor),
                      ),
                    ),
                  ],
                ),
              ),
              route == 'group'
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        width: 50,
                        height: 8,
                        decoration:
                            const BoxDecoration(color: AppColor.whiteColor),
                      ),
                    )
                  : Container(),
            ],
          );
        });
  }
}
