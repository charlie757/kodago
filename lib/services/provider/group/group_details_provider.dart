import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/group/group_details_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class GroupDetailsProvider extends ChangeNotifier {
  GroupDetailsModel? model;
  final nameController = TextEditingController();
  groupDetailsApiFunction(String groupId, {bool isShowLoader = true}) async {
    if (isShowLoader) {
      model = null;
      notifyListeners();
      showLoader(navigatorKey.currentContext!);
    }
    var body = {
      "group_id": groupId,
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.groupDetailsUrl, body: body);
    isShowLoader ? Navigator.pop(navigatorKey.currentContext!) : null;
    if (response != null && response['status'] == 1) {
      model = GroupDetailsModel.fromJson(response);
    }
    notifyListeners();
  }

  exitGroupApiFunction(String groupId, String uniqueId, String type) async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      "group_id": groupId,
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'uniqueId': uniqueId,
      'action': type,

      /// remove or makeadmin
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.exitGroupUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      Navigator.pop(navigatorKey.currentContext!);
      groupDetailsApiFunction(groupId, isShowLoader: false);
    }
    notifyListeners();
  }

  updateGroupNameApiFunction(
    String groupId,
  ) async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      "group_id": groupId,
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_name': nameController.text,
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.updateGroupNameUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      Navigator.pop(navigatorKey.currentContext!);
    }
    notifyListeners();
  }

  updateGroupImageApiFunction(String groupId, File imgFile) async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      "group_id": groupId,
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.updateGroupImageUrl, body: body, imgFile: imgFile);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      groupDetailsApiFunction(groupId, isShowLoader: false);
      // Navigator.pop(navigatorKey.currentContext!);
    }
    notifyListeners();
  }
}
