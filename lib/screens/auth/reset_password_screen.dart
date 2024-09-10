import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/auth_provider/forgot_password_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String otp;
  const ResetPasswordScreen({required this.otp});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    provider.resetPasswordValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        appBar: appBar(title: ''),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                    controller: myProvider.passwordController,
                    isObscureText: myProvider.isPasswordVisible,
                    isReadOnly: myProvider.isLoading,
                    textInputAction: TextInputAction.next,
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
                    suffixWidget: InkWell(
                      onTap: () {
                        if (myProvider.isPasswordVisible) {
                          myProvider.isPasswordVisible = false;
                        } else {
                          myProvider.isPasswordVisible = true;
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: Image.asset(
                          myProvider.isPasswordVisible
                              ? AppImages.visibilityOffIcon
                              : AppImages.visibilityIcon,
                          height: 20,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Enter your password";
                      } else if (!Utils.passwordValidateRegExp(val)) {
                        return 'The password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                      }
                    },
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
                    isReadOnly: myProvider.isLoading,
                    isObscureText: myProvider.isReEnterPasswordVisible,
                    controller: myProvider.reEnterPasswordController,
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
                    suffixWidget: InkWell(
                      onTap: () {
                        if (myProvider.isReEnterPasswordVisible) {
                          myProvider.isReEnterPasswordVisible = false;
                        } else {
                          myProvider.isReEnterPasswordVisible = true;
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        alignment: Alignment.center,
                        child: Image.asset(
                          myProvider.isReEnterPasswordVisible
                              ? AppImages.visibilityOffIcon
                              : AppImages.visibilityIcon,
                          height: 20,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Re-Enter your password";
                      } else if (!Utils.passwordValidateRegExp(val)) {
                        return 'The password should contain at least one uppercase letter, one lowercase letter, one digit, and one special character.';
                      } else if (myProvider.passwordController.text != val) {
                        return 'Password should be same';
                      }
                    },
                  ),
                  ScreenSize.height(34),
                  CustomBtn(
                      title: 'Reset Password',
                      borderRadius: 50,
                      isLoading: myProvider.isLoading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          myProvider.resetPasswordApiFunction(widget.otp);
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
