import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/dashboard_provider.dart';
import 'package:kodago/services/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../uitls/mixins.dart';

class DashboardScreen extends StatefulWidget {
  final int index;
  DashboardScreen({this.index = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.updateIndex(widget.index);
    Provider.of<ProfileProvider>(context, listen: false).profileModel = null;
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfileApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
          body: myProvider.screenList[myProvider.currentIndex],
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(color: AppColor.whiteColor, boxShadow: [
              BoxShadow(
                  offset: const Offset(0, -1),
                  color: AppColor.blackColor.withOpacity(.1),
                  blurRadius: 5)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bottomNavigationImage(AppImages.homeIcon, 0, 'Home'),
                bottomNavigationImage(AppImages.groupIcon, 1, 'Group'),
                bottomNavigationImage(
                    AppImages.notificationIcon, 2, 'Notification'),
                bottomNavigationImage(AppImages.profileIcon, 3, 'Profile'),
              ],
            ),
          ),
        ),
      );
    });
  }

  bottomNavigationImage(String img, int index, String name) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              Provider.of<DashboardProvider>(context, listen: false)
                  .updateIndex(0);
              break;
            case 1:
              Provider.of<DashboardProvider>(context, listen: false)
                  .updateIndex(1);
              break;
            case 2:
              Provider.of<DashboardProvider>(context, listen: false)
                  .updateIndex(2);
              break;
            case 3:
              Provider.of<DashboardProvider>(context, listen: false)
                  .updateIndex(3);
              break;
          }
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 27,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color:
                        context.watch<DashboardProvider>().currentIndex == index
                            ? AppColor.lightAppColor
                            : null,
                    borderRadius: BorderRadius.circular(40)),
                child: Image.asset(
                  img,
                  height: 18,
                  width: 18,
                  color:
                      context.watch<DashboardProvider>().currentIndex == index
                          ? AppColor.darkAppColor
                          : AppColor.blackColor,
                ),
              ),
              ScreenSize.height(2),
              customText(
                title: name,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily:
                    context.watch<DashboardProvider>().currentIndex == index
                        ? FontFamily.interSemiBold
                        : FontFamily.interRegular,
              )
            ],
          ),
        ),
      ),
    );
  }
}
