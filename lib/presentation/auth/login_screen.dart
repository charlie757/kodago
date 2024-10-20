import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/textfield_lebal_text.dart';
import 'package:kodago/services/provider/auth_provider/login_provider.dart';
import 'package:kodago/presentation/auth/forgot_password_screen.dart';
import 'package:kodago/presentation/auth/signup_screen.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/uitls/white_space_formatter.dart';
import 'package:provider/provider.dart';

import '../../uitls/mixins.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with MediaQueryScaleFactor {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: appBar(title: '', onTap: () {}),
        body: SafeArea(
          child: Form(
            key: formKey,
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
                      color: AppColor.b45Color,
                    ),
                    ScreenSize.height(50),
                    TextfieldLebalText(title: 'Email/Phone number'),
                    ScreenSize.height(8),
                    CustomTextField(
                      hintText: 'Enter email or phone number',
                      isReadOnly: myProvider.isLoading,
                      controller: myProvider.emailController,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        WhiteSpaceFormatter(),
                        FilteringTextInputFormatter.deny(
                            RegExp(Utils.regexToRemoveEmoji)),
                      ],
                      prefixWidget: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          child: Image.asset(
                            AppImages.phoneIcon,
                            height: 20,
                          )),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Enter your email or phone';
                        }
                      },
                    ),
                    ScreenSize.height(20),
                    TextfieldLebalText(title: "Password"),
                    ScreenSize.height(8),
                    CustomTextField(
                      hintText: 'Enter your password',
                      isObscureText: myProvider.isVisible,
                      isReadOnly: myProvider.isLoading,
                      controller: myProvider.passwordController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            RegExp(Utils.regexToRemoveEmoji)),
                      ],
                      prefixWidget: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          child: Image.asset(
                            AppImages.lockIcon,
                            height: 20,
                          )),
                      suffixWidget: GestureDetector(
                        onTap: () {
                          if (myProvider.isVisible) {
                            myProvider.isVisible = false;
                          } else {
                            myProvider.isVisible = true;
                          }
                          setState(() {});
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          child: Image.asset(
                            !myProvider.isVisible
                                ? AppImages.visibilityOffIcon
                                : AppImages.visibilityIcon,
                            height: 20,
                          ),
                        ),
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter your password";
                        }
                        // else if (!Utils.passwordValidateRegExp(val)) {
                        //   return 'The password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                        // }
                      },
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
                        isLoading: myProvider.isLoading,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            myProvider.isLoading
                                ? null
                                : myProvider.callAPiFunction();
                          }
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
        ),
      );
    });
  }
}
