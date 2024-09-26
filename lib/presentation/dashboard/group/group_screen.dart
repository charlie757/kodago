import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_searchbar.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/presentation/dashboard/group/chat_screen.dart';
import 'package:kodago/presentation/dashboard/group/contact_screen.dart';
import 'package:kodago/presentation/shimmer/gropup_shimmer.dart';
import 'package:kodago/provider/group/group_provider.dart';
import 'package:kodago/uitls/time_format.dart';
import 'package:kodago/widget/popmenuButton.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> with MediaQueryScaleFactor {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<GroupProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      provider.groupApiFunction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(),
          body: NotificationListener(
            // onNotification: (ScrollNotification scrollInfo) {
            // if (!myProvider.isLoadingMore &&
            //     myProvider.hasMoreData &&
            //     scrollInfo.metrics.pixels ==
            //         scrollInfo.metrics.maxScrollExtent) {
            //   // User reached the bottom, load more data
            //   myProvider.groupApiFunction(isLoadMore: true);
            // }
            // return true;
            // },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const CustomSearchbar(),
                  ScreenSize.height(14),
                  Row(
                    children: [
                      msgListTypesWidget('All'),
                      ScreenSize.width(10),
                      msgListTypesWidget('Unread'),
                      ScreenSize.width(10),
                      msgListTypesWidget('Groups'),
                    ],
                  ),
                  Expanded(
                    child: myProvider.isLoading
                        ? const GropupShimmer()
                        : myProvider.model != null &&
                                myProvider.model!.data != null
                            ? ListView.separated(
                                separatorBuilder: (context, index) {
                                  return ScreenSize.height(20);
                                },
                                itemCount: myProvider.model!.data!.length,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 30),
                                itemBuilder: (context, index) {
                                  if (index == myProvider.model!.data!.length &&
                                      myProvider.isLoadingMore) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return groupWidget(index, myProvider);
                                  }
                                })
                            : Container(),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              AppRoutes.pushCupertinoNavigation(const ContactScreen());
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
                Icons.add,
                color: AppColor.whiteColor,
              ),
            ),
          ),
        ),
      );
    });
  }

  msgListTypesWidget(
    String title,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 5, horizontal: title.toLowerCase() == 'all' ? 20 : 14),
      decoration: BoxDecoration(
          color: title.toLowerCase() == 'all'
              ? AppColor.lightAppColor
              : const Color(0xffF9F9F9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: title.toLowerCase() == 'all'
              ? []
              : [
                  BoxShadow(
                      offset: const Offset(0, 0),
                      blurRadius: 2,
                      color: AppColor.blackColor.withOpacity(.1))
                ]),
      child: customText(
        title: title,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: title.toLowerCase() == 'all'
            ? AppColor.darkAppColor
            : AppColor.grey6AColor,
        fontFamily: FontFamily.interMedium,
      ),
    );
  }

  groupWidget(int index, GroupProvider provider) {
    var model = provider.model!.data![index];
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(const ChatScreen());
      },
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: ViewNetworkImage(
              img: model.image,
              height: 45.0,
              width: 45.0,
            ),
          ),
          ScreenSize.width(11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: model.name ?? "",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontFamily: FontFamily.interSemiBold,
                  maxLines: 1,
                ),
                ScreenSize.height(4),
                customText(
                  title: model.alias ?? '',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey7DColor,
                  fontFamily: FontFamily.interRegular,
                ),
              ],
            ),
          ),
          ScreenSize.width(5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: TimeFormat.convertDate(model.createdAt),
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: AppColor.grey7DColor,
                fontFamily: FontFamily.interRegular,
              ),
            ],
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Image.asset(
        AppImages.appLogo,
        height: 25,
        width: 94,
      ),
      actions: [
        customPopupMenuButton(
            list: [
              customPopMenuItem(value: 0, title: 'New Group'),
              customPopMenuItem(value: 1, title: 'Settings'),
            ],
            onSelected: (value) {
              // if (value == 0) {
              //   AppRoutes.pushCupertinoNavigation(const GroupInfoScreen());
              // }
            })
      ],
    );
  }
}
