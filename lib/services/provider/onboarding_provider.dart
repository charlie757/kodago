import 'package:flutter/material.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/model/onboarding_model.dart';

class OnboardingProvider extends ChangeNotifier {
  int currentIndex = 0;

  List<OnboardingItem> onboardingList = [
    OnboardingItem(
        img: AppImages.onboardingImg1,
        title: 'Structured\nCommunication',
        des:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
    OnboardingItem(
        img: AppImages.onboardingImg2,
        title: 'Real Time\nNotifications',
        des:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
    OnboardingItem(
        img: AppImages.onboardingImg3,
        title: 'Low Code\nModule Builder',
        des:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'),
  ];

  updateIndex(index) {
    currentIndex = index;
    notifyListeners();
  }
}
