import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/widget/appbar.dart';

class ViewAllGroupMediaScreen extends StatefulWidget {
  const ViewAllGroupMediaScreen({super.key});

  @override
  State<ViewAllGroupMediaScreen> createState() =>
      _ViewAllGroupMediaScreenState();
}

class _ViewAllGroupMediaScreenState extends State<ViewAllGroupMediaScreen> {
  int tabBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: 'SMEC'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tabBar(),
          Expanded(
              child: tabBarIndex == 0
                  ? mediaWidget()
                  : tabBarIndex == 1
                      ? docsWidget()
                      : linksWidget())
        ],
      ),
    );
  }

  mediaWidget() {
    return GridView.builder(
        itemCount: 40,
        padding: const EdgeInsets.only(top: 15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          return Image.asset('assets/dummay/media.png');
        });
  }

  docsWidget() {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: AppColor.lightGreyD9Color.withOpacity(.5)))),
            child: Row(
              children: [
                Image.asset(
                  'assets/dummay/apk.png',
                  height: 15,
                ),
                ScreenSize.width(11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        title: 'Kodago.apk',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff111B21),
                        fontFamily: FontFamily.interMedium,
                      ),
                      ScreenSize.height(3),
                      Row(
                        children: [
                          customText(
                            title: '18 MB',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff8696A0),
                            fontFamily: FontFamily.interMedium,
                          ),
                          ScreenSize.width(5),
                          Container(
                            height: 6,
                            width: 6,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.lightGreyD9Color),
                          ),
                          ScreenSize.width(5),
                          customText(
                            title: 'APK',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff8696A0),
                            fontFamily: FontFamily.interMedium,
                          ),
                          const Spacer(),
                          customText(
                            title: 'Yesterday',
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff8696A0),
                            fontFamily: FontFamily.interMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  linksWidget() {
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(15);
        },
        itemCount: 10,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
                color: Color(0xffF3F3F3),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10))),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(10)),
                  child: Image.asset(
                    'assets/dummay/links.png',
                    height: 90,
                  ),
                ),
                ScreenSize.width(10),
                Expanded(
                  child: customText(
                    title:
                        'https:/stging.kodago.com/kodago-tech-team/sheets/viewData/1393528/list.....',
                    fontSize: 13,
                    fontFamily: FontFamily.interMedium,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          );
        });
  }

  tabBar() {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              top:
                  BorderSide(color: AppColor.lightGreyD9Color.withOpacity(.7))),
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -1),
                blurRadius: 5,
                color: AppColor.blackColor.withOpacity(.2))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tabBarCustomWidget('MEDIA', 0),
          tabBarCustomWidget('DOCS', 1),
          tabBarCustomWidget('LINKS', 2),
        ],
      ),
    );
  }

  tabBarCustomWidget(String title, int index) {
    return GestureDetector(
      onTap: () {
        tabBarIndex = index;
        setState(() {});
      },
      child: Container(
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: tabBarIndex == index
                ? const Border(
                    bottom: BorderSide(color: AppColor.appColor, width: 2))
                : const Border()),
        child: customText(
          title: title,
          fontSize: 17,
          fontWeight: tabBarIndex == index ? FontWeight.w500 : FontWeight.w400,
          color:
              tabBarIndex == index ? AppColor.b45Color : AppColor.grey7DColor,
          fontFamily: FontFamily.interMedium,
        ),
      ),
    );
  }
}
