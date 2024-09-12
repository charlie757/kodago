import 'package:flutter/material.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

class AddEditTopicScreen extends StatefulWidget {
  const AddEditTopicScreen({super.key});

  @override
  State<AddEditTopicScreen> createState() => _AddEditTopicScreenState();
}

class _AddEditTopicScreenState extends State<AddEditTopicScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Add & Edit Topic"),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              title: 'If you are add and Edit chat filter by topic please add',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.interSemiBold,
            ),
            ScreenSize.height(24),
            customContainer('Geo tagging', AppImages.topicMenuIcon),
            ScreenSize.height(15),
            customContainer('TPI', AppImages.topicMenuIcon),
            ScreenSize.height(15),
            customContainer('Skill Development', AppImages.topicMenuIcon),
            ScreenSize.height(15),
            customContainer('+ Add', AppImages.topicMenuIcon),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: CustomBtn(
            title: "Save", borderRadius: 50, height: 40, onTap: () {}),
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
