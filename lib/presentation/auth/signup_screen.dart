import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/launch_url.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/textfield_lebal_text.dart';
import 'package:kodago/services/provider/auth_provider/signup_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/uitls/white_space_formatter.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<SignupProvider>(context, listen: false);
    provider.resetValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        appBar: appBar(title: ''),
        body: Form(
          key: myProvider.formKey,
          child: SingleChildScrollView(
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
                  color: AppColor.b45Color,
                ),
                ScreenSize.height(50),
                TextfieldLebalText(title: 'Full Name'),
                ScreenSize.height(8),
                CustomTextField(
                  hintText: 'Enter your full name',
                  isReadOnly: myProvider.isLoading,
                  controller: myProvider.nameController,
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
                        AppImages.userIcon,
                        height: 20,
                      )),
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Enter your name';
                    }
                  },
                ),
                ScreenSize.height(20),
                TextfieldLebalText(title: 'Email'),
                ScreenSize.height(8),
                CustomTextField(
                  hintText: 'Enter your email',
                  controller: myProvider.emailController,
                  isReadOnly: myProvider.isLoading,
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
                      child: const Icon(
                        Icons.email_outlined,
                        color: AppColor.appColor,
                      )),
                  validator: (val) {
                    RegExp regExp = RegExp(Utils.emailPattern);
                    if (val.isEmpty) {
                      return 'Enter your email';
                    } else if (!regExp.hasMatch(val)) {
                      return "Enter valid email format";
                    }
                  },
                ),
                ScreenSize.height(20),
                TextfieldLebalText(title: 'Phone Number'),
                ScreenSize.height(8),
                CustomTextField(
                  hintText: 'Enter your phone number',
                  controller: myProvider.phoneController,
                  isReadOnly: myProvider.isLoading,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
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
                      return "Enter your phone number";
                    } else if (val.length < 10) {
                      return "Enter valid phone number";
                    }
                  },
                ),
                ScreenSize.height(20),
                TextfieldLebalText(title: 'Password'),
                ScreenSize.height(8),
                CustomTextField(
                  hintText: 'Enter your password',
                  isObscureText: myProvider.isVisible,
                  isReadOnly: myProvider.isLoading,
                  controller: myProvider.passwordController,
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
                    } else if (val.length < 6) {
                      return 'The password must be at least 6 characters';
                    } else if (val.length > 16) {
                      return 'The password must be less than 16 characters';
                    }
                  },
                ),
                ScreenSize.height(20),
                TextfieldLebalText(title: 'Confirm Password'),
                ScreenSize.height(8),
                CustomTextField(
                  hintText: 'Enter your confirm password',
                  isObscureText: myProvider.isConfirmVisible,
                  isReadOnly: myProvider.isLoading,
                  controller: myProvider.confirmPasswordController,
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
                        AppImages.lockIcon,
                        height: 20,
                      )),
                  suffixWidget: GestureDetector(
                    onTap: () {
                      if (myProvider.isConfirmVisible) {
                        myProvider.isConfirmVisible = false;
                      } else {
                        myProvider.isConfirmVisible = true;
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      child: Image.asset(
                        !myProvider.isConfirmVisible
                            ? AppImages.visibilityOffIcon
                            : AppImages.visibilityIcon,
                        height: 20,
                      ),
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your confirm password";
                    } else if (val.length < 6) {
                      return 'The password must be at least 6 characters';
                    } else if (val.length > 16) {
                      return 'The password must be less than 16 characters';
                    } else if (myProvider.passwordController.text != val) {
                      return "Password does not match";
                    }
                  },
                ),
                ScreenSize.height(20),
                Row(
                  children: [
                    checkBox(myProvider),
                    ScreenSize.width(10),
                    Expanded(
                      child: Text.rich(TextSpan(
                          text: 'By continuing, you agree to our ',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              fontFamily: FontFamily.interRegular,
                              color: AppColor.blackColor),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launchURL(ApiUrl.termsConditionUrl);
                                },
                              text: 'terms of service.',
                              style: const TextStyle(
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
                CustomBtn(
                    title: 'Sign Up',
                    borderRadius: 50,
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      myProvider.isLoading
                          ? null
                          : myProvider.checkValidation();
                    }),
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
                            text: 'Login',
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
      );
    });
  }

  checkBox(SignupProvider provider) {
    return GestureDetector(
      onTap: () {
        if (provider.isCheckBox) {
          provider.updateCheckBox(false);
        } else {
          provider.updateCheckBox(true);
        }
        setState(() {});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 18,
        width: 18,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: provider.isCheckBox == true ? AppColor.appColor : null,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: provider.isCheckBox == true
                    ? AppColor.appColor
                    : const Color(0xff979797))),
        child: provider.isCheckBox == true
            ? const Icon(
                Icons.check,
                color: AppColor.whiteColor,
                size: 14,
              )
            : Container(),
      ),
    );
  }
}
