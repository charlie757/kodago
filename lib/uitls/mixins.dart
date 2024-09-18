import 'package:flutter/material.dart';
import 'package:kodago/uitls/utils.dart';

mixin MediaQueryScaleFactor {
  MediaQueryData mediaQuery = MediaQuery.of(navigatorKey.currentContext!)
      .copyWith(textScaler: const TextScaler.linear(1.0));
}
