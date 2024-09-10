import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/screens/auth/otp_verification_screen.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final emailPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isReEnterPasswordVisible = false;
  bool isLoading = false;

  updateLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  resetPasswordValues() {
    passwordController.clear();
    reEnterPasswordController.clear();
    isPasswordVisible = false;
    isReEnterPasswordVisible = false;
  }

  callForgotPasswordApiFunction() async {
    Utils.hideTextField();
    updateLoading(true);
    var body = {
      "Authkey": Constants.authkey,
      "app_version": Constants.appVersion,
      "api_version": Constants.apiVersion,
      "email": emailPhoneController.text
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.forgotPasswordUrl, body: body);
    updateLoading(false);
    if (response != null && response['status'] == 1) {
      SessionManager.setUserId = response['data']['userid'];
      AppRoutes.pushCupertinoNavigation(OtpVerificationScreen(
        mobileNumber: emailPhoneController.text,
        route: OtpVerificationScreenRoute.forgot.name,
      ));
    }
  }

  resetPasswordApiFunction(String otp) async {
    Utils.hideTextField();
    updateLoading(true);
    var body = {
      "Authkey": Constants.authkey,
      "app_version": Constants.appVersion,
      "api_version": Constants.apiVersion,
      "userid": SessionManager.userId,
      "otp": otp,
      "password": passwordController.text
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.forgotResetApiUrl, body: body);
    updateLoading(false);
    if (response != null && response['status'] == 1) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      Navigator.pop(navigatorKey.currentContext!);
      Navigator.pop(navigatorKey.currentContext!);
      Navigator.pop(navigatorKey.currentContext!);
    }
  }
}
