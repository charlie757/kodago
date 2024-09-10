import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/screens/auth/login_screen.dart';
import 'package:kodago/screens/dashboard/dashboard_screen.dart';
import 'package:kodago/screens/onboarding_screen.dart';
import 'package:kodago/uitls/session_manager.dart';

class SplashProvider extends ChangeNotifier {
  callSplash() {
    Future.delayed(const Duration(seconds: 3), () {
      if (!SessionManager.firstTimeOpenApp) {
        AppRoutes.pushReplacementNavigation(const OnboardingScreen());
      } else if (SessionManager.token.isNotEmpty) {
        AppRoutes.pushReplacementNavigation(const DashboardScreen());
      } else {
        AppRoutes.pushReplacementNavigation(const LoginScreen());
      }
    });
  }
}
