import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/uitls/utils.dart';

deleteFileRackDialogBox({required Function() deleteTap}) {
  showGeneralDialog(
    context: navigatorKey.currentContext!,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 39, bottom: 39),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.deletelogoutIcon,
                height: 110,
              ),
              ScreenSize.height(23),
              customText(
                title: 'Are you sure you want to\ndelete your file racks?',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interMedium,
              ),
              ScreenSize.height(14),
              CustomBtn(
                  title: "Yes, Delete",
                  color: AppColor.orangeColor,
                  width: 144,
                  onTap: deleteTap),
              ScreenSize.height(15),
              GestureDetector(
                onTap: () {
                  Navigator.pop(navigatorKey.currentContext!);
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  height: 25,
                  child: customText(
                    title: 'Keep File racks',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interSemiBold,
                    color: AppColor.orangeColor,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
