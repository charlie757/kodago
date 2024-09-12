import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_searchbar.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/group/chat_screen.dart';
import 'package:kodago/screens/dashboard/group/contact_screen.dart';
import 'package:kodago/widget/popmenuButton.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: CustomSearchbar(),
          ),
          ScreenSize.height(14),
          Row(
            children: [
              msgListTypesWidget('All'),
              ScreenSize.width(10),
              msgListTypesWidget('Unread'),
              ScreenSize.width(10),
              msgListTypesWidget('Groups'),
            ],
          ),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return ScreenSize.height(20);
                },
                itemCount: 15,
                shrinkWrap: true,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 17, bottom: 30),
                itemBuilder: (context, index) {
                  return groupWidget();
                }),
          )
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          AppRoutes.pushCupertinoNavigation(const ContactScreen());
        },
        child: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.appColor,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -2),
                    blurRadius: 6,
                    color: AppColor.blackColor.withOpacity(.2))
              ]),
          child: const Icon(
            Icons.add,
            color: AppColor.whiteColor,
          ),
        ),
      ),
    );
  }

  msgListTypesWidget(
    String title,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: title.toLowerCase() == 'all' ? 20 : 14),
      decoration: BoxDecoration(
          color: title.toLowerCase() == 'all'
              ? const Color(0xffE6EBF5)
              : const Color(0xffF9F9F9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: title.toLowerCase() == 'all'
              ? []
              : [
                  BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                      color: AppColor.blackColor.withOpacity(.2))
                ]),
      child: customText(
        title: title,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: title.toLowerCase() == 'all'
            ? AppColor.darkAppColor
            : AppColor.grey6AColor,
        fontFamily: FontFamily.interMedium,
      ),
    );
  }

  groupWidget() {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(const ChatScreen());
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/dummay/Oval.png',
            height: 38,
            width: 38,
          ),
          ScreenSize.width(11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'Kodago Attendance',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontFamily: FontFamily.interMedium,
                ),
                ScreenSize.height(4),
                customText(
                  title: 'Empolyee Attendance Group',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey7DColor,
                  fontFamily: FontFamily.interRegular,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: '5:01 pm',
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColor.grey7DColor,
                fontFamily: FontFamily.interRegular,
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: customText(
        title: 'Group',
        fontSize: 20,
        color: AppColor.darkAppColor,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.interSemiBold,
      ),
      actions: [
        customPopupMenuButton(
            list: [
              customPopMenuItem(value: 0, title: 'New Group'),
              customPopMenuItem(value: 1, title: 'Settings'),
            ],
            onSelected: (value) {
              // if (value == 0) {
              //   AppRoutes.pushCupertinoNavigation(const GroupInfoScreen());
              // }
            })
      ],
    );
  }
}
