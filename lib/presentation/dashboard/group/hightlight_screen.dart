import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/home/home_provider.dart';
import 'package:kodago/widget/feeds_widget.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class HightlightScreen extends StatefulWidget {
  const HightlightScreen({super.key});

  @override
  State<HightlightScreen> createState() => _HightlightScreenState();
}

class _HightlightScreenState extends State<HightlightScreen>
    with MediaQueryScaleFactor {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
          appBar: appBar(),
          body: myProvider.feedsModel != null &&
                  myProvider.feedsModel!.data != null
              ? ListView.separated(
                  separatorBuilder: (context, sp) {
                    return ScreenSize.height(15);
                  },
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  itemCount: myProvider.feedsModel!.data!.feeds!.length,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return FeedsWidget(
                      index: index,
                      feedsModel: myProvider.feedsModel,
                    );
                  })
              : Container(),
        ),
      );
    });
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
          ScreenSize.width(10),
          Image.asset(
            'assets/dummay/Oval.png',
            height: 30,
            width: 30,
          ),
          ScreenSize.width(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'Kodago Attendance',
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
        Container(
          height: 29,
          width: 60,
          decoration: BoxDecoration(
              color: AppColor.appColor, borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.chatIcon,
                height: 14,
                width: 14,
              ),
              ScreenSize.width(4),
              customText(
                title: 'Chat',
                fontSize: 12,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interRegular,
              )
            ],
          ),
        ),
        ScreenSize.width(10),
        Image.asset(
          AppImages.moreVerticalIcon,
          height: 20,
          width: 20,
          color: AppColor.grey7DColor,
        ),
        ScreenSize.width(10),
      ],
    );
  }
}
