import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';

class ViewFeedsProvider extends ChangeNotifier{
FileRackDetailsModel? fileRackDetailsModel;

  viewSheetFeedDataApiFunction({required String groupId,required String sheetId, required String sheetDataId,
  bool isLoader =true
  })async{
    if(isLoader){
   fileRackDetailsModel=null;
   showLoader(navigatorKey.currentContext!);
    }
   notifyListeners();
    var body = {
      'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_id': groupId,
      'sheet_id': sheetId,
      'sheet_data_id':sheetDataId,
    };
    print(body);
     final response =
        await ApiService.multiPartApiMethod(url: ApiUrl.fileRackDetailsUrl, body: body);
       isLoader? Navigator.pop(navigatorKey.currentContext!):null;
        if(response!=null&&response['status']==1){
          fileRackDetailsModel = FileRackDetailsModel.fromJson(response);
        }
        notifyListeners();
  }

// viewLoadApiFunction({required String groupId,required String sheetId, required String sheetDataId,
//   bool isLoader =true
//   })async{
//     var body = {
//       'Authkey': Constants.authkey,
//       'Userid': SessionManager.userId,
//       'Token': SessionManager.token,
//       'group_id': groupId,
//       'sheet_id': sheetId,
//       'sheet_data_id':sheetDataId,
//     };
//     print(body);
//      final response =
//         await ApiService.multiPartApiMethod(url: ApiUrl.viewSheetDataUrl, body: body);
//         if(response!=null&&response['status']==1){
//           // fileRackDetailsModel = FileRackDetailsModel.fromJson(response);
//         }
//         notifyListeners();
  
// }


}