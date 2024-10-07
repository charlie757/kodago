import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/group/contact_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class ContactProvider extends ChangeNotifier {
  final int chunkSize = 100; // Size of each chunk
  bool isLoading = false;
  int currentIndex = 0;

  // ContactModel? model;
  List contactList = [];

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
}
