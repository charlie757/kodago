import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
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
                )
              ],
            )),
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: AppColor.appColor,
              child: Row(
                children: [
                  Expanded(child: commentTextField()),
                  ScreenSize.width(16),
                  Image.asset(
                    AppImages.likeIcon,
                    height: 16,
                    width: 18,
                    color: AppColor.whiteColor.withOpacity(.4),
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
}
