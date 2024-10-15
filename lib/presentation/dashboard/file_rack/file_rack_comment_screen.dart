import 'package:flutter/material.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/presentation/shimmer/comment_shimmer.dart';
import 'package:kodago/services/provider/common/common_provider.dart';
import 'package:kodago/services/provider/profile_provider.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/comment_message_widget.dart';
import 'package:kodago/widget/no_data_found.dart';
import 'package:kodago/widget/reply_comment_widget.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class FileRackCommentScreen extends StatefulWidget {
  final String groupId;
  final String sheetId;
  final String sheetDataId;
  const FileRackCommentScreen(
      {required this.groupId,
      required this.sheetId,
      required this.sheetDataId});

  @override
  State<FileRackCommentScreen> createState() => _FileRackCommentScreenState();
}

class _FileRackCommentScreenState extends State<FileRackCommentScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<CommonProvider>(context, listen: false);
    provider.commentApiFunction(
        groupId: widget.groupId,
        sheetId: widget.sheetId,
        sheetDataId: widget.sheetDataId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Comments'),
      body: Consumer<CommonProvider>(builder: (context, myProvider, child) {
        return Column(
          children: [
            Expanded(
                child: myProvider.isCommentLoading
                    ? const CommentShimmer()
                    : myProvider.commentModel != null &&
                            myProvider.commentModel!.data != null &&
                            myProvider.commentModel!.data!.comments != null &&
                            myProvider.commentModel!.data!.comments!.dbdata !=
                                null &&
                            myProvider.commentModel!.data!.comments!.dbdata!
                                .isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, sp) {
                              return ScreenSize.height(19);
                            },
                            itemCount: myProvider
                                .commentModel!.data!.comments!.dbdata!.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 15),
                            itemBuilder: (context, index) {
                              var model = myProvider.commentModel!.data!
                                  .comments!.dbdata![index];
                              return commentMessageWidget(
                                  img: model.imageLink,
                                  title: model.username,
                                  msg: model.comment,
                                  date: model.createdAt,
                                  isDefault: false);
                            })
                        : noDataFound('No Comments')),
            replyCommentWidget(
                isDefault: false,
                img: Provider.of<ProfileProvider>(context, listen: false)
                    .profileModel!
                    .data!
                    .userImage,
                controller: myProvider.commentController,
                onTap: () {
                  if (myProvider.commentController.text.isNotEmpty) {
                    myProvider.postCommentApiFunction(
                        groupId: widget.groupId,
                        sheetId: widget.sheetId,
                        sheetDataId: widget.sheetDataId);
                  }
                })
          ],
        );
      }),
    
      // Padding(
      //   padding: const EdgeInsets.only(top: 5),
      //   child: commentWidget(),
      // ),
    );
  }
}
