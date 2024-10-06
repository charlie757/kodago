import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/group/topic_provider.dart';
import 'package:kodago/presentation/dashboard/dashboard_screen.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';
import '../../../helper/custom_btn.dart';
import '../../../uitls/mixins.dart';

class CreateTopicScreen extends StatefulWidget {
  final String route;
  final String groupId;
  const CreateTopicScreen({required this.route, required this.groupId});

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<TopicProvider>(context, listen: false);
    provider.topicList.clear();
    provider.isLoading = false;
    provider.addTopic();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TopicProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        appBar: appBar(
            title: widget.route == 'chat' ? "Add & Edit Topic" : "Create Topic",
            isLeading: widget.route == 'chat' ? true : false),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
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
              ListView.builder(
                itemCount: myProvider.topicList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return textfield(
                      title: '+ Add',
                      isReadOnly: myProvider.topicList.length - 2 > index
                          ? true
                          : false,
                      controller: myProvider.topicList[index],
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          if (myProvider.topicList.length - 1 > index) {
                          } else {
                            myProvider.addTopic();
                          }
                        } else {
                          if (myProvider.topicList.length == index) {
                          } else {
                            myProvider.removeTopic(index + 1);
                          }
                        }
                      });
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBtn(
                  title: "Save",
                  borderRadius: 50,
                  height: 40,
                  isLoading: myProvider.isLoading,
                  onTap: () {
                    if (!myProvider.isLoading) {
                      if (myProvider.topicList[0].text.isEmpty) {
                        Utils.showToast('Please add your topic');
                      } else {
                        myProvider.createTopicApiFunction(
                            widget.groupId, widget.route);
                      }
                    }
                  }),
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
    });
  }

  textfield(
      {required String title,
      required bool isReadOnly,
      TextEditingController? controller,
      ValueChanged<String>? onChanged}) {
    return TextFormField(
      cursorHeight: 20,
      controller: controller,
      readOnly: isReadOnly,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          isDense: false,
          suffixIcon: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.topicMenuIcon,
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
      onChanged: onChanged,
    );
  }
}
