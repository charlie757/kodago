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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    provider.emailPhoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        appBar: appBar(title: ''),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 59),
          child: Form(
            key: formKey,
            child: Column(
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
                  color: AppColor.b45Color,
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
                  hintText: 'Enter email or phone number',
                  isReadOnly: myProvider.isLoading,
                  controller: myProvider.emailPhoneController,
                  inputFormatters: [
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
                ScreenSize.height(34),
                CustomBtn(
                    title: 'Password Reset',
                    borderRadius: 50,
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        myProvider.callForgotPasswordApiFunction();
                      }
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
