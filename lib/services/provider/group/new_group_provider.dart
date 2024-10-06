import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/model/group/contact_model.dart';
import 'package:kodago/presentation/dashboard/group/create_topic_screen.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

void runContactApiIsolate(List<dynamic> args) async {
  var sendPort = args[0] as SendPort;
  var body = args[1];

  // Simulate API call inside the isolate
  final response = await ApiService.multiPartApiMethod(
    url: ApiUrl.groupContactsUrl,
    body: body,
  );

  // Pass the result back to the main thread
  if (response != null && response['status'] == 1) {
    sendPort.send(ContactModel.fromJson(response));
  } else {
    sendPort.send(null);
  }
  Isolate.exit(sendPort, null); // Sending null as a message if you wish
}

class NewGroupProvider extends ChangeNotifier {
  bool isShow = false;
  bool isSearchEnable = false;
  final groupNameController = TextEditingController();
  File? img;
  clearValues() {
    isSearchEnable = false;
  }

  ContactModel? model;
  List groupList = [
    {
      'img': 'assets/dummay/Oval (3).png',
      'name': 'Manish Saini',
      'isSelected': false
    },
    {
      'img': 'assets/dummay/Oval (4).png',
      'name': 'Sanjana Bhilwara',
      'isSelected': false
    },
    {
      'img': 'assets/dummay/Oval (5).png',
      'name': 'Ravi Jaipur',
      'isSelected': false
    },
    {
      'img': 'assets/dummay/Oval (3).png',
      'name': 'Manish Saini',
      'isSelected': false
    },
    {
      'img': 'assets/dummay/Oval (4).png',
      'name': 'Sanjana Bhilwara',
      'isSelected': false
    },
    {
      'img': 'assets/dummay/Oval (5).png',
      'name': 'Ravi Jaipur',
      'isSelected': false
    },
  ];

  removeSelectedContact(String id) {
    for (int i = 0; i < model!.addedList.length; i++) {
      if (model!.addedList[i].id == id) {
        model!.addedList.removeAt(i);
      }
      notifyListeners();
    }
  }

  addContact(var contactModel) {
    model!.addedList.add(contactModel);
    notifyListeners();
  }

  unselectedContacts(String id) {
    for (int i = 0; i < model!.data!.length; i++) {
      if (model!.data![i].id == id) {
        model!.data![i].isSelected = false;
      }
    }
    for (int i = 0; i < model!.addedList.length; i++) {
      if (model!.addedList[i].id == id) {
        model!.addedList.removeAt(i);
      }
      notifyListeners();
    }
  }

  void contactApiFunction(String val, {bool showLoading = false}) async {
    model = null;
    notifyListeners();
    showLoading ? showLoader(navigatorKey.currentContext!) : null;
    var receivePort = ReceivePort();
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'keyword': val,
      'perpage': '10',
      'start': '0',
    };

    await Isolate.spawn(runContactApiIsolate, [receivePort.sendPort, body]);
    var result = await receivePort.first;
    showLoading ? Navigator.pop(navigatorKey.currentContext!) : null;

    // Handle the response (UI Thread)
    if (result != null) {
      model = result as ContactModel;
    } else {
      // Handle failure case
      model = null;
    }

    // Notify listeners to update the UI
    notifyListeners();
  }

  createGroupApiFunction() async {
    String id = model!.addedList.map((e) => e.id).join(',');
    print(id);
    showLoader(navigatorKey.currentContext!);
    notifyListeners();
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_name': groupNameController.text,
      'users': id,
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.createGroupUrl, body: body, imgFile: img);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      Future.delayed(const Duration(seconds: 1), () {
        AppRoutes.pushReplacementNavigation(CreateTopicScreen(
          route: 'group',
          groupId: response['data']['id'].toString(),
        ));
      });
    }
    notifyListeners();
  }

  addMemberApiFunction(String groupId) async {
    String id = model!.addedList.map((e) => e.id).join(',');
    showLoader(navigatorKey.currentContext!);
    notifyListeners();
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_id': groupId,
      'user_ids': id
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.addMemberUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      Navigator.pop(navigatorKey.currentContext!);
    }
    notifyListeners();
  }
}
