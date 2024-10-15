import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/comment_model.dart';
import 'package:kodago/model/feeds_model.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class HomeProvider extends ChangeNotifier {
  
  int page = 0;
  int perPage = 10;
  FeedsModel? feedsModel;
 
  bool isLoading = false;
  bool isCommentLoading = false;
  // final allStory = [];
  // bool isSound = false;

  bool isLoadingMore = false;
  bool hasMoreData = true;

  // updateSound(val) {
  //   isSound = val;
  //   notifyListeners();
  // }

  updateLoading(value) async {
    isLoading = value;
  }

updateCommentLoading(value)async{
  isCommentLoading=value;
  notifyListeners();
}
  clearvalues() {
    isCommentLoading=false;
    page = 0;
    perPage = 10;
    isLoadingMore = false;
    hasMoreData = true;
  }

  clearPages(){
    page = 0;
    perPage = 10;
    notifyListeners();
  }

  Future<void> feedsApiFunction({bool isLoadMore = false}) async {
    if (isLoadMore) {
      isLoadingMore = true;
    } else {
      feedsModel == null ? updateLoading(true) : null;
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

    final response =
        await ApiService.multiPartApiMethod(url: ApiUrl.feedsUrl, body: body);
    if (!isLoadMore) {
      updateLoading(false);
    } else {
      isLoadingMore = false;
    }

    if (response != null && response['status'] == 1) {
      var newFeeds = FeedsModel.fromJson(response);
      if (isLoadMore) {
        feedsModel?.data!.feeds!
            .addAll(newFeeds.data!.feeds!); // Append new data to the list
      } else {
        feedsModel = newFeeds; // Initial load
      }

      if (newFeeds.data!.feeds!.isEmpty ||
          newFeeds.data!.feeds!.length < perPage) {
        hasMoreData = false; // No more data to load
      } else {
        page++; // Increment page for next load
        perPage += 10;
      }
    } else {
      feedsModel = null;
    }

    notifyListeners();
  }


}
