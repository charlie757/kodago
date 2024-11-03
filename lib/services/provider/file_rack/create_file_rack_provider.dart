import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/extension.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class CreateFileRackProvider extends ChangeNotifier {
  List<CreateFileRackModel> recordList = [];
  List deleteRecordId=[];
  final formNameController = TextEditingController();
  FileRackDetailsModel? fileRackDetailsModel;
  ScrollController controller = ScrollController();

  clearValues() {
    controller = ScrollController();
    recordList.clear();
    deleteRecordId.clear();
    formNameController.clear();
  }

  addRecord() {
    CreateFileRackModel model = CreateFileRackModel();
    recordList.add(model);
    scrollDown();
    notifyListeners();
  }

  void scrollDown() {
  controller.animateTo(
    controller.position.maxScrollExtent*2,
    duration:const Duration(seconds: 1),
    curve: Curves.fastOutSlowIn,
  );
}


  List list = [
    {'title': 'Location', 'img': AppImages.locationFileRackIcon},
    {'title': 'Text', 'img': AppImages.textFileRackIcon},
    {'title': 'Image', 'img': AppImages.imageFileRackIcon},
    {'title': 'Date', 'img': AppImages.dateFileRackIcon},
    {'title': 'Document', 'img': AppImages.documentFileRackIcon},
    {'title': 'Video', 'img': AppImages.videoFileRackIcon},
    {'title': 'Signature', 'img': AppImages.signatureFileRackIcon},
    {'title': 'Dropdown', 'img': AppImages.dropdownFileRackIcon},
    {'title': 'Number', 'img': AppImages.numberFileRackIcon},
    {
      'title': 'Data from other file rack',
      'img': AppImages.dateFromOtherFileRackIcon
    },
    {'title': 'Auto Id', 'img': AppImages.autoIdFileRackIcon},
    {'title': 'Time', 'img': AppImages.timeFileRackIcon},
    {'title': 'User list', 'img': AppImages.userListFileRackIcon},
  ];

  fileRackDetailsApiFunction(
      {required String groupId,
      required String sheetId,
      required String sheetDataId,
      bool isLoader = true}) async {
    if (isLoader == true) {
      fileRackDetailsModel = null;
      notifyListeners();
      showLoader(navigatorKey.currentContext!);
    }
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'sheet_id': sheetId,
      "group_id": groupId,
      "sheet_data_id": sheetDataId,
    };
    print("bodu...$body");
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.fileRackDetailsUrl, body: body);
    isLoader ? Navigator.pop(navigatorKey.currentContext!) : null;
    if (response != null && response['status'] == 1) {
      fileRackDetailsModel = FileRackDetailsModel.fromJson(response);
      for (int i = 0;
          i < fileRackDetailsModel!.data!.sheetFields!.length;
          i++) {
        CreateFileRackModel model = CreateFileRackModel();
        model.dataTypeController.text = fileRackDetailsModel!
            .data!.sheetFields![i].type
            .toString()
            .capitalize();
        model.fieldController.text =
            fileRackDetailsModel!.data!.sheetFields![i].name;
        model.fieldId = fileRackDetailsModel!.data!.sheetFields![i].id;
        model.isMandatory = int.parse(
            fileRackDetailsModel!.data!.sheetFields![i].isRequired.toString());
        // model.isLock = int.parse(fileRackDetailsModel!.data!.sheetFields![i].is.toString());
        model.nonEditable = int.parse(
            fileRackDetailsModel!.data!.sheetFields![i].nonEditable.toString());
        model.defaultData = int.parse(fileRackDetailsModel!
            .data!.sheetFields![i].isDefaultValue
            .toString());
        recordList.add(model);
      }
    } else {}
    notifyListeners();
  }

  addFileRackApiFunction({required String groupId, List? list}) async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      "group_id": groupId,
      "sheet_name": formNameController.text,
      "fields": json.encode(list)
    };
    log(jsonEncode(body));
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.createFileRackUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      Navigator.pop(navigatorKey.currentContext!);
    }
  }

  updateFileRackApiFunction(
      {required String sheetId, required String groupId, List? list}) async {
       String  deleteId =deleteRecordId.join(',');
    showLoader(navigatorKey.currentContext!);
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'sheet_id': sheetId,
      "group_id": groupId,
      "sheet_name": formNameController.text,
      "fields": json.encode(list),
      "deletedColumn":deleteId
    };
    log(jsonEncode(body));
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.updateFileRackUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      Navigator.pop(navigatorKey.currentContext!);
    }
  }

  callCreateRecod(String groupId) {
    List list = [];
    for (int i = 0; i < recordList.length; i++) {
      list.add({
        'name': recordList[i].fieldController.text,
        'type': recordList[i].dataTypeController.text.toLowerCase(),
        'is_lock': recordList[i].isLock,
        'is_required': recordList[i].isMandatory,
        "non_editable": recordList[i].nonEditable,
        "is_default_value": recordList[i].defaultData,
      });
    }
    addFileRackApiFunction(groupId: groupId, list: list);
  }

  callUpdateRecod(String groupId, String sheetId) {
    List list = [];
    for (int i = 0; i < recordList.length; i++) {
      list.add({
        'name': recordList[i].fieldController.text,
        'type': recordList[i].dataTypeController.text.toLowerCase(),
        'fld_id': recordList[i].fieldId,
        'is_lock': recordList[i].isLock,
        'is_required': recordList[i].isMandatory,
        "non_editable": recordList[i].nonEditable,
        "is_default_value": recordList[i].defaultData,
      });
    }
    updateFileRackApiFunction(groupId: groupId, list: list, sheetId: sheetId);
  }
}

class CreateFileRackModel {
  TextEditingController fieldController = TextEditingController();
  TextEditingController dataTypeController = TextEditingController();
  bool isHightlight = false;
  dynamic fieldId;
  dynamic isMandatory = 0;
  dynamic isLock = 0;
  dynamic nonEditable = 0;
  dynamic defaultData = 0;
  dynamic dataTypeIndex = -1;
}
