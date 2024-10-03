import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/presentation/dashboard/group/create_group_screen.dart';
import 'package:kodago/widget/selected_contact_widget.dart';
import 'package:kodago/widget/view_contact_widget.dart';
import 'package:provider/provider.dart';

import '../../../uitls/mixins.dart';

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen>
    with MediaQueryScaleFactor {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<NewGroupProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          appBar: appBar(),
          body: myProvider.model != null && myProvider.model!.data != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myProvider.model!.addedList.isNotEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: SelectedContactWidget(
                              topClose: false,
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: groupListWidget(myProvider),
                    )
                  ],
                )
              : Container(),
          floatingActionButton:
              myProvider.model != null && myProvider.model!.addedList.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        AppRoutes.pushCupertinoNavigation(
                            const CreateGroupScreen());
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
                  : Container(),
        );
      }),
    );
  }

  groupListWidget(NewGroupProvider provider) {
    return provider.model != null && provider.model!.data != null
        ? ListView.separated(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
            separatorBuilder: (context, sp) {
              return ScreenSize.height(17);
            },
            itemCount: provider.model!.data!.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return ViewContactWidget(
                model: provider.model!,
                index: index,
              );
            })
        : Container();
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'New group',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackColor,
                  fontFamily: FontFamily.interMedium,
                ),
                ScreenSize.height(4),
                customText(
                  title: 'Add members',
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
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset(
            AppImages.searchIcon,
            height: 17,
            width: 17,
          ),
        )
      ],
    );
  }
}
