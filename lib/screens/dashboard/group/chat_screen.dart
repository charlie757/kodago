import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/group/chat_provider.dart';
import 'package:kodago/screens/dashboard/group/group_info_screen.dart';
import 'package:kodago/screens/dashboard/group/hightlight_screen.dart';
import 'package:kodago/widget/popmenuButton.dart';
import 'package:provider/provider.dart';
import '../../../helper/app_images.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, myProvider, child) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.chatBackground), fit: BoxFit.cover),
          color: const Color(0xffEFEAE2),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar(),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  chatTypesWidget(myProvider),
                ],
              ),
            ),
            bottomNavigationBar: commentBoxWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: myProvider.isShowFolderList
                ? folderTypesWidget()
                : Container()),
      );
    });
  }

  chatTypesWidget(ChatProvider chatProvider) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chatProvider.chatTypesList.map((e) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF9F9F9),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, -1),
                      color: AppColor.blackColor.withOpacity(.2),
                      blurRadius: 5)
                ]),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            alignment: Alignment.center,
            child: customText(
              title: e,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
              color: const Color(0xff6F6F6F),
            ),
          );
        }).toList(),
      ),
    );
  }

  folderTypesWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 17),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
          color: AppColor.whiteColor, borderRadius: BorderRadius.circular(10)),
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: context.watch<ChatProvider>().foldersList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            var model = context.watch<ChatProvider>().foldersList[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 52,
                  width: 53,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: model['color']),
                  alignment: Alignment.center,
                  child: Image.asset(
                    model['img'],
                    height: 20,
                  ),
                ),
                ScreenSize.height(6),
                customText(
                  title: model['title'],
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interMedium,
                )
              ],
            );
          }),
    );
  }

  commentBoxWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 13, right: 14, bottom: 15),
      child: Row(
        children: [
          Expanded(child: replyTextField()),
          ScreenSize.width(14),
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.appColor,
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, -2),
                      color: AppColor.blackColor.withOpacity(.2),
                      blurRadius: 5)
                ]),
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.mikeIcon,
              width: 26,
              height: 26,
            ),
          )
        ],
      ),
    );
  }

  replyTextField() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColor.whiteColor,
        ),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Container(
                height: 21,
                width: 21,
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.emojiIcon,
                  height: 21,
                  width: 21,
                ),
              ),
              suffixIcon: Container(
                width: 60,
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!Provider.of<ChatProvider>(context, listen: false)
                            .isShowFolderList) {
                          Provider.of<ChatProvider>(context, listen: false)
                              .isShowFolderList = true;
                        } else {
                          Provider.of<ChatProvider>(context, listen: false)
                              .isShowFolderList = false;
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: 21,
                        width: 21,
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppImages.paperClipIcon,
                          height: 21,
                          width: 21,
                        ),
                      ),
                    ),
                    ScreenSize.width(10),
                    Container(
                      height: 21,
                      width: 21,
                      alignment: Alignment.center,
                      child: Image.asset(
                        AppImages.cameraIcon,
                        height: 21,
                        width: 21,
                      ),
                    ),
                  ],
                ),
              ),
              hintText: 'Search...',
              hintStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColor.grey7DColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interRegular)),
        ));
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
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
          ScreenSize.width(10),
          Image.asset(
            'assets/dummay/Oval (2).png',
            height: 30,
            width: 30,
          ),
          ScreenSize.width(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'SMEC',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontFamily: FontFamily.interSemiBold,
                ),
                ScreenSize.height(4),
                customText(
                  title: 'Tap here for group info',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff6A6A6A),
                  fontFamily: FontFamily.interRegular,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            AppRoutes.pushCupertinoNavigation(const HightlightScreen());
          },
          child: Container(
            height: 30,
            width: 82,
            decoration: BoxDecoration(
                color: AppColor.appColor,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.hightlightIcon,
                  height: 14,
                  width: 14,
                ),
                ScreenSize.width(4),
                customText(
                  title: 'Highlight',
                  fontSize: 12,
                  color: AppColor.whiteColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interRegular,
                )
              ],
            ),
          ),
        ),
        customPopupMenuButton(
            list: [
              customPopMenuItem(value: 0, title: 'Group info'),
              customPopMenuItem(value: 1, title: 'Exit group'),
              customPopMenuItem(value: 2, title: 'Video call'),
              customPopMenuItem(value: 3, title: 'Audio call'),
            ],
            onSelected: (value) {
              if (value == 0) {
                AppRoutes.pushCupertinoNavigation(const GroupInfoScreen());
              }
            })
      ],
    );
  }
}
