import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/services/image_picker_service.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kodago/widget/image_bottomsheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddRecordProvider extends ChangeNotifier {
  FileRackDetailsModel? fileRackDetailsModel;
  String groupId = '';
  String sheetId = '';
  String sheetDataId = '';

  viewSheetFeedDataApiFunction(
      {required String groupId,
      required String sheetId,
      required String sheetDataId,
      bool isLoader = true}) async {
    if (isLoader) {
      fileRackDetailsModel = null;
      showLoader(navigatorKey.currentContext!);
    }
    notifyListeners();
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_id': groupId,
      'sheet_id': sheetId,
      'sheet_data_id': sheetDataId,
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.fileRackDetailsUrl, body: body);
    isLoader ? Navigator.pop(navigatorKey.currentContext!) : null;
    if (response != null && response['status'] == 1) {
      fileRackDetailsModel = FileRackDetailsModel.fromJson(response);
    }
    notifyListeners();
  }

  fetchDropDownValues(String fileRackId, String fieldId,
      String masterFileRackId, String formFieldName, int index) async {
    var body = {
      'Authkey': Constants.authkey,
      'Userid': Constants.USER_ID,
      'Token': Constants.TOKEN,
      'group_id': groupId,
      'sheet_id': sheetId,
      'sheet_data_id': sheetDataId,
      'app_version': Constants.appVersion,
      'filerackid': fileRackId,
      'fieldId': fieldId,
      'MasterFilerack_FID': masterFileRackId,
      'form_field_name': formFieldName
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
        body: body, url: ApiUrl.getDependentMasterFileRack);
    if (response != null && response['status'] == 1) {
      print(response);
      if (response['data'] != null) {
        // allData[index].dfoFRList = response['data']['dof_value'];
      }
    }
  }

  Future fetchDependentFileReck(String fileRackId, String fieldId,
      String sheetDataId, String formFieldName, int index) async {
    var body = {
      'Authkey': Constants.authkey,
      'Userid': Constants.USER_ID,
      'Token': Constants.TOKEN,
      // 'group_id': groupId.value,
      // 'sheet_id': sheetId.value,
      'sheet_data_id': sheetDataId,
      'app_version': Constants.appVersion,
      'filerackid': fileRackId,
      'fieldId': fieldId,
      'form_field_name': formFieldName
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
        body: body, url: ApiUrl.getDependentFileRack);
    if (response != null && response['status'] == 1) {
      print(response);
      if (response['data'] != null) {
        // allData[index].controller.text = response['data']['value'];
        return response;
      }
    }
  }
 ///Select Time Method
  Future chooseTime({required BuildContext context,TimeOfDay?selectedTime}) async {
     selectedTime ??= TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false,),
            child: child!,
          );
        },
        initialEntryMode: TimePickerEntryMode.input,
        helpText: 'Select Departure Time',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorInvalidText: 'Provide valid time',
        hourLabelText: 'Select Hour',
        minuteLabelText: 'Select Minute');
    return pickedTime;
  }
 
  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  Future datePicker({ DateTime? selectedDate}) async {
    selectedDate ??= DateTime.now();
    DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData(colorSchemeSeed: AppColor.appColor),
            child: child!,
          );
        },
        helpText: "Select date",
        context: navigatorKey.currentContext!,
        initialDate: selectedDate,
        firstDate: DateTime(1800, 1),
        lastDate: DateTime(now.year, now.month, now.day));
    if (picked != null && picked != DateTime.now()) {
      selectedDate = picked;
      return selectedDate;
    }
  }

 Future uploadMediaApiFunction(
      {required File? filename, required String fileType}) async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      "Authkey": Constants.authkey,
      "Userid": SessionManager.userId,
      "Token": SessionManager.token,
      'file_type': fileType,
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.uploadMediaUrl,
        body: body,
        imgFile: filename,
        imgFieldName: 'files0');
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      return response;
    }
  }

  Future pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Specify the file types you want to allow
      allowedExtensions: ['pdf', 'doc', 'txt'], // List of allowed extensions
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      // documentUrl.value = file.path.toString();
      print('File path: ${file.path}');
      return File(file.path!);
    } else {
      // User canceled the file picking
    }
  }

    Future saveImageToDevice(Uint8List imageBytes, String fileName) async {
    final appDir = await getApplicationDocumentsDirectory();
    final file = File('${appDir.path}/$fileName');
    await file.writeAsBytes(imageBytes);
    return File(file.path);
  }


  bool isReadOnly(String type) {
    if (type == 'date') {
      return true;
    } else if (type == 'time') {
      return true;
    } else if (type == 'dropdown') {
      return true;
    } else if (type == 'list') {
      return true;
    } else {
      return false;
    }
  }

  addImageBottomSheet({required int index,FileRackDetailsModel?fileRackDetailsModel}) {
     var model = fileRackDetailsModel!.data!.sheetFields!;
    imageBottomSheet(
      cameraTap: () {
        ImagePickerService.imagePickerWithoutCrop(ImageSource.camera)
            .then((val) {
              Navigator.pop(navigatorKey.currentContext!);
          if (val != null) {
            uploadMediaApiFunction(filename: val, fileType: 'image').then((val){
              if(val!=null){
                model[index].list = model[index].list+val['data'];
                notifyListeners();
              }
            });
          }
        });
      },
      galleryTap: () {
        ImagePickerService.imagePickerWithoutCrop(ImageSource.gallery)
            .then((val) {
              Navigator.pop(navigatorKey.currentContext!);
          if (val != null) {
            uploadMediaApiFunction(filename: val, fileType: 'image').then((val){
              if(val!=null){
                model[index].list = model[index].list+val['data'];
                notifyListeners();
              }
            });
          }
        });
      },
    );
  }

  addVideoBottomSheet({required int index,FileRackDetailsModel?fileRackDetailsModel}) {
      var model = fileRackDetailsModel!.data!.sheetFields!;
    imageBottomSheet(
      cameraTap: () {
        ImagePickerService.videoPicker(ImageSource.camera)
            .then((val) {
              Navigator.pop(navigatorKey.currentContext!);
          if (val != null) {
            uploadMediaApiFunction(filename: val, fileType: 'video').then((val){
              if(val!=null){
                model[index].list = model[index].list+val['data'];
                notifyListeners();
              }
            });
          }
        });
      },
      galleryTap: () {
        ImagePickerService.videoPicker(ImageSource.gallery)
            .then((val) {
              Navigator.pop(navigatorKey.currentContext!);
          if (val != null) {
            uploadMediaApiFunction(filename: val, fileType: 'video').then((val){
                 if(val!=null){
                model[index].list = model[index].list+val['data'];
                notifyListeners();
              }
            });
          }
        });
      },
    );
  }

}

class FileRModel {
  dynamic name;
  dynamic id;
  dynamic type;
  dynamic nonEditable;
  dynamic fieldPermission;
  dynamic isRequired;
  dynamic value = '';
  dynamic valueList = [];
  dynamic pathList = [];
  dynamic fileNameList = [];
  dynamic latList = [];
  dynamic longList = [];
  dynamic numberValue = '';
  dynamic signatureImage = Uint8List(0);
  dynamic isDependent;
  dynamic geoTagging;
  dynamic isDefaultValue;
  dynamic isDateAllow;
  dynamic isMultiple;
  dynamic fileRackId;
  dynamic fieldId;
  dynamic formFieldName;
  dynamic dependentFileRackFid;
  dynamic valuePrefix;
  dynamic userList;
  dynamic dropdownValues;
  dynamic multiDropDownList;
  dynamic dfoFRList;
  dynamic apiValue;
  dynamic apiValueList;
  dynamic apiImgVidDocList;
  dynamic apiMapList;
  dynamic apiDValue;
  TextEditingController controller = TextEditingController();
  FileRModel(
    this.name,
    this.id,
    this.type,
    this.nonEditable,
    this.fieldPermission,
    this.isRequired,
    this.isDependent,
    this.geoTagging,
    this.isDefaultValue,
    this.isDateAllow,
    this.isMultiple,
    this.fileRackId,
    this.fieldId,
    this.formFieldName,
    this.dependentFileRackFid,
    this.valuePrefix,
    this.userList,
    this.dropdownValues,
    this.multiDropDownList,
    this.dfoFRList,
    this.apiValue,
    this.apiValueList,
    this.apiImgVidDocList,
    this.apiMapList,
    this.apiDValue,
  );
}
