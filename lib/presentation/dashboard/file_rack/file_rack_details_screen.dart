import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/check_box.dart';
import 'package:kodago/helper/custom_horizontal_line.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/presentation/dashboard/file_rack/add_record_screen.dart';
import 'package:kodago/presentation/dashboard/file_rack/file_rack_comment_screen.dart';
import 'package:kodago/presentation/dashboard/file_rack/file_rack_history.dart';
import 'package:kodago/presentation/dashboard/file_rack/filter_screen.dart';
import 'package:kodago/presentation/dashboard/home/view_feeds_screen.dart';
import 'package:kodago/services/provider/file_rack/file_rack_details_provider.dart';
import 'package:kodago/uitls/delete_file_rack_dialogbox.dart';
import 'package:kodago/uitls/extension.dart';
import 'package:kodago/uitls/time_format.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/fle_rack_image_widget.dart';
import 'package:kodago/widget/no_data_found.dart';
import 'package:kodago/widget/popmenuButton.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

class FileRackDetailsScreen extends StatefulWidget {
  final String groupId;
  final String sheetId;
  final String sheetDataId;
  final String sheetName;
  const FileRackDetailsScreen(
      {required this.groupId,
      required this.sheetDataId,
      required this.sheetId, required this.sheetName});

  @override
  State<FileRackDetailsScreen> createState() => _FileRackDetailsScreenState();
}

class _FileRackDetailsScreenState extends State<FileRackDetailsScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction(true);
    });
    // TODO: implement initState
    super.initState();
  }

  callInitFunction(bool isLoader) async {
    final provider =
        Provider.of<FileRackDetailsProvider>(context, listen: false);
        print("isLoader....$isLoader");
    provider.fileRackDetailsApiFunction(
        groupId: widget.groupId, sheetId: widget.sheetId, sheetDataId: widget.sheetDataId,isLoader: isLoader);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<FileRackDetailsProvider>(
        builder: (context,myProvider,child) {
          return Scaffold(
            appBar: appBar(title: widget.sheetName, actions: [
              GestureDetector(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation( AddRecordScreen(
                    groupId: widget.groupId, sheetId: widget.sheetId, sheetDataId: widget.sheetDataId,
                    route: 'add',
                    fileRackDetailsModel: myProvider.fileRackDetailsModel!,
                  )).then((val){
                    callInitFunction(false);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                  decoration: BoxDecoration(
                      color: AppColor.appColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: customText(
                    title: 'Add Record',
                    color: AppColor.whiteColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  AppRoutes.pushCupertinoNavigation(const FilterScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 33,
                  width: 75,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xffEDEDED)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.filterIcon,
                        height: 17,
                      ),
                      ScreenSize.width(6),
                      customText(
                        title: 'Filter',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff455154),
                        fontFamily: FontFamily.interMedium,
                      )
                    ],
                  ),
                ),
              ),
            ]),
            body: myProvider.fileRackDetailsModel != null &&
                    myProvider.fileRackDetailsModel!.data != null &&
                    myProvider.fileRackDetailsModel!.data!.sheetData != null
                ?myProvider.fileRackDetailsModel!.data!.sheetData!.dbdata!.isEmpty?
                        noDataFound('No file Rack'):
                 ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.height(20);
                    },
                    itemCount: myProvider
                        .fileRackDetailsModel!.data!.sheetData!.dbdata!.length,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 20),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return detailsViewWidget(index, myProvider);
                    })
                : Container(),
          );
        }
      ),
    );
  }

  detailsViewWidget(int fileIndex, FileRackDetailsProvider provider) {
    var model =
        provider.fileRackDetailsModel!.data!.sheetData!.dbdata![fileIndex];
    return Container(
      padding: const EdgeInsets.only(top: 11, bottom: 11),
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileWidget(fileIndex, provider),
          ScreenSize.height(10),
          customHorizontalDivider(),
          ScreenSize.height(11),
          ListView.separated(
            separatorBuilder: (context,sp){
              return ScreenSize.height(14);
            },
              itemCount: model.data!.length>3?3:model.data!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final fileModel = model.data![index];
                return fileModel.fieldType.toString().toLowerCase() == 'image' ||
                            fileModel.fieldType.toString().toLowerCase() ==
                                'document' ||
                            fileModel.fieldType.toString().toLowerCase() ==
                                'signature'||
                                fileModel.fieldType.toString().toLowerCase() == 'video'
                        ? fileRackImagesWidget(index, provider.fileRackDetailsModel!,isFileRack: true)
                        : fileModel.fieldType.toString().toLowerCase() !=
                                'document'
                            ? viewFileWidget(
                                title: fileModel.fieldName,
                                des: fileModel.dValue ?? fileModel.fieldValue,
                              )
                            : Container();
              }),
          ScreenSize.height(14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: customHorizontalDivider(),
          ),
          ScreenSize.height(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    AppRoutes.pushCupertinoNavigation(
                         FileRackCommentScreen(
                           groupId: widget.groupId,
                      sheetId: model.sheetId,
                      sheetDataId: model.id,
                        ));
                  },
                  child: customText(
                    title: 'Show Comments',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interRegular,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppRoutes.pushCupertinoNavigation(ViewFeedsScreen(
                      groupId: widget.groupId,
                      sheetId: model.sheetId,
                      sheetDataId: model.id,
                      sheetName: widget.sheetName,
                    ));
                  },
                  child: customText(
                    title: 'Show more',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: AppColor.appColor,
                    fontFamily: FontFamily.interMedium,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  viewFileWidget({required String title, required String des}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(
            title: title,
            fontSize: 12.5,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.interRegular,
          ),
          ScreenSize.height(4),
          customText(
            title:des.isEmpty?'---':des,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColor.grey6AColor,
            fontFamily: FontFamily.interRegular,
          ),
        ],
      ),
    );
  }

  profileWidget(int index, FileRackDetailsProvider provider) {
    var model = provider.fileRackDetailsModel!.data!.sheetData!.dbdata![index];
    return Padding(
      padding: const EdgeInsets.only(left: 11),
      child: Row(
        children: [
          ClipOval(
            child: ViewNetworkImage(
              img: model.imageLink,
              height: 32.0,
              width: 32.0,
            ),
          ),
          ScreenSize.width(10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(
                title: model.username.toString().capitalize(),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interMedium,
              ),
              customText(
                title:
                    'added on ${TimeFormat.formatDateWithoutOfT(model.createdAt)}',
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.interRegular,
                color: AppColor.grey7DColor,
              ),
            ],
          )),
          popupMenuButton(index)
        ],
      ),
    );
  }

  PopupMenuButton popupMenuButton(int index) {
    return customPopupMenuButton(
        list: [
          customPopMenuItem(value: 0, title: 'Edit'),
          customPopMenuItem(value: 1, title: 'History'),
          customPopMenuItem(value: 2, title: 'Assign Members'),
          customPopMenuItem(value: 3, title: 'Delete'),
        ],
        onSelected: (value) {
          if (value == 0) {
              AppRoutes.pushCupertinoNavigation( AddRecordScreen(
                    groupId: widget.groupId, sheetId: widget.sheetId, sheetDataId: widget.sheetDataId,
                    route: 'edit',
                    fileRackDetailsModel: Provider.of<FileRackDetailsProvider>(context,listen: false).fileRackDetailsModel!,index: index,
                  )).then((val){
                  callInitFunction(false);
                  });
          } else if (value == 1) {
            AppRoutes.pushCupertinoNavigation(const FileRackHistory());
          } else if (value == 2) {
            assignMembersBottomSheet();
          } else if (value == 3) {
            deleteFileRackDialogBox(deleteTap: () {
              print('dsfdbg${widget.sheetDataId}');
              Navigator.pop(context);
              // Provider.of<FileRackDetailsProvider>(context,listen: false).deleteFileRackApiFunction(groupId: widget.groupId, sheetId: widget.sheetId, sheetDataId: widget.sheetDataId);
            });
          }
        });
  }

  assignMembersBottomSheet() {
    showModalBottomSheet(
        backgroundColor: AppColor.whiteColor,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        context: context,
        builder: (context) {
          return Container(
            padding:
                const EdgeInsets.only(top: 21, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 4,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffE1E1E1)),
                  ),
                ),
                ScreenSize.height(21),
                Align(
                  alignment: Alignment.center,
                  child: customText(
                    title: 'Assign Members',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                  ),
                ),
                ScreenSize.height(27),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, sp) {
                        return ScreenSize.height(10);
                      },
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 11, vertical: 15),
                          decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.blackColor.withOpacity(.1),
                                    offset: const Offset(0, 0),
                                    blurRadius: 5)
                              ]),
                          child: Row(
                            children: [
                              customCheckBox(index: index, selectedIndex: 0),
                              ScreenSize.width(12),
                              customText(
                                title: 'Jon Dav',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                fontFamily: FontFamily.interMedium,
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}
