import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class FileRackDetailsProvider extends ChangeNotifier {

FileRackDetailsModel? fileRackDetailsModel;
  fileRackDetailsApiFunction(
      {required String groupId,
      required String sheetId,
      required String sheetDataId}) async {
        fileRackDetailsModel = null;
        notifyListeners();
    showLoader(navigatorKey.currentContext!);
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'sheet_id': sheetId,
      "group_id": groupId,
      "sheet_data_id":
       sheetDataId,
    };
    print("bodu...$body");
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.fileRackDetailsUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      fileRackDetailsModel =FileRackDetailsModel.fromJson(response);
    } else {}
    notifyListeners();
  }
}
