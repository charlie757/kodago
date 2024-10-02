import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/selected_contact_widget.dart';
import 'package:kodago/widget/view_contact_widget.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class AddMemberScreen extends StatefulWidget {
  final String groupId;
  const AddMemberScreen({required this.groupId});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen>
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
    provider.contactApiFunction('Ravi');
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<NewGroupProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          appBar: appBar(title: 'Add members', actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                AppImages.searchIcon,
                height: 17,
                width: 17,
              ),
            )
          ]),
          body: myProvider.model != null && myProvider.model!.data != null
              ? Column(
                  children: [
                    myProvider.model!.addedList.isEmpty
                        ? Container()
                        : selectedGroupWidget(myProvider),
                    Expanded(child: groupListWidget(myProvider))
                  ],
                )
              : Container(),
          floatingActionButton:
              myProvider.model != null && myProvider.model!.addedList.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        myProvider.addMemberApiFunction(widget.groupId);
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
                          Icons.check,
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
    return ListView.separated(
        separatorBuilder: (context, sp) {
          return ScreenSize.height(17);
        },
        itemCount: provider.model!.data!.length,
        shrinkWrap: true,
        padding:
            const EdgeInsets.only(left: 21, right: 20, top: 20, bottom: 30),
        itemBuilder: (context, index) {
          return ViewContactWidget(
            model: provider.model!,
            index: index,
          );
        });
  }

  selectedGroupWidget(NewGroupProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectedContactWidget(),
          ScreenSize.height(19),
          Container(
            height: 1,
            width: double.infinity,
            color: const Color(0xffEEEEEE),
          )
        ],
      ),
    );
  }
}
