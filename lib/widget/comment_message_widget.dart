import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/uitls/time_format.dart';

commentMessageWidget({required String img, required String title, required String msg, required String date, bool isDefault = true, Function()?onTap}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipOval(
        child: isDefault?Image.asset(
          img,
          height: 32,
          width: 32,
        ):ViewNetworkImage(img: img,height: 32.0,width: 32.0,),
      ),
      ScreenSize.width(10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customText(
                title: title,
                fontSize: 13,
                maxLines: 1,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interBold,
                fontWeight: FontWeight.w500,
              ),
              ScreenSize.width(8),
              customText(
                title: isDefault?date: TimeFormat.commentDate(date),
                fontSize: 11,
                color: AppColor.grey7DColor,
                fontFamily: FontFamily.interMedium,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          ScreenSize.height(3),
          customText(
            title: msg,
            fontSize: 11.5,
            color: AppColor.grey7DColor,
            fontFamily: FontFamily.interMedium,
            fontWeight: FontWeight.w500,
          ),
          ScreenSize.height(4),
          GestureDetector(
            onTap: onTap,
            child: customText(
              title: 'Reply',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.interSemiBold,
              color: const Color(0xff6F6F6F),
            ),
          )
        ],
      )
    ],
  );
}