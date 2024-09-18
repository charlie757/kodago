import 'package:flutter/material.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'app_color.dart';

// ignore: must_be_immutable
class CustomBtn extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final bool isLoading;
  Color color;
  final Function() onTap;
  double borderRadius;
  CustomBtn(
      {required this.title,
      this.height,
      this.width,
      required this.onTap,
      this.color = AppColor.appColor,
      this.isLoading = false,
      this.borderRadius =50});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? color.withOpacity(.5) : color,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
      onPressed: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 48,
        width: width ?? double.infinity,
        child: isLoading
            ? Container(
                height: 22,
                width: 22,
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : customText(
                title: title,
                fontSize: 16,
                fontFamily: FontFamily.interMedium,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w600),
      ),
    );
  }
}
