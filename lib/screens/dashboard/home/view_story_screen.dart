import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';

class ViewStoryScreen extends StatefulWidget {
  const ViewStoryScreen({super.key});

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Stack(
              children: [
                Image.asset(
                  'assets/dummay/story.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: LinearProgressIndicator(
                    value: .4,
                    minHeight: 2,
                    color: AppColor.whiteColor,
                    backgroundColor: const Color(0xffE2E2E2).withOpacity(.7),
                  ),
                ),
                visitRecodWidget()
              ],
            )),
            Container(
              // height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: AppColor.blackColor,
              child: Row(
                children: [
                  Expanded(child: commentTextField()),
                  ScreenSize.width(16),
                  Image.asset(
                    AppImages.thumbIcon,
                    height: 16,
                    width: 18,
                  ),
                  ScreenSize.width(16),
                  Image.asset(
                    AppImages.shareIcon,
                    height: 16,
                    width: 18,
                    color: AppColor.whiteColor.withOpacity(.4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  commentTextField() {
    return TextFormField(
      decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.whiteColor.withOpacity(.3),
              ),
              borderRadius: BorderRadius.circular(50)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.whiteColor.withOpacity(.3),
              ),
              borderRadius: BorderRadius.circular(50)),
          hintText: 'Type a message',
          hintStyle: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteColor.withOpacity(.4),
              fontFamily: FontFamily.interRegular)),
    );
  }

  visitRecodWidget() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 35, right: 10),
        child: Container(
          height: 45,
          width: 139,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.visitRecordIcon,
                height: 20,
                width: 20,
              ),
              ScreenSize.width(7),
              customText(
                title: 'Visit record',
                color: const Color(0xff6A88A4),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                fontFamily: FontFamily.interMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
