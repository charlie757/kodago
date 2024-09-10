import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, myProvider, child) {
      return Scaffold(
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
              bottomNavigationImage(
                AppImages.homeIcon,
                0,
              ),
              bottomNavigationImage(AppImages.groupIcon, 1),
              bottomNavigationImage(AppImages.notificationIcon, 2),
              bottomNavigationImage(AppImages.profileIcon, 3),
            ],
          ),
        ),
      );
    });
  }

  bottomNavigationImage(
    String img,
    int index,
  ) {
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
          child: Image.asset(
            img,
            height: 26,
            width: 26,
            color: context.watch<DashboardProvider>().currentIndex == index
                ? AppColor.appColor
                : AppColor.blackColor,
          ),
        ),
      ),
    );
  }
}
