import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/file_rack/no_file_racks_screen.dart';
import 'package:kodago/widget/appbar.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Add Data"),
      body: Padding(
        padding: const EdgeInsets.only(left: 17, right: 20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColor.borderColor)),
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    title: 'Scheme Name',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.5,
                    fontFamily: FontFamily.interRegular,
                  ),
                  ScreenSize.height(8),
                  CustomTextField(hintText: ''),
                  ScreenSize.height(13),
                  customText(
                    title: 'Type of Progress Report',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.5,
                    fontFamily: FontFamily.interRegular,
                  ),
                  ScreenSize.height(8),
                  CustomTextField(hintText: ''),
                  ScreenSize.height(13),
                  customText(
                    title: 'Date of Inspection',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.5,
                    fontFamily: FontFamily.interRegular,
                  ),
                  ScreenSize.height(8),
                  CustomTextField(hintText: ''),
                  ScreenSize.height(17),
                  CustomBtn(
                      title: 'Save',
                      onTap: () {
                        AppRoutes.pushCupertinoNavigation(
                            const NoFileRacksScreen());
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
