import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/file_rack/add_data_screen.dart';
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
            AppRoutes.pushCupertinoNavigation(const AddDataScreen());
          } else if (value == 1) {
            AppRoutes.pushCupertinoNavigation(const AssignMembersScreen());
          } else if (value == 2) {
            // assignCategoryBottomSheet();
          } else if (value == 3) {
            deleteFileRackDialogBox();
          }
        });
  }
}
