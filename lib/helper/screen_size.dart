import 'package:flutter/material.dart';
import 'package:kodago/uitls/utils.dart';

class ScreenSize {
  static final appBarHeight = AppBar().preferredSize.height;
  static final screenHeight =
      MediaQuery.of(navigatorKey.currentContext!).size.height;
  static final keyboardHeight =
      MediaQuery.of(navigatorKey.currentContext!).viewInsets.bottom;

  static Widget height(double size) {
    return SizedBox(
      height: size,
    );
  }

  static Widget width(double size) {
    return SizedBox(
      width: size,
    );
  }
}
