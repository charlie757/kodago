import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/presentation/dashboard/group/create_group_screen.dart';
import 'package:kodago/presentation/dashboard/group/new_group_screen.dart';
import 'package:kodago/widget/view_contact_widget.dart';
import 'package:provider/provider.dart';

import '../../../uitls/mixins.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<NewGroupProvider>(context, listen: false);
    provider.clearValues();
    provider.contactApiFunction('ravi', showLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<NewGroupProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          appBar: appBar(myProvider),
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
            child: Column(
              children: [
                headerWidget(),
                groupListWidget(myProvider),
                ScreenSize.height(17),
                shareInviteWidgt()
              ],
            ),
          ),
        );
      }),
    );
  }

  headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            AppRoutes.pushCupertinoNavigation(const NewGroupScreen());
          },
          child: Row(
            children: [
              Image.asset(
                AppImages.newGroupIcon,
                height: 30,
                width: 30,
              ),
              ScreenSize.width(11),
              customText(
                title: 'New group',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interMedium,
              )
            ],
          ),
        ),
        ScreenSize.height(25),
        customText(
          title: 'Your contacts on kodago',
          fontFamily: FontFamily.interMedium,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: const Color(0xff585757),
        ),
        ScreenSize.height(21),
      ],
    );
  }

  groupListWidget(NewGroupProvider provider) {
    return provider.model != null && provider.model!.data != null
        ? ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(17);
            },
            itemCount: provider.model!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ViewContactWidget(
                  model: provider.model!, index: index, isSelect: false);
            })
        : Container();
  }

  shareInviteWidgt() {
    return Row(
      children: [
        Image.asset(
          AppImages.shareInviteIcon,
          height: 33,
          width: 33,
        ),
        ScreenSize.width(16),
        customText(
          title: 'Share invite link',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.interSemiBold,
        )
      ],
    );
  }

  AppBar appBar(NewGroupProvider provider) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (provider.isSearchEnable) {
                provider.isSearchEnable = false;
                setState(() {});
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              alignment: Alignment.center,
              child: Image.asset(
                AppImages.arrowForeWordIcon,
                height: 20,
                width: 20,
              ),
            ),
          ),
          ScreenSize.width(15),
          Expanded(
            child: provider.isSearchEnable
                ? textField(provider)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        title: 'Select contact',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                        fontFamily: FontFamily.interMedium,
                      ),
                      ScreenSize.height(4),
                      customText(
                        title:
                            '${provider.model != null && provider.model!.data != null ? provider.model!.data!.length : ''} contacts',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColor.blackColor,
                        fontFamily: FontFamily.interRegular,
                      ),
                    ],
                  ),
          ),
        ],
      ),
      actions: [
        provider.isSearchEnable
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () {
                    provider.isSearchEnable = true;
                    setState(() {});
                  },
                  child: Image.asset(
                    AppImages.searchIcon,
                    height: 17,
                    width: 17,
                  ),
                ),
              )
      ],
    );
  }

  textField(NewGroupProvider provider) {
    return TextFormField(
      cursorHeight: 20,
      decoration: const InputDecoration(
          isDense: false,
          // prefixIcon: GestureDetector(
          //   onTap: () {},
          //   child: Container(
          //     height: 20,
          //     width: 20,
          //     alignment: Alignment.center,
          //     child: Image.asset(
          //       AppImages.arrowForeWordIcon,
          //       height: 18,
          //       width: 18,
          //     ),
          //   ),
          // ),
          hintText: 'Search name or number...',
          hintStyle: TextStyle(
              fontSize: 13,
              color: Color(0xff9D9D9D),
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.interRegular),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffEEEEEE)),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffEEEEEE)))),
      onChanged: (val) {
        // provider.contactApiFunction(val);
      },
    );
  }
}
