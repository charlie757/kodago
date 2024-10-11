import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/group/group_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';

class GroupProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  bool isLoading = false;
  GroupModel? model;
  GroupModel? globalGroupModel;
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

  Future groupApiFunction({
    bool isLoading = true,
  }) async {
    searchController.clear();
    if (isLoading) {
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
      globalGroupModel = GroupModel.fromJson(response);
      model = GroupModel.fromJson(response);
      notifyListeners();
    } else {
      model = null;
    }

    notifyListeners();
  }

  setGroupData() {
    if (globalGroupModel != null && globalGroupModel!.data != null) {
      model!.data = globalGroupModel!.data;
      notifyListeners();
    }
  }

  bool noDataFound = false;

  searchFunction(String val) async {
    model!.data = [];
    if (!globalGroupModel
        .toString()
        .toLowerCase()
        .contains(val.toLowerCase())) {
      model!.data!.clear();
      print('No data found');
      noDataFound = true;
    }

    globalGroupModel!.data!.forEach((element) {
      String lowerCaseVal = val.toLowerCase();
      String lowerCaseName =
          element.name.isNotEmpty ? element.name.toLowerCase() : "";

      if (val.isEmpty) {
        model!.data!.clear();
        noDataFound = false;
        notifyListeners();
      } else if (lowerCaseName.contains(lowerCaseVal)) {
        noDataFound = false;
        print("element...${element.name}");
        model!.data!.add(element);
      }
    });

    notifyListeners();
  }
}
