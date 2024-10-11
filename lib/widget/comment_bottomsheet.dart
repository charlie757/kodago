import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/presentation/shimmer/comment_shimmer.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:kodago/services/provider/profile_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/comment_message_widget.dart';
import 'package:kodago/widget/no_data_found.dart';
import 'package:kodago/widget/reply_comment_widget.dart';
import 'package:provider/provider.dart';
 
Future commentBottomSheet({required String groupId, required String sheetId, required String sheetDataId}) {
 return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.whiteColor,
      shape: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.whiteColor),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: navigatorKey.currentContext!,
      builder: (context) {
        return Consumer<HomeProvider>(
          builder: (context,provider,child) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.only(
                  top: 19, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customText(
                    title: 'Comments',
                    fontSize: 20,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.interSemiBold,
                  ),
                  ScreenSize.height(17),
                  divider(),
                  ScreenSize.height(16),
                  Expanded(child: provider.isCommentLoading?
                  const CommentShimmer():
                 provider.commentModel!=null&&provider.commentModel!.data!=null&&
                 provider.commentModel!.data!.comments!=null&& provider.commentModel!.data!.comments!.dbdata!=null
                 && provider.commentModel!.data!.comments!.dbdata!.isNotEmpty?
                   ListView.separated(
                    separatorBuilder: (context,sp){
                      return ScreenSize.height(19);
                    },
                    itemCount: provider.commentModel!.data!.comments!.dbdata!.length,
                    shrinkWrap: true,
                    padding:const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                    itemBuilder: (context,index){
                      var model = provider.commentModel!.data!.comments!.dbdata![index];
                      return commentMessageWidget(img:model.imageLink,title: model.username,msg: model.comment,date: model.createdAt,isDefault: false);
                   }):noDataFound('No Comments')),
                   replyCommentWidget(isDefault: false,img: 
                   Provider.of<ProfileProvider>(navigatorKey.currentContext!,listen: false).profileModel!.data!.userImage ,controller: provider.commentController,
                   onTap: (){
                    if(provider.commentController.text.isNotEmpty){
                      provider.postCommentApiFunction(groupId: groupId, sheetId: sheetId, sheetDataId: sheetDataId);
                    }
                   }
                   )
                ],
              ),
            );
          }
        );
      });
}

divider() {
  return Container(
    height: 1,
    color: const Color(0xffE7E7E7).withOpacity(.6),
  );
}
