import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/check_box.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/file_rack/file_rack_list_screen.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CreateFormScreen extends StatefulWidget {
  const CreateFormScreen({super.key});

  @override
  State<CreateFormScreen> createState() => _CreateFormScreenState();
}

class _CreateFormScreenState extends State<CreateFormScreen> {
  bool switchStatus = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              AppRoutes.pushCupertinoNavigation(const FileRackListScreen());
            }),
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
}
