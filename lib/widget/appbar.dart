import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/uitls/utils.dart';

AppBar appBar(
    {required String title,
    List<Widget>? actions,
    bool isLeading = true,
    Function()? onTap,
    Color titleColor = AppColor.blackColor}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        isLeading
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
        ScreenSize.width(isLeading ? 15 : 5),
        Flexible(
          child: customText(
            title: title,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: titleColor,
            maxLines: 1,
            fontFamily: FontFamily.interSemiBold,
          ),
        ),
      ],
    ),
    actions: actions,
  );
}
