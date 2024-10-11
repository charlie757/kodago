import 'package:flutter/material.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/comment_message_widget.dart';
import 'package:kodago/widget/reply_comment_widget.dart';

Widget commentWidget() {
  return Column(
    children: [
      Expanded(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: commentMessageWidget(img: 'assets/dummay/img1.png',title: 'joshua_l',msg: 'Good Work for site',
            date: '2w'
            ),
          ),
          ScreenSize.height(19),
          Padding(
            padding: const EdgeInsets.only(left: 53),
            child:  commentMessageWidget(img: 'assets/dummay/img1.png',title: 'joshua_l',msg: 'Good Work for site',
            date: '2w'
            ),
          ),
          ScreenSize.height(19),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: commentMessageWidget(img: 'assets/dummay/profile.png',title: 'joshua_l',msg: 'Good Work for site',
            date: '2w'
            ),
          ),
          ScreenSize.height(19),
        ],
      )),
      replyCommentWidget(img: 'assets/dummay/profile1.png')
    ],
  );
}
