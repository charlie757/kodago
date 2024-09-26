import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/group/group_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';

class GroupProvider extends ChangeNotifier {
  bool isLoading = false;
  GroupModel? model;
  int page = 0;
  int perPage = 20;

  bool isLoadingMore = false;
  bool hasMoreData = true;
  clearvalues() {
    page = 0;
    perPage = 10;
    isLoadingMore = false;
    hasMoreData = true;
  }

  updateLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  Future groupApiFunction({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      model = null;
      updateLoading(true);
    }
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'perpage': perPage.toString(),
      'start': page.toString(),
    };
    print("body....$body");
    final response =
        await ApiService.multiPartApiMethod(url: ApiUrl.groupUrl, body: body);
    updateLoading(false);
    if (response != null && response['status'] == 1) {
      var newModel = GroupModel.fromJson(response);
      if (isLoadMore) {
        model!.data!.addAll(newModel.data!); // Append new data to the list
      } else {
        model = newModel; // Initial load
      }

      if (newModel.data!.isEmpty || newModel.data!.length < perPage) {
        hasMoreData = false; // No more data to load
      } else {
        page++;
        perPage += 20;
      }
    } else {
      model = null;
    }

    notifyListeners();
  }
}
