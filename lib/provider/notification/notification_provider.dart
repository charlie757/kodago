import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/notification_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationModel? model;
  int page = 0;
  int perPage = 10;
  bool isLoading = false;
  // bool isSound = false;

  bool isLoadingMore = false;
  bool hasMoreData = true;
  clearvalues() {
    page = 0;
    perPage = 10;
    isLoadingMore = false;
    hasMoreData = true;
  }

  Future<void> notificationApiFunction({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      // mod == null ? updateLoading(true) : null;
    }
    var body = {
      'perpage': perPage.toString(),
      'start': page.toString(),
      'get_feeds': '1',
      'get_stories': '1',
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
    };
    print("body....$body");

    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.notificationUrl, body: body);
    if (!isLoadMore) {
    } else {
      isLoadingMore = false;
    }

    if (response != null && response['status'] == 1) {
      var newModel = NotificationModel.fromJson(response);
      if (isLoadMore) {
        model!.data!.dbdata!
            .addAll(newModel.data!.dbdata!); // Append new data to the list
      } else {
        model = newModel; // Initial load
      }

      if (newModel.data!.dbdata!.isEmpty ||
          newModel.data!.dbdata!.length < perPage) {
        hasMoreData = false; // No more data to load
      } else {
        page++; // Increment page for next load
        perPage += 10;
      }
    } else {
      model = null;
    }

    notifyListeners();
  }
}
