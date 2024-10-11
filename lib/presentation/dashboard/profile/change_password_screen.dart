import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/profile_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/uitls/white_space_formatter.dart';
import 'package:kodago/widget/appBar_leading.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with MediaQueryScaleFactor {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<ProfileProvider>(context, listen: false);
    provider.currentPasswordController.clear();
    provider.passwordController.clear();
    provider.confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
            appBar: appBarWithLeading(title: "Change Password"),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 19, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: 'Current Password',
                      controller: myProvider.currentPasswordController,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        WhiteSpaceFormatter(),
                        FilteringTextInputFormatter.deny(
                            RegExp(Utils.regexToRemoveEmoji)),
                      ],
                      isObscureText: myProvider.isCurrentPasswordVisible,
                      suffixWidget:
                          suffixWidget(myProvider.isCurrentPasswordVisible, () {
                        if (myProvider.isCurrentPasswordVisible) {
                          myProvider.updateCurrentPasswordVisble(false);
                        } else {
                          myProvider.updateCurrentPasswordVisble(true);
                        }
                      }),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter your current password";
                        } else if (val.length < 6) {
                          return 'The password must be at least 6 characters';
                        } else if (val.length > 16) {
                          return 'The password must be less than 16 characters';
                        }
                      },
                    ),
                    ScreenSize.height(20),
                    CustomTextField(
                      hintText: 'New Password',
                      controller: myProvider.passwordController,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        WhiteSpaceFormatter(),
                        FilteringTextInputFormatter.deny(
                            RegExp(Utils.regexToRemoveEmoji)),
                      ],
                      isObscureText: myProvider.isPasswordVisible,
                      suffixWidget:
                          suffixWidget(myProvider.isPasswordVisible, () {
                        if (myProvider.isPasswordVisible) {
                          myProvider.updatePasswordVisble(false);
                        } else {
                          myProvider.updatePasswordVisble(true);
                        }
                      }),
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
                    CustomTextField(
                      hintText: 'Confirm Password',
                      controller: myProvider.confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        WhiteSpaceFormatter(),
                        FilteringTextInputFormatter.deny(
                            RegExp(Utils.regexToRemoveEmoji)),
                      ],
                      isObscureText: myProvider.isConfirmPasswordVisible,
                      suffixWidget:
                          suffixWidget(myProvider.isConfirmPasswordVisible, () {
                        if (myProvider.isConfirmPasswordVisible) {
                          myProvider.updateConfirmPasswordVisble(false);
                        } else {
                          myProvider.updateConfirmPasswordVisble(true);
                        }
                      }),
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Enter your new password";
                        } else if (val.length < 6) {
                          return 'The password must be at least 6 characters';
                        } else if (val.length > 16) {
                          return 'The password must be less than 16 characters';
                        } else if (val != myProvider.passwordController.text) {
                          return "Password should be same";
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 19, right: 20, bottom: 30),
              child: CustomBtn(
                  title: 'Save',
                  isLoading: myProvider.isLoading,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      myProvider.changePasswordApiFunction();
                    }
                  }),
            )),
      );
    });
  }

  Widget suffixWidget(bool isVisible, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        child: Image.asset(
          !isVisible ? AppImages.visibilityOffIcon : AppImages.visibilityIcon,
          height: 20,
        ),
      ),
    );
  }
}
