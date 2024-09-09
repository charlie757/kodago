import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/filter_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: appBar(title: 'Filter'),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              title: 'Added By',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              icon: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.keyboardDownIcon,
                  height: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            ScreenSize.height(12),
            customText(
              title: 'Created Date',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            mergeTextField(hint1: 'From', hint2: 'To'),
            ScreenSize.height(12),
            customText(
              title: 'Text',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Text',
              icon: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.keyboardDownIcon,
                  height: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            ScreenSize.height(12),
            customText(
              title: 'Date',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Date',
              icon: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.dateIcon,
                  height: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            ScreenSize.height(12),
            customText(
              title: 'Dropdown',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Dropdown',
              icon: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.keyboardDownIcon,
                  height: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            ScreenSize.height(12),
            customText(
              title: 'Number',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Number',
            ),
            ScreenSize.height(12),
            customText(
              title: 'Auto ID',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Auto ID',
            ),
            ScreenSize.height(12),
            customText(
              title: 'Drop Multi',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'All',
              icon: Container(
                height: 18,
                width: 18,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.keyboardDownIcon,
                  height: 18,
                  color: AppColor.blackColor,
                ),
              ),
            ),
            ScreenSize.height(12),
            customText(
              title: 'State',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'State',
            ),
            ScreenSize.height(36),
            mergeTextField(hint1: 'Future', hint2: 'Past'),
            ScreenSize.height(12),
            customText(
              title: 'State Scholarship no',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'State Scholarship no',
            ),
            ScreenSize.height(12),
            customText(
              title: 'State Toll free number',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'State Toll free number',
            ),
            ScreenSize.height(12),
            customText(
              title: 'City',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Ctiy',
            ),
            ScreenSize.height(12),
            customText(
              title: 'City Toll free number',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'City Toll free number',
            ),
            ScreenSize.height(12),
            customText(
              title: 'District',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'District',
            ),
            ScreenSize.height(12),
            customText(
              title: 'Text non edit',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Text non edit',
            ),
            ScreenSize.height(12),
            customText(
              title: 'Number Lock',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            ScreenSize.height(10),
            FilterTextfield(
              hintText: 'Number Lock',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomBtn(title: 'Apply Filter', onTap: () {}),
            ScreenSize.height(10),
            Container(
              height: 30,
              alignment: Alignment.center,
              child: customText(
                title: 'Reset Filter',
                color: AppColor.appColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

  mergeTextField(
      {String errorMsg = '', required String hint1, required String hint2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 4),
                      color: AppColor.blackColor.withOpacity(.2))
                ]),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(child: texfield(hintText: hint1)),
                  Container(
                    padding: const EdgeInsets.only(top: 13, bottom: 13),
                    child: const VerticalDivider(
                      color: AppColor.lightGreyD9Color,
                    ),
                  ),
                  Expanded(child: texfield(hintText: hint2)),
                ],
              ),
            )),
        errorMsg == ''
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 4, top: 5),
                child: customText(
                    title: errorMsg.toString(),
                    fontSize: 12,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.redColor,
                    fontWeight: FontWeight.w500),
              )
      ],
    );
  }

  texfield(
      {String errorMsg = '',
      String hintText = '',
      TextEditingController? controller,
      final icon}) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      cursorColor: AppColor.blackColor,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: AppColor.blackColor,
          fontFamily: FontFamily.interRegular),
      decoration: InputDecoration(
          suffixIcon: Container(
            alignment: Alignment.center,
            height: 18,
            width: 18,
            child: Image.asset(
              AppImages.dateIcon,
              height: 18,
            ),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: AppColor.grey6AColor,
              fontFamily: FontFamily.interRegular),
          fillColor: AppColor.whiteColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: errorMsg == ''
                      ? AppColor.whiteColor
                      : AppColor.redColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: errorMsg == ''
                      ? AppColor.whiteColor
                      : AppColor.redColor))),
    );
  }
}
