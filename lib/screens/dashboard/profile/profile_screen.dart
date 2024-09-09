import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/screens/dashboard/profile/change_password_screen.dart';
import 'package:kodago/screens/dashboard/profile/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          topHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 330),
            child: menuWidget(),
          )
        ],
      ),
    );
  }

  topHeader() {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 100),
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          const Color(0xffD2EDFF).withOpacity(.1),
          const Color(0xffD2EDFF),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                image: DecorationImage(
                  image: AssetImage(
                    AppImages.profileBackgroundImg,
                  ),
                  fit: BoxFit.fill,
                )),
            child: SizedBox(
              height: 130,
              width: 130,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        border: Border.all(
                          width: 5,
                          color: Colors.black26.withOpacity(0.04),
                        )),
                    child: Image.asset('assets/dummay/Image.png'),
                  ),
                  // Positioned(
                  //     right: 0,
                  //     bottom: 0,
                  //     child: Image.asset(
                  //       AppImages.editIcon,
                  //       height: 31,
                  //     ))
                ],
              ),
            ),
          ),
          ScreenSize.height(5),
          customText(
            title: 'Sharwan Kumar',
            fontSize: 17,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interSemiBold,
          ),
          ScreenSize.height(4),
          customText(
            title: '+91 1234567890',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.interRegular,
          ),
        ],
      ),
    );
  }

  menuWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      padding: const EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 30),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: AppColor.blackColor.withOpacity(.2),
                blurRadius: 10)
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          menuTypesWidget(
              img: AppImages.editProfileIcon, title: 'Edit Profile', index: 0),
          ScreenSize.height(16),
          customDivider(),
          ScreenSize.height(16),
          menuTypesWidget(
              img: AppImages.passwordIcon, title: 'Change Password', index: 1),
          ScreenSize.height(16),
          customDivider(),
          ScreenSize.height(16),
          menuTypesWidget(img: AppImages.logoutIcon, title: 'Logout', index: 3),
        ],
      ),
    );
  }

  customDivider() {
    return Container(
      height: 1,
      color: AppColor.borderColor,
    );
  }

  menuTypesWidget(
      {required String img, required String title, required int index}) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          AppRoutes.pushCupertinoNavigation(const EditProfileScreen());
        } else if (index == 1) {
          AppRoutes.pushCupertinoNavigation(const ChangePasswordScreen());
        }
      },
      child: SizedBox(
        height: 35,
        child: Row(
          children: [
            Image.asset(
              img,
              height: 32,
            ),
            ScreenSize.width(11),
            customText(
              title: title,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interMedium,
            ),
            const Spacer(),
            Image.asset(
              AppImages.keyboardRightIcon,
              height: 24,
            )
          ],
        ),
      ),
    );
  }
}
