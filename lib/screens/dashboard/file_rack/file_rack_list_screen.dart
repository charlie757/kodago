import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/file_rack/assign_members_screen.dart';
import 'package:kodago/screens/dashboard/file_rack/file_rack_details_screen.dart';
import 'package:kodago/uitls/delete_file_rack_dialogbox.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/popmenuButton.dart';

class FileRackListScreen extends StatefulWidget {
  const FileRackListScreen({super.key});

  @override
  State<FileRackListScreen> createState() => _FileRackListScreenState();
}

class _FileRackListScreenState extends State<FileRackListScreen> {
  int selectedIndex = 0;
  List list = [
    'Location',
    'Text',
    'Images',
    'Date',
    "Document",
    'Video',
    'Signature',
    'Dropdown',
    'Number',
    'Data from other file rack',
    'Auto Id',
    'Time',
    'User list'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Test'),
      body: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.height(20);
          },
          itemCount: 16,
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(left: 20, right: 0, top: 6, bottom: 20),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                AppRoutes.pushCupertinoNavigation(
                    const FileRackDetailsScreen());
              },
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffE7E7E7)),
                    child: Image.asset(
                      AppImages.fileIcon,
                      height: 21,
                    ),
                  ),
                  ScreenSize.width(15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          title: 'Custom Rack',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.blackColor,
                          fontFamily: FontFamily.interMedium,
                        ),
                        customText(
                          title: 'Last update on 15 Aug 2022 10:55 PM',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColor.grey6AColor,
                          fontFamily: FontFamily.interRegular,
                        )
                      ],
                    ),
                  ),
                  popupMenuButton()
                  // Image.asset(
                  //   AppImages.moreVerticalIcon,
                  //   color: const Color(0xff7D7D7D),
                  //   height: 20,
                  // )
                ],
              ),
            );
          }),
    );
  }

  PopupMenuButton popupMenuButton() {
    return customPopupMenuButton(
        list: [
          customPopMenuItem(value: 0, title: 'Edit'),
          customPopMenuItem(value: 1, title: 'Assign Members'),
          customPopMenuItem(value: 2, title: 'Assign Category'),
          customPopMenuItem(value: 3, title: 'Delete'),
        ],
        onSelected: (value) {
          if (value == 0) {
            // AppRoutes.pushCupertinoNavigation(const AddMemberScreen());
          } else if (value == 1) {
            AppRoutes.pushCupertinoNavigation(const AssignMembersScreen());
          } else if (value == 2) {
            assignCategoryBottomSheet();
          } else if (value == 3) {
            deleteFileRackDialogBox();
          }
        });
  }

  assignCategoryBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * .9,
            padding:
                const EdgeInsets.only(top: 23, left: 20, right: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    title: 'Add Template Fields',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                  ),
                ),
                ScreenSize.height(24),
                CustomTextField(hintText: 'Enter data label'),
                ScreenSize.height(22),
                customText(
                  title: 'Data type',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.interMedium,
                ),
                ScreenSize.height(20),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, sp) {
                        return ScreenSize.height(21);
                      },
                      itemCount: list.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Container(
                              height: 44,
                              width: 44,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xffD6F3E0)),
                              child: Image.asset(
                                AppImages.locationIcon,
                                height: 24,
                              ),
                            ),
                            ScreenSize.width(14),
                            Expanded(
                              child: customText(
                                title: list[index],
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.interSemiBold,
                              ),
                            ),
                            ScreenSize.width(5),
                            customRadio(
                                index: index, selectedIndex: selectedIndex)
                          ],
                        );
                      }),
                ),
                // ScreenSize.height(10),
                CustomBtn(title: 'Add Template', onTap: () {})
              ],
            ),
          );
        });
  }

  customRadio({required int index, required int selectedIndex}) {
    return Container(
      height: 20,
      width: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedIndex == index
              ? AppColor.appColor
              : AppColor.greyD8Color),
      child: selectedIndex == index
          ? const Icon(
              Icons.check,
              color: AppColor.whiteColor,
              size: 14,
            )
          : Container(),
    );
  }
}
