import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

class FileRackHistory extends StatefulWidget {
  const FileRackHistory({super.key});

  @override
  State<FileRackHistory> createState() => _FileRackHistoryState();
}

class _FileRackHistoryState extends State<FileRackHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Test'),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(20);
          },
          itemCount: 3,
          padding:
              const EdgeInsets.only(left: 20, right: 21, top: 15, bottom: 25),
          itemBuilder: (context, index) {
            return viewHistoryWidget();
          }),
    );
  }

  viewHistoryWidget() {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.grey7DColor.withOpacity(.1)),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  dotsWidget(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    height: 207,
                    width: 3,
                    color: AppColor.appColor.withOpacity(.5),
                  ),
                  dotsWidget(),
                ],
              ),
            ),
            ScreenSize.width(10),
            Expanded(
                child: Column(
              children: [
                historydataWidget('Daily'),
                ScreenSize.height(20),
                historydataWidget('Monday')
              ],
            ))
          ],
        ),
      ),
    );
  }

  dotsWidget() {
    return Container(
      height: 18,
      width: 18,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColor.darkAppColor),
    );
  }

  historydataWidget(
    String title,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/dummay/Profile Image.png',
              height: 32,
            ),
            ScreenSize.width(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'joshua_l',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.interSemiBold,
                ),
                customText(
                  title: 'Add on 12, Jun 2024 01:34 PM',
                  fontSize: 11,
                  color: AppColor.grey7DColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interMedium,
                ),
              ],
            )
          ],
        ),
        ScreenSize.height(12),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xffF8F8F8),
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: const Color(0xffABABAB1A).withOpacity(.1))),
          padding:
              const EdgeInsets.only(top: 12, left: 8, right: 12, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: 'Scheme Name',
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interMedium,
              ),
              ScreenSize.height(4),
              customText(
                title:
                    'Work for Retrofitting of Bungi Rajgarh Water Supply Project to provide FHTC including 10 years O&M under JJM District Churu.',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interMedium,
                color: AppColor.grey6AColor,
              ),
              ScreenSize.height(11),
              customText(
                title: 'Type of Progress Report',
                fontSize: 12.5,
                fontFamily: FontFamily.interMedium,
                fontWeight: FontWeight.w400,
              ),
              ScreenSize.height(5),
              customText(
                title: title,
                fontSize: 12,
                color: AppColor.grey6AColor,
                fontFamily: FontFamily.interMedium,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        )
      ],
    );
  }
}
