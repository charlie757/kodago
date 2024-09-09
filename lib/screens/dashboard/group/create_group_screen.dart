import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/group/new_group_provider.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF8F8F8),
        appBar: appBar(title: 'New group'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [headerWidget(), membersWidget()],
        ),
        floatingActionButton: GestureDetector(
          onTap: () {},
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
              Icons.check,
              color: AppColor.whiteColor,
            ),
          ),
        ));
  }

  membersWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 18),
          child: customText(
            title: 'Members: 6',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interMedium,
            color: const Color(0xff585757),
          ),
        ),
        ScreenSize.height(21),
        SizedBox(
          height: 67,
          child: ListView.separated(
              separatorBuilder: (conttext, sp) {
                return ScreenSize.width(26);
              },
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: context.watch<NewGroupProvider>().groupList.length,
              itemBuilder: (context, index) {
                var model = context.watch<NewGroupProvider>().groupList[index];
                return SizedBox(
                  width: 43,
                  child: Column(
                    children: [
                      Image.asset(
                        model['img'],
                        height: 42,
                        width: 42,
                      ),
                      ScreenSize.height(5),
                      Text(
                        model['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontFamily.interRegular,
                        ),
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }

  headerWidget() {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      color: AppColor.whiteColor,
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffEAEAEA)),
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.cameraIcon,
              height: 20,
              width: 20,
            ),
          ),
          ScreenSize.width(12),
          Expanded(
              child: TextFormField(
            cursorHeight: 20,
            decoration: InputDecoration(
                isDense: false,
                suffixIcon: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.emojiIcon,
                    height: 18,
                    width: 18,
                  ),
                ),
                hintText: 'Group name',
                hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff9D9D9D),
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interRegular),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEEEE)),
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffEEEEEE)))),
          ))
        ],
      ),
    );
  }
}
