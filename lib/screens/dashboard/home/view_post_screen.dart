import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/widget/comment_bottomsheet.dart';

class ViewPostScreen extends StatefulWidget {
  const ViewPostScreen({super.key});

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -1),
                    color: AppColor.blackColor.withOpacity(.1),
                    blurRadius: 1)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userInfoHeaderWidget(),
              ScreenSize.height(10),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Image.asset(
                  'assets/dummay/post1.png',
                  height: 200,
                ),
              ),
              ScreenSize.height(18),
              userInfoWidget('User ID', 'RA54AS'),
              userInfoWidget('City', 'Jaipur'),
              userInfoWidget('Location', 'Monroe Township, NJ 08831, USA'),
              userInfoWidget('Number', '12334'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: customText(
                  title: 'Document',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey6AColor,
                  fontFamily: FontFamily.interMedium,
                ),
              ),
              ScreenSize.height(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    documentWidget(AppImages.pdfIcon),
                    ScreenSize.width(8),
                    documentWidget(AppImages.msWordIcon),
                    ScreenSize.width(8),
                    documentWidget(AppImages.excelIcon),
                  ],
                ),
              ),
              ScreenSize.height(13),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: MySeparator(
                  color: Color(0xffC0D0D9),
                ),
              ),
              ScreenSize.height(13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: customText(
                  title: 'Images',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey6AColor,
                  fontFamily: FontFamily.interMedium,
                ),
              ),
              ScreenSize.height(9),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/dummay/img1.png',
                      height: 50,
                      width: 50,
                    ),
                    ScreenSize.width(10),
                    Image.asset(
                      'assets/dummay/img1.png',
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ),
              ScreenSize.height(28),
              GestureDetector(
                onTap: () {
                  commentBottomSheet();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: const Color(0xffF0F5F9),
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 35,
                            spreadRadius: -10,
                            color: AppColor.blackColor.withOpacity(.2))
                      ]),
                  padding: const EdgeInsets.only(left: 19),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Image.asset(
                        AppImages.comment1Icon,
                        height: 18,
                        width: 18,
                      ),
                      ScreenSize.width(6),
                      customText(
                        title: '10 comments',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.interBold,
                        color: AppColor.blackColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  userInfoHeaderWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/dummay/profile1.png',
              height: 50,
              width: 50,
            ),
          ),
          ScreenSize.width(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: 'joshua_l',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interBold,
              ),
              ScreenSize.height(2),
              customText(
                title: 'Added on 04, oct 2022 12:53 pm',
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColor.grey7DColor,
                fontFamily: FontFamily.interRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }

  documentWidget(String img) {
    return Container(
      height: 34,
      width: 34,
      transformAlignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xffC3CDD8))),
      alignment: Alignment.center,
      child: Image.asset(
        img,
        height: 18,
        width: 18,
      ),
    );
  }

  userInfoWidget(String title, String des) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            title: title,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.grey6AColor,
            fontFamily: FontFamily.interMedium,
          ),
          ScreenSize.height(7),
          customText(
            title: des,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColor.blackColor,
            fontFamily: FontFamily.interMedium,
          ),
          ScreenSize.height(14),
          const MySeparator(
            color: Color(0xffC0D0D9),
          ),
          ScreenSize.height(13),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: 'PHED Nagaur Project',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interSemiBold,
              ),
              ScreenSize.height(4),
              customText(
                title: 'File Rack Name',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.appColor,
                fontFamily: FontFamily.interMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
