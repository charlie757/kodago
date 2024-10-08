import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';

enum httpMethod { POST, GET, DELETE, PUT }

// checkApiMethod(type) {
//   switch (type) {
//     case httpMethod.post:
//       return 'POST';
//     case httpMethod.get:
//       return 'GET';
//     case httpMethod.delete:
//       return 'DELETE';
//     case httpMethod.put:
//       return 'PUT';
//     default:
//       print('Unknown color');
//   }
// }

class ApiService {
  static Future apiMethod(
      {required String url,
      required var body,
      required String method,
      bool isErrorMessageShow = true,
      bool isBodyNotRequired = false}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          final request = http.Request(
            method,
            Uri.parse(url),
          );
          if (!isBodyNotRequired) {
            request.body = body;
          }
          request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
          request.headers['Authorization'] = "Bearer ${SessionManager.token}";
          // request.encoding Encoding.getByName('utf-8');
          final client = http.Client();
          final streamedResponse = await client.send(request);
          final response = await http.Response.fromStream(streamedResponse);
          print(response.request);
          log(response.body);
          print(response.statusCode);
          return _handleResponse(response, isErrorMessageShow);
        } on Exception catch (_) {
          rethrow;
        }
      } else {}
    } on SocketException catch (_) {
      Utils.internetSnackBar(navigatorKey.currentContext!);
      // print('not connected');
    }
  }

  static Future multiPartApiMethod(
      {required String url,
      required var body,
      bool isErrorMessageShow = true,
      File? imgFile}) async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try {
          Map<String, String> headers = {
            // "Authorization": "Bearer ${SessionManager.token}",
            "Authkey": Constants.authkey
          };
          print(headers);

          var request = http.MultipartRequest('POST', Uri.parse(url));
          if (imgFile != null) {
            final file =
                await http.MultipartFile.fromPath('image', imgFile.path);
            request.files.add(file);
          }
          request.fields.addAll(body);
          request.headers.addAll(headers);

          var streamedResponse = await request.send();
          var response = await http.Response.fromStream(streamedResponse);
          print(response.statusCode);
          print(request.url);
          log(response.body);
          return _handleResponse(response, isErrorMessageShow);
        } on Exception catch (_) {
          rethrow;
        }
      } else {}
    } on SocketException catch (_) {
      Utils.internetSnackBar(navigatorKey.currentContext!);
      // print('not connected');
    }
  }

  // Helper method to handle API response
  static Map<String, dynamic>? _handleResponse(
      http.Response response, isErrorMessageShow) {
    if (response.statusCode == 200) {
      var dataAll = json.decode(response.body);
      if (dataAll['status'] == 1) {
        return json.decode(response.body);
      } else if (dataAll['status'] == 2) {
        Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext);
        print(Constants.is401Error);
        if (Constants.is401Error == false) {
          Future.delayed(const Duration(seconds: 1), () {
            Constants.is401Error = true;
            Utils.logout();
          });
        }
      } else {
        isErrorMessageShow
            ? Utils.errorSnackBar(
                dataAll['message'], navigatorKey.currentContext)
            : null;
        return json.decode(response.body);
      }
    } else if (response.statusCode == 401) {
      var dataAll = json.decode(response.body);
      // SessionManager.unauthorizedUser(navigatorKey.currentState!.context);
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return null;
    } else {
      var dataAll = json.decode(response.body);
      isErrorMessageShow
          ? Utils.errorSnackBar(dataAll['message'], navigatorKey.currentContext)
          : null;
      return null;
    }
  }
}
