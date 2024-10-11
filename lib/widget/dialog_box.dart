import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/uitls/utils.dart';

dialogBox({required String title,required String des, Function()? yesTap,}) {
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
          padding:
              const EdgeInsets.only(top: 39, bottom: 39, left: 20, right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              customText(
                title: title,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.interMedium,
              ),
              ScreenSize.height(14),
              customText(
                title: 'You are about to logout of your account',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interMedium,
                textAlign: TextAlign.center,
              ),
              ScreenSize.height(30),
              Row(
                children: [
                  Expanded(
                    child: CustomBtn(
                        title: "No",
                        color: AppColor.orangeColor,
                        width: 144,
                        height: 40,
                        onTap: () {
                          Navigator.pop(navigatorKey.currentContext!);
                        }),
                  ),
                  ScreenSize.width(15),
                  Expanded(
                    child: CustomBtn(
                        title: "Yes",
                        width: 144,
                        height: 40,
                        onTap: yesTap!),
                  ),
                ],
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
