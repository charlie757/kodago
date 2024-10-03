import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/file_rack/file_rack_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class FileRackProvider extends ChangeNotifier {
  FileRackModel? model;
  bool isLoading = false;
  updateLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  fileRackApiFunction(String groupId) async {
    model = null;
    updateLoading(true);
    var body = {
      "group_id": groupId,
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.fileRackListUrl, body: body);
    updateLoading(false);
    if (response != null && response['status'] == 1) {
      model = FileRackModel.fromJson(response);
    } else {
      model = null;
    }
    notifyListeners();
  }

  Future deleteFileRackApiFunction(
      {required String groupId, required String sheetId}) async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      "group_id": groupId,
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'sheet_id': sheetId
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.deleteFileRackUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      return response;
    } else {}
    notifyListeners();
  }
}
