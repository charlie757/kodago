import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';

customCheckBox({required int index, required int selectedIndex}) {
  return Container(
    height: 18,
    width: 18,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: selectedIndex == index
                ? AppColor.darkAppColor
                : const Color(0xff979797))),
    child: selectedIndex == index
        ? const Icon(
            Icons.check,
            color: AppColor.darkAppColor,
            size: 14,
          )
        : Container(),
  );
}
