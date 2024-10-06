import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/presentation/dashboard/dashboard_screen.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';

class TopicProvider extends ChangeNotifier {
  List topicList = [];
  bool isLoading = false;

  updateLoading(val) {
    isLoading = val;
    notifyListeners();
  }

  addTopic() {
    var model = TopicModel();
    topicList.add(model.controller);
    notifyListeners();
  }

  removeTopic(int index) {
    topicList.removeAt(index);
    notifyListeners();
  }

  createTopicApiFunction(String groupId, String route) async {
    updateLoading(true);
    List list = [];
    for (int i = 0; i < topicList.length; i++) {
      if (topicList[i].text.isNotEmpty) {
        list.add({'name': topicList[i].text});
      }
    }
    print(json.encode(list));
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_id': groupId,
      'topics': json.encode(list)
    };
    print(body);

    final response = await ApiService.multiPartApiMethod(
      url: ApiUrl.topicUrl,
      body: body,
    );
    updateLoading(false);
    if (response != null && response['status'] == 1) {
      Utils.showToast(
        response['message'],
      );
      if (route == 'group') {
        AppRoutes.pushReplacementNavigation(DashboardScreen(
          index: 1,
        ));
      } else {
        Navigator.pop(navigatorKey.currentContext!);
      }
    }
    notifyListeners();
  }
}

class TopicModel {
  final controller = TextEditingController();
}
