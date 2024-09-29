import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/uitls/utils.dart';

imageBottomSheet({
  Function()? cameraTap,
  Function()? galleryTap,
}) {
  showModalBottomSheet(
      context: navigatorKey.currentContext!,
      backgroundColor: AppColor.whiteColor,
      shape: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.whiteColor),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: cameraTap,
                      child: iconcreation(
                          Icons.camera_alt, Colors.pink, "Camera")),
                  GestureDetector(
                      onTap: galleryTap,
                      child: iconcreation(
                          Icons.insert_photo, Colors.purple, "Gallery"))
                ],
              ),
            ],
          ),
        );
      });
}

Widget iconcreation(IconData icon, Color color, String text) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: color,
        radius: 30,
        child: Icon(
          icon,
          size: 29,
          color: Colors.white,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      customText(
          title: text,
          fontSize: 14,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.interMedium),
    ],
  );
}
