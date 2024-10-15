// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class ViewNetworkImage extends StatelessWidget {
  final img;
  final height;
  final width;
  BoxFit? fit;
   ViewNetworkImage({super.key, this.img, this.height, this.width, this.fit=BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: img,
      height: height,
      width: width,
      fit: fit,
      memCacheHeight: 300,
      memCacheWidth: 300,
      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              color: AppColor.appColor,
              strokeWidth: 1,
              value: downloadProgress.progress)),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
