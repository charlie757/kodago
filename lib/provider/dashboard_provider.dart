import 'package:flutter/material.dart';
import 'package:kodago/presentation/dashboard/group/group_screen.dart';
import 'package:kodago/presentation/dashboard/home/home_screen.dart';
import 'package:kodago/presentation/dashboard/notification/notification_screen.dart';
import 'package:kodago/presentation/dashboard/profile/profile_screen.dart';

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
