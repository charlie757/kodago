import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/model/auth_model/auth_model.dart';
import 'package:kodago/screens/auth/otp_verification_screen.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';

class SignupProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = false;
  bool isCheckBox = false;
  bool isLoading = false;

  resetValues() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    isVisible = false;
    isCheckBox = false;
  }

  checkValidation() {
    if (formKey.currentState!.validate()) {
      if (isCheckBox) {
        callAPiFunction();
      } else {
        Utils.errorSnackBar(
            'Please accept the Terms and Conditions to proceed.',
            navigatorKey.currentContext!);
      }
    }
  }

  updateCheckBox(val) {
    isCheckBox = val;
    notifyListeners();
  }

  updateLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  callAPiFunction() async {
    Utils.hideTextField();
    updateLoading(true);
    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "phone_number": phoneController.text,
      "password": passwordController.text,
      "device_type":
          Platform.isIOS ? PlatformType.ios.name : PlatformType.android.name,
      "Authkey": Constants.authkey,
      "app_version": Constants.appVersion,
      "api_version": Constants.apiVersion,
      "device_id": "sdgdf",
      "app_detail": "testing"
    };
    final response = await ApiService.multiPartApiMethod(
      url: ApiUrl.registerUrl,
      body: body,
    );
    updateLoading(false);
    if (response != null) {
      var model = AuthModel.fromJson(response);
      if (model.data != null) {
        SessionManager.setUserId = model.data!.userid;
        AppRoutes.pushCupertinoNavigation(OtpVerificationScreen(
          mobileNumber: phoneController.text,
          route: OtpVerificationScreenRoute.signup.name,
        ));
      }
    }
  }
}
