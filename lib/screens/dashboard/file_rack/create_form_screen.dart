import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/check_box.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../uitls/mixins.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen>with MediaQueryScaleFactor {
  bool switchStatus = false;
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
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
        appBar: appBar(title: 'Test'),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hintText: 'Enter your form name',
                borderColor: AppColor.appColor.withOpacity(.4),
              ),
              ScreenSize.height(22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customText(
                    title: 'Create record',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                  ),
                  Container(
                    // height: 30,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColor.appColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: customText(
                        title: 'Create More',
                        fontSize: 13,
                        fontFamily: FontFamily.interRegular,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              ScreenSize.height(16),
              recordWidget(),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: CustomBtn(
              title: 'Submit',
              onTap: () {
                // AppRoutes.pushCupertinoNavigation(const FileRackListScreen());
              }),
        ),
      ),
    );
  }

  recordWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(hintText: 'Enter field name'),
          ScreenSize.height(12),
          CustomTextField(
            hintText: 'Select data type',
            isReadOnly: true,
            suffixWidget: Container(
              height: 16,
              width: 16,
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.keyboardDownIcon,
                width: 15,
                height: 15,
              ),
            ),
            onTap: () {
              dataTypesBottomSheet();
            },
          ),
          ScreenSize.height(13),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                title: 'Highlight',
                color: AppColor.lightTextColor,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interRegular,
              ),
              FlutterSwitch(
                  width: 48.0,
                  activeText: '',
                  inactiveText: '',
                  height: 22.0,
                  inactiveColor: const Color(0xffD8D8D8),
                  // valueFontSize: 25.0,
                  toggleSize: 20.0,
                  value: switchStatus,
                  borderRadius: 30.0,
                  inactiveToggleColor: const Color(0xff737272),
                  // padding: 8.0,
                  showOnOff: true,
                  onToggle: (val) {
                    switchStatus = val;
                    setState(() {});
                  }),
            ],
          ),
          ScreenSize.height(12),
          const MySeparator(
            color: Color(0xffD3D3D3),
          ),
          ScreenSize.height(14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              typesCheckboxWidget(title: 'Mandatory', index: 0),
              typesCheckboxWidget(title: 'Lock', index: 1),
              typesCheckboxWidget(title: 'Non-editable', index: 2),
            ],
          ),
          ScreenSize.height(12),
          typesCheckboxWidget(title: 'Default Data', index: 3),
        ],
      ),
    );
  }

  typesCheckboxWidget({required String title, required int index}) {
    return Row(
      children: [
        customCheckBox(index: index, selectedIndex: selectedIndex),
        ScreenSize.width(8),
        customText(
          title: title,
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColor.grey6AColor,
          fontFamily: FontFamily.interMedium,
        )
      ],
    );
  }

  dataTypesBottomSheet() {
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
