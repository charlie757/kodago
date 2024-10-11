import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/group/group_details_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class GroupDetailsProvider extends ChangeNotifier {
  GroupDetailsModel? model;
  GroupDetailsModel? globalGroupDetailsModel;
  final nameController = TextEditingController();
  String memberId = '';
  String groupCreatedName = '';
  bool isCurrentUserGroupAdmin = false;

updateGroupCreatedName(String val){
  groupCreatedName = val;
  notifyListeners();
}

clearValues(){
  memberId='';
  groupCreatedName='';
}

updateMemberList(){
  model!.data!.groupDetail!.members = globalGroupDetailsModel!.data!.groupDetail!.members;
  notifyListeners();
}

  groupDetailsApiFunction(String groupId, {bool isShowLoader = true}) async {
    memberId = '';
    if (isShowLoader) {
      model = null;
      globalGroupDetailsModel= null;
      notifyListeners();
      showLoader(navigatorKey.currentContext!);
    }
    var body = {
      "group_id": groupId,
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.groupDetailsUrl, body: body);
    isShowLoader ? Navigator.pop(navigatorKey.currentContext!) : null;
    if (response != null && response['status'] == 1) {
      model = GroupDetailsModel.fromJson(response);
      globalGroupDetailsModel = GroupDetailsModel.fromJson(response);
      getMemberId();
      if(model!.data!.groupDetail!.members!.isNotEmpty&&model!.data!.groupDetail!.members!=null){
     updateGroupCreatedName(model!.data!.groupDetail!.members![0].name);
      }
    
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
      'action': type==GroupAction.removeadmin.name?'remove-admin':type,
      /// remove or makeadmin or remove_admin
    };
    print(body);
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

   getMemberId() async {
    isCurrentUserGroupAdmin=false;
    for (int i = 0; i < model!.data!.groupDetail!.members!.length; i++) {
      var membermodel = model!.data!.groupDetail!.members![i];
      if (membermodel.id.toString() ==
          SessionManager.userIntId) {
            memberId = membermodel.memberJoinId;
            if(membermodel.id.toString() ==
          SessionManager.userIntId&&membermodel.isAdmin.toString()=='1'){
              isCurrentUserGroupAdmin=true;
            }
            break;
      }
    
    }}
      searchFunction(String val) async {
    model!.data!.groupDetail!.members = [];
    if (!globalGroupDetailsModel!.data!.groupDetail!.members
        .toString()
        .toLowerCase()
        .contains(val.toLowerCase())) {
      model!.data!.groupDetail!.members!.clear();
      print('No data found');
      // noDataFound = true;
    }

    globalGroupDetailsModel!.data!.groupDetail!.members!.forEach((element) {
      String lowerCaseVal = val.toLowerCase();
      String lowerCaseName =
          element.name.isNotEmpty ? element.name.toLowerCase() : "";

      if (val.isEmpty) {
        model!.data!.groupDetail!.members!.clear();
        // noDataFound = false;
        notifyListeners();
      } else if (lowerCaseName.contains(lowerCaseVal)) {
        // noDataFound = false;
        print("element...${element.name}");
        model!.data!.groupDetail!.members!.add(element);
      }
    });

    notifyListeners();
  } 



}
