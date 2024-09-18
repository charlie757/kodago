import 'package:flutter/material.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appBar_leading.dart';

import '../../../uitls/mixins.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>with MediaQueryScaleFactor {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
          appBar: appBarWithLeading(title: "Change Password"),
          body: Padding(
            padding: const EdgeInsets.only(left: 19, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(hintText: 'Current Password'),
                ScreenSize.height(20),
                CustomTextField(hintText: 'New Password'),
                ScreenSize.height(20),
                CustomTextField(hintText: 'Confirm Password'),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 19, right: 20, bottom: 30),
            child: CustomBtn(title: 'Save', onTap: () {}),
          )),
    );
  }
}
