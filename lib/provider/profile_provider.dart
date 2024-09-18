import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';

// {"status":1,"message":"Login Successfully.","data":{"name":"Ravi","email":"rraviggupta15@gmail.com","phone_number":"9782485409","user_image":"https:\/\/s3.ap-south-1.amazonaws.com\/kodago-s3\/uploads\/UserPic\/1725959000826-croppedimg.jpg","device_id":"sdgdf","device_type":"android","token":"BWBTZFU3UGdWYQFkXTxWNw01V2EBYFQzAjUPMA==","userid":"BWcBMQJlDz0=","user_id":"6073"}}
class ProfileProvider extends ChangeNotifier {
  getProfileApiFunction() async {
    var body = {
      "Authkey": Constants.authkey,
      // "app_version": Constants.appVersion,
      // "api_version": Constants.apiVersion,
      "userid": SessionManager.userId,
      "Token": SessionManager.token
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.getProfileUrl, body: body);
    if (response != null) {}
  }
}
