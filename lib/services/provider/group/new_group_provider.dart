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
  final groupNameController = TextEditingController();
  File? img;

  final int chunkSize = 100; // Size of each chunk
  bool isLoading = false;
  int currentIndex = 0;

  // ContactModel? model;
  List contactList = [];
  List addedList = [];

  removeSelectedContact(String id) {
    for (int i = 0; i < addedList.length; i++) {
      if (addedList[i].id == id) {
        addedList.removeAt(i);
      }
      notifyListeners();
    }
  }

  addContact(var contactModel) {
    addedList.add(contactModel);
    notifyListeners();
  }

  unselectedContacts(String id) {
    for (int i = 0; i < contactList.length; i++) {
      if (contactList[i].id == id) {
        contactList[i].isSelected = false;
      }
    }
    for (int i = 0; i < addedList.length; i++) {
      if (addedList[i].id == id) {
        addedList.removeAt(i);
      }
      notifyListeners();
    }
  }

  Future<void> contactApiFunction(String val,
      {bool showLoading = false}) async {
    contactList.clear();
    currentIndex = 0;
    showLoading ? showLoader(navigatorKey.currentContext!) : null;
    notifyListeners();
    await fetchAllData(val).then((val) async {
      if (val != null) {
        ContactModel allData = val;
        while (currentIndex < allData.data!.length) {
          final end = (currentIndex + chunkSize < allData.data!.length)
              ? currentIndex + chunkSize
              : allData.data!.length;
          final chunk = allData.data!.sublist(currentIndex, end);
          // Simulate processing delay
          await Future.delayed(const Duration(milliseconds: 100));

          // Update your data list
          contactList.addAll(chunk);
          notifyListeners();
          currentIndex += chunkSize;
        }
        showLoading ? Navigator.pop(navigatorKey.currentContext!) : null;
        notifyListeners();
      }
    });
    // Process in chunks
  }

  Future fetchAllData(String val) async {
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'keyword': val,
      'perpage': '10',
      'start': '0',
    };

    final response = await ApiService.multiPartApiMethod(
      url: ApiUrl.groupContactsUrl,
      body: body,
    );

    // Pass the result back to the main thread
    if (response != null && response['status'] == 1) {
      return ContactModel.fromJson(response);
    }
  }

  createGroupApiFunction() async {
    String id = addedList.map((e) => e.id).join(',');
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
    String id = addedList.map((e) => e.id).join(',');
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
