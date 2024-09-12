import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/home/view_story_screen.dart';
import 'package:kodago/widget/home_posts_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, bottom: 30),
        child: Column(
          children: [
            storyWidget(),
            ScreenSize.height(14),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: AppColor.blackColor.withOpacity(.2),
            ),
            ScreenSize.height(11),
            ListView.separated(
                separatorBuilder: (context, sp) {
                  return ScreenSize.height(15);
                },
                itemCount: 4,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return const HomePostsWidget();
                })
          ],
        ),
      )),
    );
  }

  storyWidget() {
    return SizedBox(
      height: 90,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            yourStoryDataWidget(),
            ListView.separated(
                separatorBuilder: (context, sp) {
                  return ScreenSize.width(25);
                },
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 16, right: 15),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return storyDataWidget(
                    'Manish Solanki',
                    'assets/dummay/profile.png',
                  );
                }),
          ],
        ),
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
        width: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 58,
              width: 58,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      colors: [
                        AppColor.storyGradientColor1,
                        AppColor.storyGradientColor2,
                        AppColor.storyGradientColor3,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      tileMode: TileMode.mirror)),
              alignment: Alignment.center,
              child: Container(
                height: 55,
                width: 55,
                decoration: const BoxDecoration(
                  color: AppColor.whiteColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: ClipOval(
                    child: Image.asset(
                  img,
                  height: 50,
                  width: 50,
                )),
              ),
            ),
            ScreenSize.height(8),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 12,
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

  yourStoryDataWidget() {
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
              height: 58,
              width: 58,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: ClipOval(
                  child: Image.asset(
                'assets/dummay/Oval (4).png',
                height: 50,
                width: 50,
              )),
            ),
            ScreenSize.height(8),
            const Padding(
              padding: EdgeInsets.only(left: 3),
              child: Text(
                'Your story',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
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
