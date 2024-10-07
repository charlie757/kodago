import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/group/contact_provider.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/presentation/dashboard/group/new_group_screen.dart';
import 'package:kodago/widget/group_app_bar.dart';
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

  bool isSearchEnable = false;

  callInitFunction() async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    provider.contactApiFunction('ravi', showLoading: true);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<ContactProvider>(builder: (context, myProvider, child) {
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

  groupListWidget(ContactProvider provider) {
    return provider.contactList.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (context, sp) {
              return ScreenSize.height(17);
            },
            itemCount: provider.contactList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ViewContactWidget(
                  contactList: provider.contactList,
                  index: index,
                  isSelect: false);
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

  AppBar appBar(ContactProvider provider) {
    return groupAppBar(
        subTitle: '${provider.contactList.length} contacts',
        title: 'Select contact',
        isSearchEnable: isSearchEnable,
        searchTap: () {
          isSearchEnable = true;
          setState(() {});
        },
        backOnTap: () {
          if (isSearchEnable) {
            isSearchEnable = false;
            setState(() {});
          } else {
            Navigator.pop(context);
          }
        });
  }
}
