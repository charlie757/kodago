import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/presentation/dashboard/file_rack/file_rack_list_screen.dart';
import 'package:kodago/services/provider/group/group_details_provider.dart';
import 'package:kodago/presentation/dashboard/group/add_member_screen.dart';
import 'package:kodago/presentation/dashboard/group/edit_group_profile.dart';
import 'package:kodago/presentation/dashboard/group/hightlight_screen.dart';
import 'package:kodago/presentation/dashboard/group/view_all_group_media_screen.dart';
import 'package:kodago/services/share_service.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/time_format.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/dialog_box.dart';
import 'package:kodago/widget/no_data_found.dart';
import 'package:kodago/widget/popmenuButton.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class GroupInfoScreen extends StatefulWidget {
  final String groupId;
  const GroupInfoScreen({required this.groupId});

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen>
    with MediaQueryScaleFactor {

      bool isSearchEnable = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() async {
    final provider = Provider.of<GroupDetailsProvider>(context, listen: false);
    provider.clearValues();
    provider.groupDetailsApiFunction(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupDetailsProvider>(
        builder: (context, myProvider, child) {
      return Scaffold(
        appBar: appBar(title: '', actions: [popupMenuButton()]),
        body:myProvider.model == null
              ? noDataFound("no data found")
              :  SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    groupDetailsWidget(myProvider),
                    ScreenSize.height(26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customContainer(AppImages.fileIcon, 'Form', () {
                            AppRoutes.pushCupertinoNavigation(
                                FileRackListScreen(
                              groupId: widget.groupId,
                              groupName: myProvider.model!.data != null &&
                                      myProvider.model!.data!.groupDetail !=
                                          null
                                  ? myProvider
                                          .model!.data!.groupDetail!.name ??
                                      ""
                                  : "",
                            ));
                          }),
                          ScreenSize.width(10),
                          customContainer(
                              AppImages.hightlightIcon, 'Highlight', () {
                            AppRoutes.pushCupertinoNavigation(
                                const HightlightScreen());
                          }),
                          ScreenSize.width(10),
                          customContainer(
                              AppImages.analyticsIon, 'Analytics', () {}),
                          ScreenSize.width(10),
                          customContainer(AppImages.addUserIcon, 'Add', () {
                            AppRoutes.pushCupertinoNavigation(AddMemberScreen(
                              groupId: widget.groupId,
                            )).then((val) {
                              Provider.of<GroupDetailsProvider>(context,
                                      listen: false)
                                  .groupDetailsApiFunction(widget.groupId,
                                      isShowLoader: false);
                            });
                          }),
                        ],
                      ),
                    ),
                    ScreenSize.height(19),
                    groupDescriptionWidget(myProvider),
                    ScreenSize.height(8),
                    invateLinkWidget(myProvider),
                    ScreenSize.height(17),
                    mediaLinksWidget(),
                    ScreenSize.height(19),
                    membersWidget(myProvider),
                    ScreenSize.height(22),
                    myProvider.memberId.isNotEmpty?
                    GestureDetector(
                      onTap: () {
                        dialogBox(title: 'Exit Group', des: "Are you sure you want to exit the group?",yesTap:(){
                          myProvider.exitGroupApiFunction(widget.groupId, myProvider.memberId, GroupAction.remove.name);
                        } );
                      },
                      child: Container(
                        width: double.infinity,
                        color: AppColor.whiteColor,
                        padding: const EdgeInsets.only(left: 18),
                        child: Row(
                          children: [
                            Image.asset(
                              AppImages.logoutIcon,
                              height: 22,
                              width: 22,
                            ),
                            ScreenSize.width(12),
                            customText(
                              title: 'Exit group',
                              color: AppColor.redColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.interMedium,
                            )
                          ],
                        ),
                      ),
                    ):const SizedBox.shrink()
                  ],
                ),
        ),
      );
    });
  }

  groupDetailsWidget(GroupDetailsProvider provider) {
    var model = provider.model!.data!.groupDetail!;
    return Column(
      children: [
        ClipOval(
          child: ViewNetworkImage(
            img: model.imageLink,
            height: 73.0,
          ),
        ),
        ScreenSize.height(10),
        customText(
          title: model.name ?? '',
          fontSize: 19,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.interSemiBold,
          textAlign: TextAlign.center,
        ),
        ScreenSize.height(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customText(
              title: 'Group',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColor.grey7DColor,
            ),
            ScreenSize.width(6),
            const Padding(
              padding: EdgeInsets.only(top: 3),
              child: Icon(
                Icons.circle,
                size: 5,
                color: AppColor.grey7DColor,
              ),
            ),
            ScreenSize.width(5),
            customText(
              title: '${provider.globalGroupDetailsModel!.data!.groupDetail!.members!.length} members',
              fontSize: 13,
              color: AppColor.grey7DColor,
              fontWeight: FontWeight.w400,
            )
          ],
        )
      ],
    );
  }

  groupDescriptionWidget(GroupDetailsProvider provider) {
    var model = provider.model!.data!.groupDetail!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          border: Border(
              top: BorderSide(
                  width: 1, color: AppColor.lightGreyD9Color.withOpacity(.4)),
              bottom: BorderSide(
                  width: 1, color: AppColor.lightGreyD9Color.withOpacity(.4)))),
      padding: const EdgeInsets.only(top: 16, left: 19, bottom: 15, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            title: 'Add group description',
            fontSize: 14,
            color: AppColor.appColor,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interMedium,
          ),
          ScreenSize.height(4),
          customText(
            title:model.members!.isNotEmpty?
                "Created by ${provider.groupCreatedName}, ${TimeFormat.convertDate(model.createdAt)}":"",
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff455154),
            fontFamily: FontFamily.interMedium,
          )
        ],
      ),
    );
  }

  invateLinkWidget(GroupDetailsProvider provider) {
    var model = provider.model!.data!.groupDetail!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          border: Border(
              bottom: BorderSide(
                  width: 1, color: AppColor.lightGreyD9Color.withOpacity(.4)),
              top: BorderSide(
                  width: 1, color: AppColor.lightGreyD9Color.withOpacity(.4)))),
      padding: const EdgeInsets.only(top: 16, left: 19, bottom: 15, right: 18),
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.appColor),
            child: Image.asset(
              AppImages.inviteLinkIcon,
              height: 15,
              width: 15,
            ),
          ),
          ScreenSize.width(11),
          Expanded(
            child: GestureDetector(
              onTap: (){
                ShareService().share("Please join the group using below link:\n${model.shareLink}");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        title: 'Invite via link',
                        fontSize: 14,
                        color: AppColor.appColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.interMedium,
                      ),
                      InkWell(
                        onTap: () async {
                          await Clipboard.setData(
                              ClipboardData(text: model.shareLink));
                              Utils.showToast('Copied');
                        },
                        child: customText(
                          title: 'Copy',
                          fontSize: 12,
                          color: AppColor.darkAppColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.interMedium,
                        ),
                      ),
                    ],
                  ),
                  ScreenSize.height(4),
                  customText(
                    title: "People who follow this link can join this group",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff455154),
                    fontFamily: FontFamily.interMedium,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  mediaLinksWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, right: 19),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                title: 'Media, links and docs',
                fontSize: 13,
                color: const Color(0xff455154),
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interMedium,
              ),
              GestureDetector(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(
                      const ViewAllGroupMediaScreen());
                },
                child: customText(
                  title: 'View all',
                  fontSize: 13,
                  color: AppColor.darkAppColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interMedium,
                ),
              ),
            ],
          ),
        ),
        ScreenSize.height(10),
        SizedBox(
          height: 80,
          child: ListView.separated(
              separatorBuilder: (context, sp) {
                return ScreenSize.width(8);
              },
              itemCount: 4,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 19),
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xffC2C2C2))),
                  child: Image.asset(
                    'assets/dummay/Rectangle 592.png',
                    fit: BoxFit.fill,
                  ),
                );
              }),
        )
      ],
    );
  }

  membersWidget(GroupDetailsProvider provider) {
    var model = provider.model!.data!.groupDetail!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          border: Border(
              top: BorderSide(
                  width: 1, color: AppColor.lightGreyD9Color.withOpacity(.4)),
              bottom: BorderSide(
                  width: 1, color: AppColor.lightGreyD9Color.withOpacity(.4)))),
      padding: const EdgeInsets.only(left: 19, top: 16, right: 18, bottom: 15),
      child: Column(
        children: [
          isSearchEnable?
          textField():
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                title: '${model.members!.length} members',
                fontSize: 14,
                fontFamily: FontFamily.interMedium,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455154),
              ),
              InkWell(
                onTap: (){
                  isSearchEnable = true;
                  setState(() {
                  });
                },
                child: Image.asset(
                  AppImages.searchIcon,
                  height: 15,
                  width: 15,
                ),
              )
            ],
          ),
          ScreenSize.height(15),
          model.members!.isEmpty
              ? Container()
              : ListView.separated(
                  separatorBuilder: (context, sp) {
                    return ScreenSize.height(17);
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.members!.length,
                  itemBuilder: (context, index) {
                    var memberModel = model.members![index];
                    return GestureDetector(
                      onTap: () {
                        if(model.members![0].id==SessionManager.userIntId&&index==0){
                        }
                        else if(memberModel.id == SessionManager.userIntId){
                          print(provider.isCurrentUserGroupAdmin);
                          //  provider.exitGroupApiFunction(
                          // widget.groupId, memberModel.memberJoinId, GroupAction.makeadmin.name);
                        }
                        else{
                          showDialogBox(provider,memberId:  memberModel.memberJoinId,isAdmin: memberModel.isAdmin,id: memberModel.id,title: memberModel.name,createdGroupId: model.members![0].id);
                        }
                      },
                      child: Container(
                        color: AppColor.whiteColor,
                        child: Row(
                          children: [
                            ClipOval(
                              child: ViewNetworkImage(
                                img: memberModel.imageLink,
                                height: 33.0,
                              ),
                            ),
                            ScreenSize.width(15),
                            Expanded(
                              child: customText(
                                title: memberModel.id == SessionManager.userIntId
                                    ? "You"
                                    : memberModel.name ?? "",
                                fontSize: 14,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: FontFamily.interSemiBold,
                              ),
                            ),
                            memberModel.isAdmin.toString() == '1'
                                ? Container(
                                    height: 26,
                                    // width: 89,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: const Color(0xffDAEFFD)),
                                    alignment: Alignment.center,
                                    child: customText(
                                      title: "Group Admin",
                                      fontSize: 12,
                                      color: AppColor.appColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: FontFamily.interMedium,
                                    ),
                                  )
                                : Image.asset(
                                    AppImages.keyboardDownIcon,
                                    height: 16,
                                  )
                          ],
                        ),
                      ),
                    );
                  })
        ],
      ),
    );
  }

  showDialogBox(GroupDetailsProvider provider,{ String memberId = '',String isAdmin='',String id ='',String title='',String createdGroupId=''}) {
    print(id);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColor.whiteColor,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColor.whiteColor),
                borderRadius: BorderRadius.circular(10)),
            content: Container(
              width: MediaQuery.of(context).size.width - 40,
              padding: const EdgeInsets.symmetric( horizontal: 17),
              child:   createdGroupId==SessionManager.userIntId?adminAccessOfGroupAction(provider,
              memberId: memberId,isAdmin: isAdmin,id: id,title: title,createdGroupId: createdGroupId
              ):
              !provider.isCurrentUserGroupAdmin?
              memberAccessOfGroupAction(title):
              provider.isCurrentUserGroupAdmin?
              anotherAdminAccessOfGroupAction(provider,memberId: memberId,isAdmin: isAdmin,id: id,title: title,createdGroupId: createdGroupId):Container()
            ),
          );
        });
  }

  adminAccessOfGroupAction(GroupDetailsProvider provider,{ String memberId = '',String isAdmin='',String id ='',String title='',String createdGroupId=''}){
    return  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenSize.height(15),
                   isAdmin=='0' ?
                  groupActionWidget("Make group admin", (){
                     provider.exitGroupApiFunction(
                          widget.groupId, memberId, GroupAction.makeadmin.name);
                  }):Container(),
                  createdGroupId==SessionManager.userIntId?
                  groupActionWidget("Assign a filerack's", (){}):Container(),
                  groupActionWidget('Message $title', (){}),
                  isAdmin=='1'?
                  groupActionWidget('Remove from group', (){
                        provider.exitGroupApiFunction(
                          widget.groupId, memberId, GroupAction.remove.name);
                  }):Container(),
                  isAdmin=='1'?
                  groupActionWidget('Delete admin', (){
                        provider.exitGroupApiFunction(
                          widget.groupId, memberId, GroupAction.removeadmin.name);
                  }):Container()
                 ,ScreenSize.height(15),

                ],
              );
  }

  memberAccessOfGroupAction(String title){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: groupActionWidget('Message $title', (){}),
    );
  }

  anotherAdminAccessOfGroupAction(GroupDetailsProvider provider,{ String memberId = '',String isAdmin='',String id ='',String title='',String createdGroupId=''}){
    return  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScreenSize.height(15),
                   isAdmin=='0' ?
                  groupActionWidget("Make group admin", (){
                     provider.exitGroupApiFunction(
                          widget.groupId, memberId, GroupAction.makeadmin.name);
                  }):Container(),
                  createdGroupId==SessionManager.userIntId?
                  groupActionWidget("Assign a filerack's", (){}):Container(),
                  groupActionWidget('Message $title', (){}),
                  isAdmin=='1'?
                  groupActionWidget('Remove from group', (){
                        provider.exitGroupApiFunction(
                          widget.groupId, memberId, GroupAction.removeadmin.name);
                  }):Container()
                 ,ScreenSize.height(15),
                ],
              );
  }

  Widget groupActionWidget(String title, Function()onTap){
    return   GestureDetector(
                    onTap: onTap,
                    child: Container(
                      margin:const EdgeInsets.only(top: 10,bottom: 10),
                      width: double.infinity,
                      color: AppColor.whiteColor,
                      child: customText(
                        title: title,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.interMedium,
                      ),
                    ),
                  );
  }

  textField(){
    return TextFormField(
      cursorHeight: 20,
    decoration:  InputDecoration(
        isDense: false,
        hintText: 'Search by name...',
        hintStyle:const TextStyle(
            fontSize: 13,
            color: Color(0xff9D9D9D),
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.interRegular),
        enabledBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xffEEEEEE)),
        ),
        suffixIcon: InkWell(
          onTap: (){
            isSearchEnable=false;
            setState(() {
            });
            Provider.of<GroupDetailsProvider>(context,listen: false).updateMemberList();
          },
          child:const Icon(Icons.close,size: 15,)),
        focusedBorder:const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffEEEEEE)))),
    onChanged: (val) {
      Provider.of<GroupDetailsProvider>(context,listen: false).searchFunction(val);
    },
    );
  }

  customContainer(String img, String title, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 3,
                    color: AppColor.blackColor.withOpacity(.1))
              ],
              // border: Border.all(
              //   color: const Color(0xffD8D8D8),
              // ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                img,
                height: 22,
                width: 22,
                color: AppColor.appColor,
              ),
              ScreenSize.height(9),
              customText(
                title: title,
                fontSize: 11.3,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455154),
                fontFamily: FontFamily.interMedium,
              )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton popupMenuButton() {
    return customPopupMenuButton(
        list: [
          customPopMenuItem(value: 0, title: 'Add members'),
          customPopMenuItem(value: 1, title: 'Change group name'),
          customPopMenuItem(value: 2, title: 'Change group photos'),
          customPopMenuItem(value: 3, title: 'Audio call'),
          customPopMenuItem(value: 4, title: 'Video call'),
        ],
        onSelected: (value) {
          if (value == 0) {
            AppRoutes.pushCupertinoNavigation(AddMemberScreen(
              groupId: widget.groupId,
            )).then((val) {
              Provider.of<GroupDetailsProvider>(context, listen: false)
                  .groupDetailsApiFunction(widget.groupId, isShowLoader: false);
            });
          } else if (value == 1 || value == 2) {
            AppRoutes.pushCupertinoNavigation(EditGroupProfile(
              route: value == 1 ? 'name' : 'image',
              groupId: widget.groupId,
            )).then((val) {
              Provider.of<GroupDetailsProvider>(context, listen: false)
                  .groupDetailsApiFunction(widget.groupId, isShowLoader: false);
            });
          }
        });
  }
}
