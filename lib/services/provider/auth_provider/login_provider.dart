import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/model/auth_model/auth_model.dart';
import 'package:kodago/model/auth_model/verify_model.dart';
import 'package:kodago/presentation/auth/otp_verification_screen.dart';
import 'package:kodago/presentation/dashboard/dashboard_screen.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  updateLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  resetValues() {
    emailController.clear();
    passwordController.clear();
    isVisible = true;
  }

  callAPiFunction() async {
    Utils.hideTextField();
    Constants.is401Error = false;
    updateLoading(true);
    var body = {
      "email": emailController.text,
      "password": passwordController.text,
      "device_type":
          Platform.isIOS ? PlatformType.ios.name : PlatformType.android.name,
      "Authkey": Constants.authkey,
      "app_version": Constants.appVersion,
      "api_version": Constants.apiVersion,
      "device_id": "sdgdf",
      "app_detail": "testing"
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
      url: ApiUrl.loginUrl,
      body: body,
    );
    updateLoading(false);
    if (response != null) {
      final model = AuthModel.fromJson(response);
      if (model.verifyOtp != null && model.verifyOtp.toString() == '1') {
        AppRoutes.pushCupertinoNavigation(OtpVerificationScreen(
          mobileNumber: response['data']['phone_number'],
          route: OtpVerificationScreenRoute.login.name,
        ));
      } else {
        final verfiyModel = VerifyModel.fromJson(response);
        SessionManager.setToken = verfiyModel.data!.token ?? '';
        SessionManager.setUserId = verfiyModel.data!.userid;
        resetValues();
        AppRoutes.pushReplacementNavigation(const DashboardScreen());
      }
    }
  }
}
