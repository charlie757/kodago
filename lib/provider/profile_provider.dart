import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';

class ProfileProvider extends ChangeNotifier {
  getProfileApiFunction() async {
    var body = {
      "Authkey": Constants.authkey,
      "app_version": Constants.appVersion,
      "api_version": Constants.apiVersion,
      "userid": SessionManager.userId,
      "Token": SessionManager.token
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.getProfileUrl, body: body);
  }
}
