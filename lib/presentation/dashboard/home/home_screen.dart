import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/presentation/shimmer/story_shimmer.dart';
import 'package:kodago/provider/home/home_provider.dart';
import 'package:kodago/presentation/shimmer/post_shimmer.dart';
import 'package:kodago/presentation/dashboard/home/view_story_screen.dart';
import 'package:kodago/widget/home_posts_widget.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with MediaQueryScaleFactor {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.clearvalues();
    provider.feedsApiFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
          body: SafeArea(
              child: NotificationListener(
            onNotification: (ScrollNotification scrollInfo) {
              if (!myProvider.isLoadingMore &&
                  myProvider.hasMoreData &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                // User reached the bottom, load more data
                myProvider.feedsApiFunction(isLoadMore: true);
              }
              return true;
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset(
                      AppImages.appLogo,
                      height: 25,
                      width: 94,
                    ),
                  ),
                  ScreenSize.height(10),
                  myProvider.isLoading
                      ? const StoryShimmer()
                      : myProvider.feedsModel != null &&
                              myProvider.feedsModel!.data != null
                          ? storyWidget(myProvider)
                          : Container(),
                  ScreenSize.height(15),
                  myProvider.isLoading
                      ? const PostShimmer()
                      : myProvider.feedsModel != null &&
                              myProvider.feedsModel!.data != null
                          ? ListView.separated(
                              separatorBuilder: (context, sp) {
                                return ScreenSize.height(29);
                              },
                              itemCount:
                                  myProvider.feedsModel!.data!.feeds!.length,
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (index ==
                                        myProvider
                                            .feedsModel!.data!.feeds!.length &&
                                    myProvider.isLoadingMore) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return HomePostsWidget(
                                    index: index,
                                    feedsModel: myProvider.feedsModel,
                                  );
                                }
                              })
                          : Container()
                ],
              ),
            ),
          )),
        ),
      );
    });
  }

  storyWidget(HomeProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          yourStoryDataWidget(),
          ScreenSize.width(15),
          provider.feedsModel!.data!.stories!.isNotEmpty ||
                  provider.feedsModel!.data!.stories != null
              ? Row(
                  children: List.generate(
                      provider.feedsModel!.data!.stories!.length, (val) {
                    var model = provider.feedsModel!.data!.stories![val];
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: storyDataWidget(
                        model.name,
                        model.imageLink,
                      ),
                    );
                  }),
                )
              : Container(),
        ],
      ),
    );
  }

  storyDataWidget(
    String title,
    String img,
  ) {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(const ViewStoryScreen());
      },
      child: SizedBox(
        width: 70,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [
                        AppColor.storyGradientColor2,
                        AppColor.storyGradientColor1,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      tileMode: TileMode.mirror)),
              alignment: Alignment.center,
              child: Container(
                height: 66,
                width: 66,
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: ClipOval(
                    child: ViewNetworkImage(
                  img: img,
                  height: 70.0,
                  width: 70.0,
                )),
              ),
            ),
            ScreenSize.height(2),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: customText(
                  title: title,
                  maxLines: 1,
                  fontSize: 11,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interMedium,
                  color: const Color(0xff262626)),
            ),
          ],
        ),
      ),
    );
  }

  yourStoryDataWidget() {
    return GestureDetector(
      onTap: () {
        AppRoutes.pushCupertinoNavigation(const ViewStoryScreen());
      },
      child: SizedBox(
        width: 70,
        child: Column(
          children: [
            ClipOval(
                child: Image.asset(
              'assets/dummay/Profile Image.png',
              height: 70,
              width: 70,
            )),
            const Padding(
              padding: EdgeInsets.only(left: 0, top: 2),
              child: Text(
                'Your story',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interMedium,
                    color: Color(0xff262626)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
