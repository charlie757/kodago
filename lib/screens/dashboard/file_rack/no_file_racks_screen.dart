import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/file_rack/create_form_screen.dart';
import 'package:kodago/widget/appbar.dart';

class NoFileRacksScreen extends StatefulWidget {
  const NoFileRacksScreen({super.key});

  @override
  State<NoFileRacksScreen> createState() => _NoFileRacksScreenState();
}

class _NoFileRacksScreenState extends State<NoFileRacksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Test'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
        child: Column(
          children: [
            Image.asset(
              AppImages.emptyFileRackIcon,
              height: 110,
            ),
            ScreenSize.height(13),
            customText(
              title: 'No file racks!',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.interSemiBold,
            ),
            ScreenSize.height(6),
            customText(
              title:
                  'No file rack, please see demo\nsteps and create your file rack',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular,
              color: AppColor.text80Color,
            ),
            ScreenSize.height(16),
            CustomBtn(
                title: 'Create form',
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(const CreateFormScreen());
                }),
            ScreenSize.height(45),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        circleCountWidget('1'),
                        verticleDividerWidget()
                      ],
                    ),
                    ScreenSize.width(19),
                    stepperTitleWidget('STEP 1', 'Enter your form name'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        circleCountWidget('2'),
                        verticleDividerWidget()
                      ],
                    ),
                    ScreenSize.width(19),
                    stepperTitleWidget('STEP 2', 'Enter your label name'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        circleCountWidget('3'),
                        verticleDividerWidget()
                      ],
                    ),
                    ScreenSize.width(19),
                    stepperTitleWidget('STEP 3', 'Choose your data type'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    circleCountWidget('4'),
                    ScreenSize.width(19),
                    stepperTitleWidget('STEP 4', 'Proceed'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  stepperTitleWidget(String title, String subTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
          title: title,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColor.grey7DColor,
          fontFamily: FontFamily.interMedium,
        ),
        ScreenSize.height(3),
        customText(
          title: subTitle,
          fontSize: 15,
          color: const Color(0xff3E4653),
          fontWeight: FontWeight.w600,
          fontFamily: FontFamily.interSemiBold,
        )
      ],
    );
  }

  verticleDividerWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 45,
      width: 3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.darkAppColor.withOpacity(.5)),
    );
  }

  circleCountWidget(String value) {
    return Container(
      height: 31,
      width: 31,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColor.darkAppColor),
      child: customText(
        title: value,
        color: AppColor.whiteColor,
        fontFamily: FontFamily.interMedium,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
