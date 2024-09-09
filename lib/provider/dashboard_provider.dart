import 'package:flutter/material.dart';
import 'package:kodago/screens/dashboard/group/group_screen.dart';
import 'package:kodago/screens/dashboard/home/home_screen.dart';
import 'package:kodago/screens/dashboard/notification/notification_screen.dart';
import 'package:kodago/screens/dashboard/profile/profile_screen.dart';

class DashboardProvider extends ChangeNotifier {
  int currentIndex = 0;
  List screenList = [
    const HomeScreen(),
    const GroupScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  resetValues() {
    currentIndex = 0;
  }

  updateIndex(index) {
    currentIndex = index;
    notifyListeners();
  }
}
