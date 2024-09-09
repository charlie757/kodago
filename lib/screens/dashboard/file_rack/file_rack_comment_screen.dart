import 'package:flutter/material.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/comment_widget.dart';

class FileRackCommentScreen extends StatefulWidget {
  const FileRackCommentScreen({super.key});

  @override
  State<FileRackCommentScreen> createState() => _FileRackCommentScreenState();
}

class _FileRackCommentScreenState extends State<FileRackCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Comments'),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: commentWidget(),
      ),
    );
  }
}
