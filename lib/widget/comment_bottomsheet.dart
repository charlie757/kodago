import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/comment_widget.dart';

commentBottomSheet() {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      shape: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.whiteColor),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: EdgeInsets.only(
              top: 19, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customText(
                title: 'Comments',
                fontSize: 20,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.interSemiBold,
              ),
              ScreenSize.height(17),
              divider(),
              ScreenSize.height(16),
              Expanded(child: commentWidget())
            ],
          ),
        );
      });
}

divider() {
  return Container(
    height: 1,
    color: const Color(0xffE7E7E7).withOpacity(.6),
  );
}

userCommentWidget(String img) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipOval(
        child: Image.asset(
          img,
          height: 32,
          width: 32,
        ),
      ),
      ScreenSize.width(10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customText(
                title: 'joshua_l',
                fontSize: 13,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interBold,
                fontWeight: FontWeight.w500,
              ),
              ScreenSize.width(8),
              customText(
                title: '2w',
                fontSize: 11,
                color: AppColor.grey7DColor,
                fontFamily: FontFamily.interRegular,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          ScreenSize.height(3),
          customText(
            title: 'Good Work for site',
            fontSize: 11.5,
            color: AppColor.grey7DColor,
            fontFamily: FontFamily.interRegular,
            fontWeight: FontWeight.w500,
          ),
          ScreenSize.height(4),
          customText(
            title: 'Reply',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interMedium,
            color: const Color(0xff6F6F6F),
          )
        ],
      )
    ],
  );
}

replyCommentWidget() {
  return Column(
    children: [
      divider(),
      ScreenSize.height(15),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Image.asset(
              'assets/dummay/profile1.png',
              height: 32,
              width: 32,
            ),
            ScreenSize.width(11),
            Expanded(
              child: TextFormField(
                cursorHeight: 20,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.interRegular,
                        color: Color(0xffABABAB))),
              ),
            ),
            ScreenSize.width(8),
            Image.asset(
              AppImages.shareIcon,
              height: 20,
              width: 20,
            )
          ],
        ),
      )
    ],
  );
}
