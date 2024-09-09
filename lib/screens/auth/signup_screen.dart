import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ''),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              title: 'Create an account',
              fontFamily: FontFamily.interBold,
              color: AppColor.blackDarkColor,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            customText(
              title: 'Welcome back to the app',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular,
              color: AppColor.lightTextColor,
            ),
            ScreenSize.height(62),
            customText(
              title: 'Full Name',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.interMedium,
              color: AppColor.blackDarkColor,
            ),
            ScreenSize.height(8),
            CustomTextField(
              hintText: 'Enter your full name',
              isObscureText: true,
              prefixWidget: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.email_outlined,
                    color: AppColor.appColor,
                  )),
            ),
            ScreenSize.height(25),
            customText(
              title: 'Email',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.interMedium,
              color: AppColor.blackDarkColor,
            ),
            ScreenSize.height(8),
            CustomTextField(
              hintText: 'Enter your email',
              isObscureText: true,
              prefixWidget: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.email_outlined,
                    color: AppColor.appColor,
                  )),
            ),
            ScreenSize.height(25),
            customText(
              title: 'Phone Number',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.interMedium,
              color: AppColor.blackDarkColor,
            ),
            ScreenSize.height(8),
            CustomTextField(
              hintText: 'Enter your phone number',
              isObscureText: true,
              prefixWidget: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.email_outlined,
                    color: AppColor.appColor,
                  )),
            ),
            ScreenSize.height(25),
            customText(
              title: 'Password',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.interMedium,
              color: AppColor.blackDarkColor,
            ),
            ScreenSize.height(8),
            CustomTextField(
              hintText: 'Enter your password',
              isObscureText: true,
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
            ScreenSize.height(20),
            Row(
              children: [
                checkBox(),
                ScreenSize.width(10),
                const Expanded(
                  child: Text.rich(TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: FontFamily.interRegular,
                          color: AppColor.blackColor),
                      children: [
                        TextSpan(
                          text: 'terms of service.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: FontFamily.interRegular,
                              color: AppColor.appColor),
                        )
                      ])),
                )
              ],
            ),
            ScreenSize.height(28),
            CustomBtn(title: 'Sign Up', borderRadius: 50, onTap: () {}),
            ScreenSize.height(10),
            Align(
              alignment: Alignment.center,
              child: Text.rich(TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.interRegular,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey6AColor),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                        text: 'Sign In here',
                        style: const TextStyle(
                            fontSize: 12,
                            fontFamily: FontFamily.interMedium,
                            fontWeight: FontWeight.w400,
                            color: AppColor.appColor))
                  ])),
            )
          ],
        ),
      ),
    );
  }

  checkBox() {
    return Container(
      height: 18,
      width: 18,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: 0 == 0 ? AppColor.appColor : null,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
              color: 0 == 0 ? AppColor.appColor : const Color(0xff979797))),
      child: 0 == 0
          ? const Icon(
              Icons.check,
              color: AppColor.whiteColor,
              size: 14,
            )
          : Container(),
    );
  }
}
