import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/auth/otp_verification_screen.dart';
import 'package:kodago/screens/auth/reset_password_screen.dart';
import 'package:kodago/widget/appbar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              title: 'Forgot Password?',
              fontFamily: FontFamily.interBold,
              color: AppColor.blackDarkColor,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            customText(
              title: 'Recover you password if you have forgot the password',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular,
              color: AppColor.lightTextColor,
            ),
            ScreenSize.height(60),
            customText(
              title: 'Email/Phone number',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.interMedium,
              color: AppColor.blackDarkColor,
            ),
            ScreenSize.height(8),
            CustomTextField(
              hintText: 'Email/Phone number',
              prefixWidget: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.email_outlined,
                    color: AppColor.appColor,
                  )),
            ),
            ScreenSize.height(34),
            CustomBtn(
                title: 'Password Reset',
                borderRadius: 50,
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(
                      const OtpVerificationScreen());
                })
          ],
        ),
      ),
    );
  }
}
