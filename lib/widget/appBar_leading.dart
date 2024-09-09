import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/uitls/utils.dart';

AppBar appBarWithLeading(
    {required String title,
    List<Widget>? actions,
    bool isLeading = true,
    Function()? onTap,
    Color titleColor = AppColor.blackColor}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: isLeading
        ? GestureDetector(
            onTap: onTap ??
                () {
                  Navigator.pop(navigatorKey.currentContext!);
                },
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.arrowForeWordIcon,
                height: 20,
                width: 20,
              ),
            ),
          )
        : Container(),
    title: customText(
      title: title,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: titleColor,
      fontFamily: FontFamily.interSemiBold,
    ),
    actions: actions,
  );
}
