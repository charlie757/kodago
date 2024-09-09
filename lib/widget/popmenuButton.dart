import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';

PopupMenuButton customPopupMenuButton(
    {required List<PopupMenuItem> list,
    final PopupMenuItemSelected? onSelected}) {
  return PopupMenuButton(
      color: AppColor.whiteColor,
      position: PopupMenuPosition.under,
      iconColor: AppColor.grey7DColor,
      constraints: const BoxConstraints(maxWidth: 200, minWidth: 150),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffDDDDDD))),
      onSelected: onSelected,
      itemBuilder: (BuildContext bc) {
        return list;
      });
}

PopupMenuItem customPopMenuItem({required int value, required String title}) {
  return PopupMenuItem(
    value: value,
    height: 40,
    child: customText(
      title: title,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColor.blackColor,
      fontFamily: FontFamily.interMedium,
    ),
  );
}
