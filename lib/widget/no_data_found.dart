import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';

Widget noDataFound(String title) {
  return Align(
    alignment: Alignment.center,
    child: customText(
      title: title,
      fontSize: 13,
      fontFamily: FontFamily.interMedium,
      color: AppColor.redColor,
    ),
  );
}
