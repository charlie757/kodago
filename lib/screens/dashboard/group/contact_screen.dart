import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/group/new_group_provider.dart';
import 'package:kodago/screens/dashboard/group/create_group_screen.dart';
import 'package:kodago/screens/dashboard/group/new_group_screen.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    Provider.of<NewGroupProvider>(context, listen: false).isShow = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
        child: Column(
          children: [
            headerWidget(),
            groupListWidget(),
            ScreenSize.height(17),
            shareInviteWidgt()
          ],
        ),
      ),
      floatingActionButton: context.watch<NewGroupProvider>().isShow
          ? GestureDetector(
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
            )
          : Container(),
    );
  }

  headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            AppRoutes.pushCupertinoNavigation(NewGroupScreen());
          },
          child: Row(
            children: [
              Image.asset(
                AppImages.newGroupIcon,
                height: 40,
                width: 40,
              ),
              ScreenSize.width(11),
              customText(
                title: 'New group',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interMedium,
              )
            ],
          ),
        ),
        ScreenSize.height(18),
        Row(
          children: [
            Image.asset(
              AppImages.newContactIcon,
              height: 40,
              width: 40,
            ),
            ScreenSize.width(11),
            customText(
              title: 'New contact',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.interMedium,
            )
          ],
        ),
        ScreenSize.height(25),
        customText(
          title: 'Your contacts on kodago',
          fontFamily: FontFamily.interMedium,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: const Color(0xff585757),
        ),
        ScreenSize.height(21),
      ],
    );
  }

  groupListWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(17);
        },
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
                  customText(
                    title: index == 4 ? 'Invite' : '',
                    color: AppColor.appColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
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

  shareInviteWidgt() {
    return Row(
      children: [
        Image.asset(
          AppImages.shareInviteIcon,
          height: 33,
          width: 33,
        ),
        ScreenSize.width(16),
        customText(
          title: 'Share invite link',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.interSemiBold,
        )
      ],
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
                  title: 'Select contact',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontFamily: FontFamily.interMedium,
                ),
                ScreenSize.height(4),
                customText(
                  title: '250 contacts',
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
