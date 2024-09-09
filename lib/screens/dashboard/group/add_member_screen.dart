import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/group/new_group_provider.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'Add members', actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Image.asset(
            AppImages.searchIcon,
            height: 17,
            width: 17,
          ),
        )
      ]),
      body: Column(
        children: [selectedGroupWidget(), Expanded(child: groupListWidget())],
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
      ),
    );
  }

  groupListWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(17);
        },
        itemCount: context.watch<NewGroupProvider>().groupList.length,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(left: 21, right: 20, top: 20, bottom: 30),
        itemBuilder: (context, index) {
          var model = context.watch<NewGroupProvider>().groupList[index];
          return GestureDetector(
            onLongPress: () {
              Provider.of<NewGroupProvider>(context, listen: false).isShow =
                  true;
              setState(() {});
            },
            child: Container(
              color: AppColor.whiteColor,
              child: Row(
                children: [
                  SizedBox(
                    width: 38,
                    child: Stack(
                      children: [
                        Image.asset(
                          model['img'],
                          height: 33,
                          width: 33,
                        ),
                        Positioned(
                          bottom: 0 + 2,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.whiteColor),
                                shape: BoxShape.circle,
                                color: AppColor.appColor),
                            child: const Icon(
                              Icons.check,
                              color: AppColor.whiteColor,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
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
                  )
                ],
              ),
            ),
          );
        });
  }

  selectedGroupWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.separated(
                separatorBuilder: (context, sp) {
                  return ScreenSize.width(10);
                },
                itemCount: context.watch<NewGroupProvider>().groupList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20, right: 20),
                itemBuilder: (context, index) {
                  var model =
                      context.watch<NewGroupProvider>().groupList[index];
                  return GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      width: 50,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Stack(
                              children: [
                                Image.asset(
                                  model['img'],
                                  height: 42,
                                  width: 42,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.whiteColor),
                                        shape: BoxShape.circle,
                                        color: const Color(0xff979797)),
                                    child: const Icon(
                                      Icons.close,
                                      color: AppColor.whiteColor,
                                      size: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          ScreenSize.height(5),
                          Expanded(
                              child: Text(
                            model['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.interRegular,
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                }),
          ),
          ScreenSize.height(19),
          Container(
            height: 1,
            width: double.infinity,
            color: Color(0xffEEEEEE),
          )
        ],
      ),
    );
  }
}
