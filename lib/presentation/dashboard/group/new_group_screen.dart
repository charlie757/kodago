import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/presentation/dashboard/group/create_group_screen.dart';
import 'package:kodago/widget/group_app_bar.dart';
import 'package:kodago/widget/selected_contact_widget.dart';
import 'package:kodago/widget/view_contact_widget.dart';
import 'package:provider/provider.dart';

import '../../../uitls/mixins.dart';

class NewGroupScreen extends StatefulWidget {
  final bool isCallApi;
  const NewGroupScreen({this.isCallApi = false});

  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen>
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
    final provider = Provider.of<NewGroupProvider>(context, listen: false);
    provider.addedList.clear();
    // if (widget.isCallApi) {
      provider.contactApiFunction('Ravi', showLoading: true);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<NewGroupProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          appBar: appBar(),
          body: myProvider.contactList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myProvider.addedList.isNotEmpty
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
          floatingActionButton: myProvider.addedList.isNotEmpty
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
    return provider.contactList.isNotEmpty
        ? ListView.separated(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 30),
            separatorBuilder: (context, sp) {
              return ScreenSize.height(17);
            },
            itemCount: provider.contactList.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return ViewContactWidget(
                contactList: provider.contactList,
                index: index,
              );
            })
        : Container();
  }

  AppBar appBar() {
    return groupAppBar(
        subTitle: 'Add members',
        title: 'New group',
        isSearchEnable: isSearchEnable,
        searchTap: () {
          // isSearchEnable = true;
          setState(() {});
        },
        backOnTap: () {
          // if (isSearchEnable) {
          //   isSearchEnable = false;
          //   setState(() {});
          // } else {
            // Provider.of<NewGroupProvider>(context,listen: false).contactApiFunction('Ravi', showLoading: true);
            Navigator.pop(context);
          // }
        });
  }
}
