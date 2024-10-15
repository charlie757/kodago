import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/model/comment_model.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/utils.dart';

class CommonProvider extends ChangeNotifier{

final commentController = TextEditingController();
 CommentModel? commentModel;
 bool isCommentLoading = false;
updateCommentLoading(value)async{
  isCommentLoading=value;
  notifyListeners();
}

clearController(){
  commentController.clear();
}

likeDislikeApiFunction({required String groupId,required String sheetId,required String sheetDataId,})async{
  var body = {
       'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_id': groupId,
      'sheet_id': sheetId,
      'sheet_data_id':sheetDataId,
  };
  print(body);
  final response = await ApiService.multiPartApiMethod(url: ApiUrl.likeDislikeUrl, body: body);
  if(response!=null&&response['status']==1){
  }
}



  postCommentApiFunction({required String groupId,required String sheetId,required String sheetDataId,})async{
    Utils.hideTextField();
    var body ={
       'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_id': groupId,
      'sheet_id': sheetId,
      'sheet_data_id':sheetDataId,
      'comment':commentController.text,
      // 'tag_users':SessionManager.userIntId
    };
    final response = await ApiService.multiPartApiMethod(url: ApiUrl.postCommentUrl, body: body);
    if(response!=null&&response['status']==1){
      clearController();
      commentApiFunction(groupId: groupId, sheetId: sheetId, sheetDataId: sheetDataId);
    }
  }

postSubCommentApiFunction({required String groupId,required String sheetId,required String sheetDataId,required String commentId})async{
    Utils.hideTextField();
    var body ={
       'Authkey': Constants.authkey,
      'Userid': SessionManager.userId,
      'Token': SessionManager.token,
      'group_id': groupId,
      'sheet_id': sheetId,
      'sheet_data_id':sheetDataId,
      'comment':commentController.text,
      'comment_id':commentId
      // 'tag_users':SessionManager.userIntId
    };
    final response = await ApiService.multiPartApiMethod(url: ApiUrl.postSubCommentUrl, body: body);
    if(response!=null&&response['status']==1){
      clearController();
      commentApiFunction(groupId: groupId, sheetId: sheetId, sheetDataId: sheetDataId);
    }
}

  commentApiFunction({required String groupId,required String sheetId,required String sheetDataId,})async{
    commentModel = null;
    updateCommentLoading(true);
    notifyListeners();
    var body ={
         'Authkey': Constants.authkey,
        'Userid': SessionManager.userId,
        'Token': SessionManager.token,
        'group_id': groupId,
       'sheet_data_id':sheetDataId,
    };
    final response = await ApiService.multiPartApiMethod(url: ApiUrl.commentUrl, body: body);
    updateCommentLoading(false);
    if(response!=null&&response['status']==1){
      commentModel = CommentModel.fromJson(response);
      notifyListeners();
    }
  }

}