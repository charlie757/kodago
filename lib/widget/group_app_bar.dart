import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:provider/provider.dart';

AppBar groupAppBar(
    {Function()? backOnTap,
    bool isSearchEnable = false,
    String subTitle = '',
    String title = '',
    Function()? searchTap}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        GestureDetector(
          onTap: backOnTap,
          child: Container(
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.arrowForeWordIcon,
              height: 20,
              width: 20,
            ),
          ),
        ),
        ScreenSize.width(15),
        Expanded(
          child: isSearchEnable
              ? textField()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(
                      title: title,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                      fontFamily: FontFamily.interMedium,
                    ),
                    ScreenSize.height(4),
                    customText(
                      title: subTitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                      fontFamily: FontFamily.interRegular,
                    ),
                  ],
                ),
        ),
      ],
    ),
    actions: [
      isSearchEnable
          ? Container()
          : Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: searchTap,
                child: Image.asset(
                  AppImages.searchIcon,
                  height: 17,
                  width: 17,
                ),
              ),
            )
    ],
  );
}

textField() {
  return TextFormField(
    cursorHeight: 20,
    decoration: const InputDecoration(
        isDense: false,
        hintText: 'Search name or number...',
        hintStyle: TextStyle(
            fontSize: 13,
            color: Color(0xff9D9D9D),
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.interRegular),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEEEEEE)),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffEEEEEE)))),
    onChanged: (val) {
      Provider.of<NewGroupProvider>(navigatorKey.currentContext!, listen: false)
          .contactApiFunction(val);
    },
  );
}
