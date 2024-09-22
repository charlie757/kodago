import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/group/new_group_provider.dart';
import 'package:kodago/presentation/dashboard/group/create_group_screen.dart';
import 'package:provider/provider.dart';

import '../../../uitls/mixins.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen>
    with MediaQueryScaleFactor {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Scaffold(
          appBar: appBar(),
          body: Column(
            children: [
              selectedGroupWidget(),
              groupListWidget(),
            ],
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              AppRoutes.pushCupertinoNavigation(const CreateGroupScreen());
            },
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
                Icons.arrow_forward,
                color: AppColor.whiteColor,
              ),
            ),
          )),
    );
  }

  groupListWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(17);
        },
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        itemCount: context.watch<NewGroupProvider>().groupList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
                        context.watch<NewGroupProvider>().isShow
                            ? Positioned(
                                bottom: 0 + 2,
                                right: 0,
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.whiteColor),
                                      shape: BoxShape.circle,
                                      color: AppColor.appColor),
                                  child: const Icon(
                                    Icons.check,
                                    color: AppColor.whiteColor,
                                    size: 12,
                                  ),
                                ),
                              )
                            : Container()
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
                  ),
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
                    onTap: () {
                      Provider.of<NewGroupProvider>(context, listen: false)
                          .isShow = false;
                      setState(() {});
                    },
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

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'New group',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontFamily: FontFamily.interMedium,
                ),
                ScreenSize.height(4),
                customText(
                  title: 'Add members',
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
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset(
            AppImages.searchIcon,
            height: 17,
            width: 17,
          ),
        )
      ],
    );
  }
}
