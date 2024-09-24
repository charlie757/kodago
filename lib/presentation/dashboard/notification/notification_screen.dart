import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/notification/notification_provider.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kodago/widget/no_data_found.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    provider.notificationApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child:
          Consumer<NotificationProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          appBar: appBar(
              title: 'Notification',
              isLeading: false,
              titleColor: AppColor.appColor),
          body: myProvider.model != null && myProvider.model!.data != null
              ? myProvider.model!.data!.dbdata != null
                  ? SlidableAutoCloseBehavior(
                      child: ListView.separated(
                          separatorBuilder: (context, sp) {
                            return ScreenSize.height(25);
                          },
                          itemCount: myProvider.model!.data!.dbdata!.length,
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, bottom: 40),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return notificationWidget(index, myProvider);
                          }),
                    )
                  : noDataFound('No notifications')
              : Container(),
        );
      }),
    );
  }

  notificationWidget(int index, NotificationProvider provider) {
    var model = provider.model!.data!.dbdata![index];
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .2,
        motion: const ScrollMotion(),
        children: [
          Flexible(
            child: Container(
              width: 50,
              height: 100,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Color(0xffFF4141),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Image.asset(
                AppImages.delete1Icon,
                height: 20,
              ),
            ),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Row(
          children: [
            Image.asset(
              'assets/dummay/Avatar.png',
              height: 40,
              width: 40,
            ),
            ScreenSize.width(15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    title: 'Anaya Sanji',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                    color: AppColor.blackColor,
                  ),
                  ScreenSize.height(3),
                  customText(
                    title: 'Let’s have a call for a future projects...',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interMedium,
                    color: AppColor.grey6AColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
