import 'package:flutter/material.dart';
import 'package:kodago/helper/app_images.dart';

class ChatProvider extends ChangeNotifier {
  bool isShowFolderList = false;
  int chatTypeIndex = 0;
  List foldersList = [
    {
      'img': AppImages.chatDocument1,
      'title': 'Document',
      'color': const Color(0xffD6F3E0)
    },
    {
      'img': AppImages.chatDocument2,
      'title': 'Gallery',
      'color': const Color(0xffFFD8D8)
    },
    {
      'img': AppImages.chatDocument3,
      'title': 'Camera',
      'color': const Color(0xffF6DAFB)
    },
    {
      'img': AppImages.chatDocument4,
      'title': 'Audio',
      'color': const Color(0xffF3D6D6)
    },
    {
      'img': AppImages.chatDocument5,
      'title': 'Location',
      'color': const Color(0xffD6F3DD)
    },
    {
      'img': AppImages.chatDocument6,
      'title': 'Contact',
      'color': const Color(0xffD6DBF3)
    },
  ];

  List chatTypesList = ['All', 'Geo tagging', 'TPI', 'Skill Development'];

  List messageList = [
    {
      'msg': 'Lorem Ipsum is simply dummy text of the printing and',
      'time': '3:21 pm',
      'type': 'user'
    },
    {
      'msg':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      'time': '3:20 pm',
      'type': 'user'
    },
    {
      'msg': "It is a long established fact that a reader will be",
      'time': '4:20 pm',
      'type': 'admin'
    },
    {
      'msg':
          "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
      'time': '5:20 pm',
      'type': 'admin'
    }
  ];

  updateChatTypeIndex(index) {
    chatTypeIndex = index;
    notifyListeners();
  }
}
