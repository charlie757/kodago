import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/profile_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class ProfileProvider extends ChangeNotifier {

ProfileModel ? profileModel;

  getProfileApiFunction() async {
   profileModel==null? showLoader(navigatorKey.currentContext!):null;
    var body = {
      "Authkey": Constants.authkey,
      "Userid": SessionManager.userId,
      "Token": SessionManager.token
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.getProfileUrl, body: body);
      profileModel==null?  Navigator.pop(navigatorKey.currentContext!):null;
    if (response != null) {
      profileModel = ProfileModel.fromJson(response);
    }
    else{
      profileModel=null;
    }
    notifyListeners();
  }
}
