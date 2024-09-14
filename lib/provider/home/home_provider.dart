import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/uitls/constants.dart';

class HomeProvider extends ChangeNotifier {
  int page = 0;
  int perPage = 10;

  feedsApiFunction() async {
    var body = {
      'perpage': perPage.toString(),
      'start': page.toString(),
      'get_feeds': '1',
      'get_stories': '1',
      'Authkey': Constants.authkey,
      'Userid': '6073',
      'Token': Constants.TOKEN,
      'app_version': Constants.appVersion,
    };
    print(body);
    final response =
        await ApiService.multiPartApiMethod(url: ApiUrl.feedsUrl, body: body);
    print(response);
  }
}
