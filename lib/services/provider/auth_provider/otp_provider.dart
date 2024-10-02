import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/model/auth_model/verify_model.dart';
import 'package:kodago/presentation/auth/reset_password_screen.dart';
import 'package:kodago/presentation/dashboard/dashboard_screen.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class OtpProvider extends ChangeNotifier {
  final otpController = TextEditingController();
  int counter = 30;
  Timer? timer;
  bool resend = false;
  bool isLoading = false;
  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  String resendApiUrl = '';

  startTimer() {
    //shows timer
    counter = 30; //time counter
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter > 0 ? counter-- : timer.cancel();
      notifyListeners();
    });
  }

  resetValues() {
    otpController.clear();
    resend = false;
  }

  checkValidation(String route) {
    route == OtpVerificationScreenRoute.forgot.name
        ? AppRoutes.pushCupertinoNavigation(ResetPasswordScreen(
            otp: otpController.text,
          ))
        : verifyApiFunction();
  }

  resendApiFunction(String number) async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      "userid": SessionManager.userId,
      "PhoneNumber": number,
      "Authkey": Constants.authkey,
      "app_version": Constants.appVersion,
      "api_version": Constants.apiVersion,
    };
    final response =
        await ApiService.multiPartApiMethod(url: resendApiUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null) {
      startTimer();
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
    }
  }

  verifyApiFunction() async {
    updateLoading(true);
    var body = {
      "userid": SessionManager.userId,
      "otpcode": otpController.text,
      "Authkey": Constants.authkey,
      "app_version": Constants.appVersion,
      "api_version": Constants.apiVersion,
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.verifyOtpUrl, body: body);
    updateLoading(false);
    if (response != null && response['status'] == 1) {
      final verfiyModel = VerifyModel.fromJson(response);
      SessionManager.setToken = verfiyModel.data!.token ?? '';
      SessionManager.setUserId = verfiyModel.data!.userid;
      AppRoutes.pushReplacementNavigation(DashboardScreen());
    }
  }
}
