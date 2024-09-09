import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/screens/onboarding_screen.dart';

class SplashProvider extends ChangeNotifier {
  callSplash() {
    Future.delayed(const Duration(seconds: 3), () {
      AppRoutes.pushReplacementNavigation(const OnboardingScreen());
    });
  }
}
