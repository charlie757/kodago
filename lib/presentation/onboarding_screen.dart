import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/onboarding_provider.dart';
import 'package:kodago/presentation/auth/login_screen.dart';
import 'package:kodago/presentation/dashboard/dashboard_screen.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(builder: (context, myProvider, child) {
      print(context.watch<OnboardingProvider>().currentIndex);
      return Scaffold(
        body: Column(
          children: [
            const Spacer(),
            Image.asset(myProvider.onboardingList[myProvider.currentIndex].img),
            customText(
              title: myProvider.onboardingList[myProvider.currentIndex].title,
              color: AppColor.blackDarkColor,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              fontFamily: FontFamily.interSemiBold,
              textAlign: TextAlign.center,
            ),
            ScreenSize.height(12),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: customText(
                title: myProvider.onboardingList[myProvider.currentIndex].des,
                fontSize: 14,
                color: AppColor.lightTextColor,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                fontFamily: FontFamily.poppinsRegular,
              ),
            ),
            const Spacer(),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(myProvider.onboardingList.length, (index) {
                  return myProvider.currentIndex == index
                      ? indicator(false)
                      : indicator(true);
                })),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 36, right: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      AppRoutes.pushReplacementNavigation(
                          const DashboardScreen());
                    },
                    child: customText(
                      title: "Skip..",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColor.blackColor,
                      fontFamily: FontFamily.poppinsMedium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (myProvider.currentIndex < 2) {
                        myProvider.updateIndex(myProvider.currentIndex + 1);
                      } else {
                        SessionManager.setFirstTimeOpenApp = true;
                        AppRoutes.pushCupertinoNavigation(const LoginScreen());
                      }
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
                        Icons.arrow_forward,
                        color: AppColor.whiteColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget indicator(bool isActive) {
    return SizedBox(
      height: 12,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: 12.0,
        width: 12.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !isActive ? AppColor.appColor : AppColor.lightGreyD9Color,
        ),
      ),
    );
  }
}
