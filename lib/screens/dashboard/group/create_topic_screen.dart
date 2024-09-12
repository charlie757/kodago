import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

import '../../../helper/custom_btn.dart';

class CreateTopicScreen extends StatefulWidget {
  const CreateTopicScreen({super.key});

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Create Topic"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              title: 'If you are add chat filter by topic please add',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.interSemiBold,
            ),
            ScreenSize.height(24),
            customContainer('Happy Birthday', AppImages.topicMenuIcon),
            ScreenSize.height(15),
            customContainer('+ Add', AppImages.topicMenuIcon),
            ScreenSize.height(15),
            customContainer('+ Add', AppImages.topicMenuIcon),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomBtn(
                title: "Save", borderRadius: 50, height: 40, onTap: () {}),
            ScreenSize.height(8),
            customText(
              title: "Skip",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.appColor,
              fontFamily: FontFamily.interMedium,
            )
          ],
        ),
      ),
    );
  }

  customContainer(String title, String img) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: const Color(0xffD1D4D4)))),
      child: Row(
        children: [
          customText(
            title: title,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.interMedium,
          ),
          const Spacer(),
          title.contains('Add')
              ? Container()
              : Image.asset(
                  img,
                  height: 15,
                )
        ],
      ),
    );
  }
}
