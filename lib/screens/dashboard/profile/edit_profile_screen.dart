import 'package:flutter/material.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appBar_leading.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithLeading(title: 'Personal Information'),
        body: Padding(
          padding: const EdgeInsets.only(left: 19, right: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: 'Full Name',
                fontSize: 13,
                fontFamily: FontFamily.interMedium,
              ),
              ScreenSize.height(6),
              CustomTextField(hintText: 'Enter full name'),
              ScreenSize.height(20),
              customText(
                title: 'Email',
                fontSize: 13,
                fontFamily: FontFamily.interMedium,
              ),
              ScreenSize.height(6),
              CustomTextField(hintText: 'Enter full name'),
              ScreenSize.height(20),
              customText(
                title: 'Mobile no.',
                fontSize: 13,
                fontFamily: FontFamily.interMedium,
              ),
              ScreenSize.height(6),
              CustomTextField(hintText: 'Enter full name'),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 19, right: 20, bottom: 30),
          child: CustomBtn(title: 'Save', onTap: () {}),
        ));
  }
}
