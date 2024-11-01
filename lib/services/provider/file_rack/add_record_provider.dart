import 'dart:convert';
import 'dart:developer';
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
  Map jsonObject = {};

  List<CustomModel> allData = [];
  setData(FileRackDetailsModel? fileRackDetailsModel) {
    allData.clear();
    var model = fileRackDetailsModel!.data!.sheetFields!;
    allData = model.map<CustomModel>((item) {
      return CustomModel(
        id: item.id,
        fieldId: '',
        fieldValue: '',
        depdntFieldIdValue: '',
        fieldName: item.name,
        fieldType: item.type,
        nonEditable: item.nonEditable,
        isRequired: item.isRequired,
        dropdownValues: item.dropdownValues,
        listColsValues: '',
        geoTagging: item.geoTagging,
        fileRackId: item.fileRackId,
        isMultiple: item.isMultiple,
        dFOFRFields: item.dFOFRFields,
        isDependent: item.isDependent,
        valuePrefix: item.valuePrefix,
        isDefaultValue: item.isDefaultValue,
        isDateAllow: item.isDateAllow,
        dValue: '',
        fieldPermission: '',
      );
    }).toList();
    notifyListeners();
  }

  setEditData(FileRackDetailsModel? fileRackDetailsModel, int index) {
    var model = fileRackDetailsModel!.data!.sheetData!.dbdata![index];
    
    allData = model.data!.map<CustomModel>((item) {
      if(item.fieldType=='DFOFR'){
        print("vb  ..${item.fieldType}");
      }
      return CustomModel(
        id: item.fieldId, /// this id will field id 
        fieldId: item.fieldId,
        fieldValue: item.fieldValue,
        depdntFieldIdValue: item.depdntFieldIdValue,
        fieldName: item.fieldName,
        fieldType: item.fieldType,
        nonEditable: item.nonEditable,
        isRequired: '',
        dropdownValues: item.dropdownValues,
        listColsValues: item.listColsValues,
        geoTagging: item.geoTagging,
        fileRackId: item.fileRackId,
        isMultiple: item.isMultiple,
        dFOFRFields: item.dFOFRFields,
        isDependent: item.isDependent,
        valuePrefix: item.valuePrefix,
        isDefaultValue: item.isDefaultValue,
        isDateAllow: item.isDateAllow,
        dValue: item.dValue,
        fieldPermission: item.fieldPermission,
        fullURL: item.fullURL,
        sheetmembers: item.sheetmembers,
        dofValue: item.dofValue,
        filesData: item.filesData
      );
    }).toList();

    for (int i = 0; i < allData.length; i++) {
      if (allData[i].fieldType == 'text' ||
          allData[i].fieldType == 'date' ||
          allData[i].fieldType == 'number' ||
          allData[i].fieldType == 'time' ||
          allData[i].fieldType=='Heading') {
        allData[i].controller.text = allData[i].fieldValue;
      } 
      else if (allData[i].fieldType == 'dropdown') {
        //// check for multiple dropdown values
        if (allData[i].isMultiple.toString() == '1'&&allData[i].dValue.toString().isNotEmpty&&
        !allData[i].dValue.toString().contains('-')) {
          allData[i].list = allData[i]
              .dValue
              .toString()
              .split(',')
              .map((value) => value.trim())
              .toList();
        } else {
          allData[i].selectedDropDownValue = allData[i].dValue.toString().isEmpty||
          allData[i].dValue=='null'||allData[i].dValue.toString().contains('-')
          ?null:allData[i].dValue;
        }
      }
      else if(allData[i].fieldType=='signature'){
        allData[i].image = allData[i].fullURL;
      }
      else if(allData[i].fieldType=='userlist'){
        allData[i].selectedDropDownValue = allData[i].fieldValue.toString().isEmpty||
        allData[i].fieldValue=='null'||allData[i].fieldValue.toString().contains('-')
        ?null:allData[i].fieldValue;
        for(int j=0;j<allData[i].sheetmembers!.length;j++){
          allData[i].list.add(allData[i].sheetmembers![j].name);
        }
      } 
      else if(allData[i].fieldType=='list'){
        allData[i].selectedDropDownValue = allData[i].dValue.toString().isEmpty||
        allData[i].dValue=='null'||allData[i].dValue.toString().contains('-')?null:allData[i].dValue;
      }
      else if(allData[i].fieldType=='DFOFR'){
        allData[i].selectedDropDownValue = allData[i].dValue.toString().isEmpty||
        allData[i].dValue.toString()=='null'||allData[i].dValue.toString().contains('-')?null:allData[i].dValue;
           if(allData[i].dofValue!=null&&allData[i].dofValue.toString().isNotEmpty||allData[i].dValue!='null'){
       for(int j=0;j<allData[i].dofValue!.length;j++){
          allData[i].list.add(allData[i].dofValue![j]['field_value']);
        }
        }
      }
      else if(allData[i].fieldType=='image'||allData[i].fieldType=='video'||allData[i].fieldType=='document'){
        if(allData[i].filesData!.isNotEmpty){
          for(int j=0;j<allData[i].filesData!.length;j++){
            allData[i].list.add({
              'file_name':allData[i].filesData![j].fileName,
              'path':allData[i].filesData![j].mainUrl
            });
        }
        }
      }
    }
    notifyListeners();
  }

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
  Future chooseTime(
      {required BuildContext context, TimeOfDay? selectedTime}) async {
    selectedTime ??= TimeOfDay.now();
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: false,
            ),
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
  Future datePicker({DateTime? selectedDate}) async {
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

  checkValidation(){
    for(int i=0;i<allData.length;i++){

    }
  }

  sendRackDetailsFunction(
      {required String groupId,
      required String sheetId,
      required String sheetDataId,}) async {
    convertDataInJson();
    var body = {
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'Authkey': Constants.authkey,
      'group_id': groupId,
      'sheet_id': sheetId,
      'field': jsonObject.toString(),
      'geo_tagging': "",
      'extra_field_value': '',
      'sheet_data_id': sheetDataId,
    };
    log(jsonEncode(body));
    final response = await ApiService.multiPartApiMethod(
        body: body, url: ApiUrl.saveRecordUrl);
    if (response != null) {}
  }


  convertDataInJson() {
    // var model = fileRachModel!.data!.sheetFields!;
    for (int i = 0; i < allData.length; i++) {
      var model = allData[i];
      if (model.fieldType == 'text'||model.fieldType=='Heading'||model.fieldType == 'time'
      ||model.fieldType == 'date'||model.fieldType == 'number') {
        jsonObject[jsonEncode(model.id)] =
            jsonEncode(model.controller.text.toString());
      }
      if (model.fieldType == 'location') {
        jsonObject[jsonEncode(model.id)] = {
          jsonEncode('latitude'): model.latList.toString(),
          jsonEncode('longitude'): model.lngList.toString(),
        };
      }
      if (model.fieldType == 'document'||model.fieldType == 'video'||model.fieldType == 'image') {
        List list = [];
        for (int j = 0; j < model.list.length; j++) {
          list.add(model.list[j]['file_name']);
        }
        jsonObject[jsonEncode(model.id)] = list.toString();
      }
      
      if (model.fieldType == 'signature') {
        if(model.image!=null){
        jsonObject[jsonEncode(model.id)] =
            jsonEncode(model.image.toString());
        }
      }

      if (model.fieldType == 'dropdown') {
        if (model.isMultiple == '1') {
          List list = [];
          for (int j = 0; j < model.list.length; j++) {
            list.add(jsonEncode(model.list[j]));
          }
          jsonObject[jsonEncode(model.id)] = list;
        } else {
          if(model.selectedDropDownValue!=null){
          model.list
              .add(jsonEncode(model.selectedDropDownValue.toString()));
          jsonObject[jsonEncode(model.id)] = model.list.toString();
          }
        }
      }
      if (model.fieldType == 'DFOFR') {
        List list = [];
        if(model.selectedDropDownValue!=null){
          list.add(jsonEncode(model.selectedDropDownValue.toString()));
        }
        jsonObject[jsonEncode(model.id)] = list;
      }
      if (model.fieldType == 'autoId') {
        jsonObject[jsonEncode(model.id)] =
            jsonEncode(model.valuePrefix.toString());
      }
      
      if (model.fieldType == 'userlist') {
        if(model.selectedDropDownValue!=null){
          jsonObject[jsonEncode(model.id)] =
            jsonEncode(model.selectedDropDownValue.toString());
        }
      }
    }
    log(jsonEncode(jsonObject));
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

  addImageBottomSheet(
      {required int index, FileRackDetailsModel? fileRackDetailsModel}) {
    var model = allData[index];
    imageBottomSheet(
      cameraTap: () {
        ImagePickerService.imagePickerWithoutCrop(ImageSource.camera)
            .then((val) {
          Navigator.pop(navigatorKey.currentContext!);
          if (val != null) {
            uploadMediaApiFunction(filename: val, fileType: 'image')
                .then((val) {
              if (val != null) {
                model.list = model.list + val['data'];
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
            uploadMediaApiFunction(filename: val, fileType: 'image')
                .then((val) {
              if (val != null) {
                model.list = model.list + val['data'];
                notifyListeners();
              }
            });
          }
        });
      },
    );
  }

  addVideoBottomSheet(
      {required int index, FileRackDetailsModel? fileRackDetailsModel}) {
    var model = allData[index];
    imageBottomSheet(
      cameraTap: () {
        ImagePickerService.videoPicker(ImageSource.camera).then((val) {
          Navigator.pop(navigatorKey.currentContext!);
          if (val != null) {
            uploadMediaApiFunction(filename: val, fileType: 'video')
                .then((val) {
              if (val != null) {
                model.list = model.list + val['data'];
                notifyListeners();
              }
            });
          }
        });
      },
      galleryTap: () {
        ImagePickerService.videoPicker(ImageSource.gallery).then((val) {
          Navigator.pop(navigatorKey.currentContext!);
          if (val != null) {
            uploadMediaApiFunction(filename: val, fileType: 'video')
                .then((val) {
              if (val != null) {
                model.list = model.list + val['data'];
                notifyListeners();
              }
            });
          }
        });
      },
    );
  }

  geoTagingCameraPicker(
      {required int index,
      FileRackDetailsModel? fileRackDetailsModel,
      required String type}) {
    var model = allData[index];
    if (type == 'video') {
      ImagePickerService.videoPicker(ImageSource.camera).then((val) {
        Navigator.pop(navigatorKey.currentContext!);
        if (val != null) {
          uploadMediaApiFunction(filename: val, fileType: 'video').then((val) {
            if (val != null) {
              model.list = model.list + val['data'];
              notifyListeners();
            }
          });
        }
      });
    } else {
      ImagePickerService.imagePickerWithoutCrop(ImageSource.camera).then((val) {
        Navigator.pop(navigatorKey.currentContext!);
        if (val != null) {
          uploadMediaApiFunction(filename: val, fileType: 'image').then((val) {
            if (val != null) {
              model.list = model.list + val['data'];
              notifyListeners();
            }
          });
        }
      });
    }
  }
}
class CustomModel {
  dynamic id;
  dynamic fieldId;
  dynamic fieldValue;
  dynamic depdntFieldIdValue;
  dynamic fieldName;
  dynamic fieldType;
  dynamic nonEditable;
  dynamic isRequired;
  dynamic dropdownValues;
  dynamic listColsValues;
  dynamic geoTagging;
  dynamic fileRackId;
  dynamic isMultiple;
  dynamic dFOFRFields;
  dynamic isDependent;
  dynamic valuePrefix;
  dynamic isDefaultValue;
  dynamic isDateAllow;
  dynamic dValue;
  dynamic fieldPermission;
  dynamic extraFieldValueArray;
  List<FilesData>? filesData;
  dynamic fullURL;
  dynamic dofValue;
  List<Sheetmembers>? sheetmembers;
   TextEditingController controller = TextEditingController();/// for add record
  List list = []; /// for add record
  List latList = []; /// for add record
  List lngList = [];/// for add record
  DateTime? selectedDate; /// for add record
  TimeOfDay?selectedTime; /// for add record
  dynamic image;/// for add record
  String? selectedDropDownValue; /// for add record 
  CustomModel(
      {required this.id,
      required this.fieldId,
      required this.fieldValue,
      required this.depdntFieldIdValue,
      required this.fieldName,
      required this.fieldType,
      required this.nonEditable,
      required this.isRequired,
      required this.dropdownValues,
      required this.listColsValues,
      required this.geoTagging,
      required this.fileRackId,
      required this.isMultiple,
      required this.dFOFRFields,
      required this.isDependent,
      required this.valuePrefix,
      required this.isDefaultValue,
      required this.isDateAllow,
      required this.dValue,
      required this.fieldPermission,
      this.extraFieldValueArray,
      this.filesData,
      this.fullURL,
      this.dofValue,
      this.sheetmembers});
}
