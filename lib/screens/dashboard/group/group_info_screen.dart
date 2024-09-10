import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/group/new_group_provider.dart';
import 'package:kodago/screens/dashboard/file_rack/create_form_screen.dart';
import 'package:kodago/screens/dashboard/group/add_member_screen.dart';
import 'package:kodago/screens/dashboard/group/edit_group_profile.dart';
import 'package:kodago/screens/dashboard/group/hightlight_screen.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/popmenuButton.dart';
import 'package:provider/provider.dart';

class GroupInfoScreen extends StatefulWidget {
  const GroupInfoScreen({super.key});

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: '', actions: [popupMenuButton()]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            groupDetailsWidget(),
            ScreenSize.height(26),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customContainer(AppImages.fileIcon, 'Form', () {
                    AppRoutes.pushCupertinoNavigation(const CreateFormScreen());
                  }),
                  ScreenSize.width(10),
                  customContainer(AppImages.hightlightIcon, 'Highlight', () {
                    AppRoutes.pushCupertinoNavigation(const HightlightScreen());
                  }),
                  ScreenSize.width(10),
                  customContainer(AppImages.analyticsIon, 'Analytics', () {}),
                  ScreenSize.width(10),
                  customContainer(AppImages.addUserIcon, 'Add', () {}),
                ],
              ),
            ),
            ScreenSize.height(19),
            groupDescriptionWidget(),
            ScreenSize.height(15),
            invateLinkWidget(),
            ScreenSize.height(17),
            mediaLinksWidget(),
            ScreenSize.height(19),
            membersWidget(),
            ScreenSize.height(22),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.logoutIcon,
                    height: 22,
                    width: 22,
                  ),
                  ScreenSize.width(12),
                  customText(
                    title: 'Exit group',
                    color: AppColor.redColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  groupDetailsWidget() {
    return Column(
      children: [
        Image.asset(
          'assets/dummay/Oval (2).png',
          height: 73,
          width: 123,
        ),
        ScreenSize.height(20),
        customText(
          title: 'SMEC',
          fontSize: 19,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.interSemiBold,
        ),
        ScreenSize.height(9),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
              title: 'Group',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColor.grey7DColor,
            ),
            ScreenSize.width(6),
            const Padding(
              padding: EdgeInsets.only(top: 3),
              child: Icon(
                Icons.circle,
                size: 5,
                color: AppColor.grey7DColor,
              ),
            ),
            ScreenSize.width(5),
            customText(
              title: '20 members',
              fontSize: 15,
              color: AppColor.grey7DColor,
              fontWeight: FontWeight.w400,
            )
          ],
        )
      ],
    );
  }

  groupDescriptionWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.whiteColor, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 0),
            color: AppColor.blackColor.withOpacity(.1),
            blurRadius: 5,
            spreadRadius: 2)
      ]),
      padding: const EdgeInsets.only(top: 16, left: 19, bottom: 15, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            title: 'Add group description',
            fontSize: 14,
            color: AppColor.appColor,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interMedium,
          ),
          ScreenSize.height(8),
          customText(
            title: "Created by Manish saini, 01/09/24",
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff455154),
            fontFamily: FontFamily.interMedium,
          )
        ],
      ),
    );
  }

  invateLinkWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.whiteColor, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 0),
            color: AppColor.blackColor.withOpacity(.1),
            blurRadius: 5,
            spreadRadius: 2)
      ]),
      padding: const EdgeInsets.only(top: 16, left: 19, bottom: 15, right: 18),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.appColor),
            child: Image.asset(
              AppImages.inviteLinkIcon,
              height: 15,
              width: 15,
            ),
          ),
          ScreenSize.width(11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      title: 'Invite via link',
                      fontSize: 14,
                      color: AppColor.appColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.interMedium,
                    ),
                    customText(
                      title: 'Copy',
                      fontSize: 12,
                      color: AppColor.darkAppColor,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.interMedium,
                    ),
                  ],
                ),
                ScreenSize.height(4),
                customText(
                  title: "People who follow this link can join this group",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff455154),
                  fontFamily: FontFamily.interMedium,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  mediaLinksWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                title: 'Media, links and docs',
                fontSize: 13,
                color: const Color(0xff455154),
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interMedium,
              ),
              customText(
                title: 'View all',
                fontSize: 13,
                color: AppColor.darkAppColor,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interMedium,
              ),
            ],
          ),
        ),
        ScreenSize.height(18),
        SizedBox(
          height: 100,
          child: ListView.separated(
              separatorBuilder: (context, sp) {
                return ScreenSize.width(16);
              },
              itemCount: 4,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 19),
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xffC2C2C2))),
                  child: Image.asset('assets/dummay/Rectangle 592.png'),
                );
              }),
        )
      ],
    );
  }

  membersWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.whiteColor, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 0),
            color: AppColor.blackColor.withOpacity(.1),
            blurRadius: 5,
            spreadRadius: 1)
      ]),
      padding: const EdgeInsets.only(left: 19, top: 16, right: 18, bottom: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                title: '5 members',
                fontSize: 14,
                fontFamily: FontFamily.interMedium,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455154),
              ),
              Image.asset(
                AppImages.searchIcon,
                height: 15,
                width: 15,
              )
            ],
          ),
          ScreenSize.height(15),
          ListView.separated(
              separatorBuilder: (context, sp) {
                return ScreenSize.height(17);
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: context.watch<NewGroupProvider>().groupList.length,
              itemBuilder: (context, index) {
                var model = context.watch<NewGroupProvider>().groupList[index];
                return Row(
                  children: [
                    Image.asset(
                      model['img'],
                      height: 33,
                      width: 33,
                    ),
                    ScreenSize.width(15),
                    Expanded(
                      child: customText(
                        title: model['name'],
                        fontSize: 14,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.interSemiBold,
                      ),
                    ),
                    index == 0
                        ? Container(
                            height: 26,
                            width: 89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color(0xffDAEFFD)),
                            alignment: Alignment.center,
                            child: customText(
                              title: "Group Admin",
                              fontSize: 12,
                              color: AppColor.appColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.interMedium,
                            ),
                          )
                        : Container()
                  ],
                );
              })
        ],
      ),
    );
  }

  customContainer(String img, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffD8D8D8),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              img,
              height: 25,
              width: 25,
              color: AppColor.appColor,
            ),
            ScreenSize.height(9),
            customText(
              title: title,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xff455154),
              fontFamily: FontFamily.interSemiBold,
            )
          ],
        ),
      ),
    );
  }

  PopupMenuButton popupMenuButton() {
    return customPopupMenuButton(
        list: [
          customPopMenuItem(value: 0, title: 'Add members'),
          customPopMenuItem(value: 1, title: 'Change group name'),
          customPopMenuItem(value: 2, title: 'Change group photos'),
          customPopMenuItem(value: 3, title: 'Audio call'),
          customPopMenuItem(value: 4, title: 'Video call'),
        ],
        onSelected: (value) {
          if (value == 0) {
            AppRoutes.pushCupertinoNavigation(const AddMemberScreen());
          } else if (value == 1 || value == 2) {
            AppRoutes.pushCupertinoNavigation(const EditGroupProfile());
          }
        });
  }
}
