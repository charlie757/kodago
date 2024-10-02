import 'package:flutter/material.dart';

class TopicProvider extends ChangeNotifier {
  List topicList = [];

  addTopic(String value) {
    topicList.add(value);
    notifyListeners();
  }

  removeTopic(int index) {
    topicList.removeAt(index);
    notifyListeners();
  }
}

class TopicModel {}
