import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/services/provider/notification/notification_provider.dart';
import 'package:kodago/uitls/scroll_loader.dart';
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
    with MediaQueryScaleFactor, SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<NotificationProvider>(context, listen: false);
    provider.clearvalues();
    provider.notificationApiFunction();
  }

  bool closedWhenTap = false;
  late final controller = SlidableController(this);

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
          body: NotificationListener(
            onNotification: (ScrollNotification scrollInfo) {
              if (!myProvider.isLoadingMore &&
                  // myProvider.hasMoreData &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                // User reached the bottom, load more data
                if (myProvider.model!.data!.dbdata!.length <
                    int.parse(myProvider.model!.data!.total.toString())) {
                  myProvider.notificationApiFunction(isLoadMore: true);
                }
              }
              return true;
            },
            child: myProvider.model != null && myProvider.model!.data != null
                ? myProvider.model!.data!.dbdata != null
                    ? SlidableAutoCloseBehavior(
                        closeWhenOpened: true,
                        // closeWhenTapped: closedWhenTap,
                        child: ListView.separated(
                            separatorBuilder: (context, sp) {
                              return ScreenSize.height(25);
                            },
                            itemCount: myProvider.model!.data!.dbdata!.length,
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, bottom: 40),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (index ==
                                      myProvider.model!.data!.dbdata!.length -
                                          1 &&
                                  myProvider.isLoadingMore) {
                                return scrollLoader();
                              } else {
                                return notificationWidget(index, myProvider);
                              }
                            }),
                      )
                    : noDataFound('No notifications')
                : Container(),
          ),
        );
      }),
    );
  }

  notificationWidget(int index, NotificationProvider provider) {
    var model = provider.model!.data!.dbdata![index];
    return Slidable(
      key: Key(index.toString()),
      endActionPane: ActionPane(
        extentRatio: .2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (val) {},
            autoClose: true,
            icon: Icons.abc,
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                // controller.close()
                // Slidable.of(context)?.close();
                print('object');
                setState(() {});
                // Navigator.pop(context);
                provider.deleteNotificationApiFunction(model.rowId).then((val) {
                  if (val != null) {
                    print(val);
                    provider.model!.data!.dbdata!.removeAt(index);
                    setState(() {});
                  }
                });
              },
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
            ),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: ViewNetworkImage(
                img: model.image,
                height: 40.0,
                width: 40.0,
              ),
            ),
            ScreenSize.width(15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    title: model.fromUserName ?? "",
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                    color: AppColor.blackColor,
                    maxLines: 1,
                  ),
                  ScreenSize.height(3),
                  customText(
                    title: model.msg ?? "",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interMedium,
                    color: AppColor.grey6AColor,
                    maxLines: 2,
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
