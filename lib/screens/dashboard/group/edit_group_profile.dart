import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

class EditGroupProfile extends StatefulWidget {
  const EditGroupProfile({super.key});

  @override
  State<EditGroupProfile> createState() => _EditGroupProfileState();
}

class _EditGroupProfileState extends State<EditGroupProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Edit profile'),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/dummay/Oval.png',
                      height: 85,
                      width: 85,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () {
                        // openBottmSheet();
                      },
                      child: Container(
                        height: 26,
                        width: 26,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffDAEFFD)),
                        child: Image.asset(
                          AppImages.cameraIcon,
                          height: 13,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ScreenSize.height(43),
            customText(
              title: 'Enter group name',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(12),
            CustomTextField(hintText: 'Kodago Attendance'),
            ScreenSize.height(22),
            CustomBtn(title: 'Save', onTap: () {})
          ],
        ),
      ),
    );
  }

  openBottmSheet() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          );
        });
  }
}
