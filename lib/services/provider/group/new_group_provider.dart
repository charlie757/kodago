import 'dart:io';

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

  contactApiFunction(String val) async {
    showLoader(navigatorKey.currentContext!);
    model = null;
    notifyListeners();
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'keyword': val,
      'perpage': '10',
      'start': '0',
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.groupContactsUrl, body: body);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      model = ContactModel.fromJson(response);
    }
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
        AppRoutes.pushReplacementNavigation(const CreateTopicScreen(
          route: 'group',
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
