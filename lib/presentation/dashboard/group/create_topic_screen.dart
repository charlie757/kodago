import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/model/topic_provider.dart';
import 'package:kodago/presentation/dashboard/dashboard_screen.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';
import '../../../helper/custom_btn.dart';
import '../../../uitls/mixins.dart';

class CreateTopicScreen extends StatefulWidget {
  final String route;
  const CreateTopicScreen({required this.route});

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen>
    with MediaQueryScaleFactor {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<TopicProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          appBar: appBar(
              title:
                  widget.route == 'chat' ? "Add & Edit Topic" : "Create Topic",
              isLeading: widget.route == 'chat' ? true : false),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'If you are add chat filter by topic please add',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.interSemiBold,
                ),
                ScreenSize.height(24),
                customContainer('Happy Birthday', AppImages.topicMenuIcon),
                ScreenSize.height(15),
                customContainer('+ Add', AppImages.topicMenuIcon),
                ScreenSize.height(15),
                customContainer('+ Add', AppImages.topicMenuIcon),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomBtn(
                    title: "Save", borderRadius: 50, height: 40, onTap: () {}),
                ScreenSize.height(8),
                widget.route == 'chat'
                    ? Container()
                    : InkWell(
                        onTap: () {
                          AppRoutes.pushReplacementNavigation(DashboardScreen(
                            index: 1,
                          ));
                        },
                        child: Container(
                          width: double.infinity,
                          color: AppColor.whiteColor,
                          alignment: Alignment.center,
                          child: customText(
                            title: "Skip",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.appColor,
                            fontFamily: FontFamily.interMedium,
                          ),
                        ),
                      )
              ],
            ),
          ),
        );
      }),
    );
  }

  customContainer(String title, String img) {
    return TextFormField(
      cursorHeight: 20,
      // controller: provider.groupNameController,
      decoration: InputDecoration(
          isDense: false,
          suffixIcon: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            child: Image.asset(
              img,
              height: 18,
              width: 18,
            ),
          ),
          hintText: title,
          hintStyle: const TextStyle(
              fontSize: 13,
              color: Color(0xff9D9D9D),
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD1D4D4)),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.redColor, width: 1),
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffD1D4D4)))),
      validator: (val) {
        if (val!.isEmpty) {
          return "Please enter group name";
        }
      },
    );
    // Container(
    //     padding: const EdgeInsets.only(bottom: 8),
    //     decoration: const BoxDecoration(
    //         border: Border(bottom: BorderSide(color: const Color(0xffD1D4D4)))),
    //     child: TextFormField()
    // Row(
    //   children: [
    //     customText(
    //       title: title,
    //       fontSize: 14,
    //       fontWeight: FontWeight.w400,
    //       fontFamily: FontFamily.interMedium,
    //     ),
    //     const Spacer(),
    //     title.contains('Add')
    //         ? Container()
    //         : Image.asset(
    //             img,
    //             height: 15,
    //           )
    //   ],
    // ),
    // );
  }
}
