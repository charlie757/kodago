import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/check_box.dart';
import 'package:kodago/helper/custom_horizontal_line.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/presentation/dashboard/file_rack/add_data_screen.dart';
import 'package:kodago/presentation/dashboard/file_rack/file_rack_comment_screen.dart';
import 'package:kodago/presentation/dashboard/file_rack/file_rack_history.dart';
import 'package:kodago/presentation/dashboard/file_rack/filter_screen.dart';
import 'package:kodago/presentation/dashboard/home/view_post_screen.dart';
import 'package:kodago/uitls/delete_file_rack_dialogbox.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/popmenuButton.dart';

import '../../../uitls/mixins.dart';

class FileRackDetailsScreen extends StatefulWidget {
  const FileRackDetailsScreen({super.key});

  @override
  State<FileRackDetailsScreen> createState() => _FileRackDetailsScreenState();
}

class _FileRackDetailsScreenState extends State<FileRackDetailsScreen>
    with MediaQueryScaleFactor {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        appBar: appBar(title: 'Test', actions: [
          GestureDetector(
            onTap: () {
              AppRoutes.pushCupertinoNavigation(const AddDataScreen());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
              decoration: BoxDecoration(
                  color: AppColor.appColor,
                  borderRadius: BorderRadius.circular(50)),
              child: customText(
                title: 'Add Record',
                color: AppColor.whiteColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interRegular,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              AppRoutes.pushCupertinoNavigation(const FilterScreen());
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20),
              height: 33,
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xffEDEDED)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.filterIcon,
                    height: 17,
                  ),
                  ScreenSize.width(6),
                  customText(
                    title: 'Filter',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff455154),
                    fontFamily: FontFamily.interMedium,
                  )
                ],
              ),
            ),
          ),
        ]),
        body: ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(20);
            },
            itemCount: 6,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return detailsViewWidget();
            }),
      ),
    );
  }

  detailsViewWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 11, bottom: 11),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileWidget(),
          ScreenSize.height(10),
          customHorizontalDivider(),
          ScreenSize.height(11),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customText(
              title: 'Scheme Name',
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular,
            ),
          ),
          ScreenSize.height(4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customText(
              title:
                  'Work for Retrofitting of Bungi Rajgarh Water Supply Project to provide FHTC including 10 years O&M under JJM District Churu.',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.grey6AColor,
              fontFamily: FontFamily.interRegular,
            ),
          ),
          ScreenSize.height(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customText(
              title: 'Type of Progress Report',
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular,
            ),
          ),
          ScreenSize.height(4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customText(
              title: 'Daily',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.grey6AColor,
              fontFamily: FontFamily.interRegular,
            ),
          ),
          ScreenSize.height(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customText(
              title: 'Date of Inspection',
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular,
            ),
          ),
          ScreenSize.height(4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customText(
              title: '12-06-2024',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.grey6AColor,
              fontFamily: FontFamily.interRegular,
            ),
          ),
          ScreenSize.height(14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customHorizontalDivider(),
          ),
          ScreenSize.height(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    AppRoutes.pushCupertinoNavigation(
                        const FileRackCommentScreen());
                  },
                  child: customText(
                    title: 'Show Comments',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRoutes.pushCupertinoNavigation(const ViewPostScreen());
                  },
                  child: customText(
                    title: 'Show more',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: AppColor.appColor,
                    fontFamily: FontFamily.interMedium,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  profileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 11),
      child: Row(
        children: [
          Image.asset(
            'assets/dummay/Oval (4).png',
            height: 32,
            width: 32,
          ),
          ScreenSize.width(10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: 'Simran',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interMedium,
              ),
              customText(
                title: 'added on 12, Jun 2024 01:34 PM',
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interRegular,
                color: AppColor.grey7DColor,
              ),
            ],
          )),
          popupMenuButton()
        ],
      ),
    );
  }

  PopupMenuButton popupMenuButton() {
    return customPopupMenuButton(
        list: [
          customPopMenuItem(value: 0, title: 'Edit'),
          customPopMenuItem(value: 1, title: 'History'),
          customPopMenuItem(value: 2, title: 'Assign Members'),
          customPopMenuItem(value: 3, title: 'Delete'),
        ],
        onSelected: (value) {
          if (value == 0) {
            // AppRoutes.pushCupertinoNavigation(const AddMemberScreen());
          } else if (value == 1) {
            AppRoutes.pushCupertinoNavigation(const FileRackHistory());
          } else if (value == 2) {
            assignMembersBottomSheet();
          } else if (value == 3) {
            deleteFileRackDialogBox(deleteTap: () {});
          }
        });
  }

  assignMembersBottomSheet() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 21, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE1E1E1)),
                  ),
                ),
                ScreenSize.height(21),
                Align(
                  alignment: Alignment.center,
                  child: customText(
                    title: 'Assign Members',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                  ),
                ),
                ScreenSize.height(27),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, sp) {
                        return ScreenSize.height(10);
                      },
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 15),
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.blackColor.withOpacity(.1),
                                    offset: const Offset(0, 0),
                                    blurRadius: 5)
                              ]),
                          child: Row(
                            children: [
                              customCheckBox(index: index, selectedIndex: 0),
                              ScreenSize.width(12),
                              customText(
                                title: 'Jon Dav',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.interMedium,
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}
