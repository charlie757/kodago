import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/auth/forgot_password_screen.dart';
import 'package:kodago/screens/auth/signup_screen.dart';
import 'package:kodago/screens/dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: appBar(title: '', onTap: () {}),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20),
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
                  title: 'Login',
                  fontFamily: FontFamily.interBold,
                  color: AppColor.blackDarkColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
                customText(
                  title: 'Welcome back to the app',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interRegular,
                  color: AppColor.lightTextColor,
                ),
                ScreenSize.height(80),
                customText(
                  title: 'Email Address',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.interMedium,
                  color: AppColor.blackDarkColor,
                ),
                ScreenSize.height(8),
                CustomTextField(hintText: 'hello@example.com'),
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
                ScreenSize.height(16),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      AppRoutes.pushCupertinoNavigation(
                          const ForgotPasswordScreen());
                    },
                    child: customText(
                      title: 'Forgot Password?',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColor.appColor,
                      fontFamily: FontFamily.interMedium,
                    ),
                  ),
                ),
                ScreenSize.height(23),
                CustomBtn(
                    title: 'Login',
                    borderRadius: 50,
                    onTap: () {
                      AppRoutes.pushCupertinoNavigation(
                          const DashboardScreen());
                    }),
                ScreenSize.height(30),
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(TextSpan(
                      text: "Don't have account? ",
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: FontFamily.interRegular,
                          fontWeight: FontWeight.w400,
                          color: AppColor.grey6AColor),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppRoutes.pushCupertinoNavigation(
                                    const SignupScreen());
                              },
                            text: 'Sign Up',
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
        ),
      ),
    );
  }
}
