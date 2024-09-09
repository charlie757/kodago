import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          title: 'Notification',
          isLeading: false,
          titleColor: AppColor.appColor),
      body: SlidableAutoCloseBehavior(
        child: ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(25);
            },
            itemCount: 10,
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 40),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return notificationWidget();
            }),
      ),
    );
  }

  notificationWidget() {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .2,
        motion: const ScrollMotion(),
        children: [
          Flexible(
            child: Container(
              width: 50,
              height: 100,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color(0xffFF4141),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Image.asset(
                AppImages.delete1Icon,
                height: 20,
              ),
            ),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Row(
          children: [
            Image.asset(
              'assets/dummay/Avatar.png',
              height: 40,
              width: 40,
            ),
            ScreenSize.width(15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    title: 'Anaya Sanji',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                    color: AppColor.blackColor,
                  ),
                  ScreenSize.height(3),
                  customText(
                    title: 'Let’s have a call for a future projects...',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interMedium,
                    color: AppColor.grey6AColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
