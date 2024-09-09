import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: ScreenSize.screenHeight -
                ScreenSize.appBarHeight -
                ScreenSize.keyboardHeight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: 'Reset Password',
                fontFamily: FontFamily.interBold,
                color: AppColor.blackDarkColor,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
              customText(
                title:
                    'Enter your new password twice below to reset a new password',
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interRegular,
                color: AppColor.lightTextColor,
              ),
              ScreenSize.height(60),
              customText(
                title: 'Enter new password',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.interMedium,
                color: AppColor.blackDarkColor,
              ),
              ScreenSize.height(8),
              CustomTextField(
                hintText: 'Enter new password',
                prefixWidget: Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.lockIcon,
                      height: 20,
                    )),
                suffixWidget: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.visibility,
                    color: Color(0xffA3A3A3),
                  ),
                ),
              ),
              ScreenSize.height(25),
              customText(
                title: 'Re-enter new password',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.interMedium,
                color: AppColor.blackDarkColor,
              ),
              ScreenSize.height(8),
              CustomTextField(
                hintText: 'Re-enter new password',
                prefixWidget: Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.lockIcon,
                      height: 20,
                    )),
                suffixWidget: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.visibility,
                    color: Color(0xffA3A3A3),
                  ),
                ),
              ),
              ScreenSize.height(34),
              CustomBtn(
                  title: 'Reset ',
                  borderRadius: 50,
                  onTap: () {
                    // AppRoutes.pushCupertinoNavigation(
                    //     const ResetPasswordScreen());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
