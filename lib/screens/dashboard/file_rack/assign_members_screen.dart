import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/check_box.dart';
import 'package:kodago/helper/custom_horizontal_line.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/widget/appbar.dart';

class AssignMembersScreen extends StatefulWidget {
  const AssignMembersScreen({super.key});

  @override
  State<AssignMembersScreen> createState() => _AssignMembersScreenState();
}

class _AssignMembersScreenState extends State<AssignMembersScreen> {
  List list = [
    "All data types",
    "State or name",
    "City",
    "Locality",
    "Students Admission Form",
    "District",
    "State Master",
    "City Master",
    "Total",
    "Time data type",
    "Auto ID Testing",
    "Image",
    "New changes data"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Assign members'),
      body: Padding(
        padding: const EdgeInsets.only(left: 17, right: 18, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                customCheckBox(index: -1, selectedIndex: 0),
                ScreenSize.width(12),
                customText(
                  title: 'All Group Members',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.darkAppColor,
                  fontFamily: FontFamily.interMedium,
                )
              ],
            ),
            ScreenSize.height(15),
            const MySeparator(
              color: Color(0xffC0D0D9),
            ),
            ScreenSize.height(13),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, sp) {
                    return ScreenSize.height(10);
                  },
                  itemCount: 5,
                  padding: const EdgeInsets.only(bottom: 30),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return fileRackWidget(index);
                  }),
            )
          ],
        ),
      ),
    );
  }

  fileRackWidget(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: AppColor.blackColor.withOpacity(.1),
                offset: const Offset(0, 0),
                blurRadius: 5)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customCheckBox(index: index, selectedIndex: 3),
              ScreenSize.width(11),
              Image.asset(
                'assets/dummay/Oval (4).png',
                height: 32,
                width: 32,
              ),
              ScreenSize.width(9),
              customText(
                title: 'Jon Dav',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interSemiBold,
              ),
            ],
          ),
          ScreenSize.height(15),
          index == 2
              ? Column(
                  children: [
                    customHorizontalDivider(),
                    ScreenSize.height(15),
                    selectedFileRack(),
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  selectedFileRack() {
    return Padding(
      padding: const EdgeInsets.only(left: 33),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                title: '5 selected',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interMedium,
              ),
              Image.asset(
                AppImages.keyboardDownIcon,
                height: 16,
                color: AppColor.blackColor,
              )
            ],
          ),
          ScreenSize.height(15),
          Row(
            children: [
              customCheckBox(index: 0, selectedIndex: 0),
              ScreenSize.width(16),
              customText(
                title: "All File Rack's",
                color: AppColor.darkAppColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interSemiBold,
              ),
            ],
          ),
          ScreenSize.height(21),
          ListView.separated(
              separatorBuilder: (context, sp) {
                return ScreenSize.height(22);
              },
              itemCount: list.length,
              padding: const EdgeInsets.only(bottom: 25),
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    customCheckBox(index: index, selectedIndex: 0),
                    ScreenSize.width(11),
                    customText(
                      title: list[index],
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.interRegular,
                      color: const Color(0xff7F888D),
                    )
                  ],
                );
              })
        ],
      ),
    );
  }
}
