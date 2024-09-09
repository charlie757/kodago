import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/auth/reset_password_screen.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
              title: 'OTP Verification',
              fontFamily: FontFamily.interBold,
              color: AppColor.blackDarkColor,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            customText(
              title:
                  'Enter the verification code we just sent on your phone number xxxxxx0275.',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular,
              color: AppColor.lightTextColor,
            ),
            ScreenSize.height(60),
            otpField(),
            ScreenSize.height(18),
            CustomBtn(
                title: 'Verify',
                borderRadius: 50,
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(
                      const ResetPasswordScreen());
                }),
            ScreenSize.height(23),
            Align(
              alignment: Alignment.center,
              child: customText(
                title: 'Resend OTP in 23s',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interMedium,
              ),
            ),
            ScreenSize.height(10),
            Align(
              alignment: Alignment.center,
              child: customText(
                title: 'Resend OTP',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.grey7DColor,
                fontFamily: FontFamily.interMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  otpField() {
    final decoration = BoxDecoration(
      border: Border.all(color: const Color(0xffD0D5DD)),
      borderRadius: BorderRadius.circular(8),
    );

    return Pinput(
      length: 6,
      // controller: controller.otpController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Enter otp';
        } else if (val.length < 6) {
          return 'Incorrect otp';
        }
      },
      defaultPinTheme: PinTheme(
          width: 52,
          height: 50,
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: decoration),
      focusedPinTheme: PinTheme(
          width: 52,
          height: 50,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: decoration),
      submittedPinTheme: PinTheme(
          width: 52,
          height: 50,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: decoration),
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
