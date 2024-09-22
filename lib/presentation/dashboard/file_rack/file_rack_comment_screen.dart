import 'package:flutter/material.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/comment_widget.dart';

import '../../../uitls/mixins.dart';

class FileRackCommentScreen extends StatefulWidget {
  const FileRackCommentScreen({super.key});

  @override
  State<FileRackCommentScreen> createState() => _FileRackCommentScreenState();
}

class _FileRackCommentScreenState extends State<FileRackCommentScreen>with MediaQueryScaleFactor {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        appBar: appBar(title: 'Comments'),
        body: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: commentWidget(),
        ),
      ),
    );
  }
}
