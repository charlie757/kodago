import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';

Widget scrollLoader() {
  return const Center(
      child: CircularProgressIndicator(
    color: AppColor.appColor,
  ));
}
