import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/presentation/dashboard/file_rack/add_data_screen.dart';
import 'package:kodago/presentation/dashboard/file_rack/assign_members_screen.dart';
import 'package:kodago/presentation/dashboard/file_rack/create_form_screen.dart';
import 'package:kodago/presentation/dashboard/file_rack/file_rack_details_screen.dart';
import 'package:kodago/presentation/shimmer/gropup_shimmer.dart';
import 'package:kodago/services/provider/file_rack/file_rack_provider.dart';
import 'package:kodago/uitls/delete_file_rack_dialogbox.dart';
import 'package:kodago/uitls/time_format.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/no_data_found.dart';
import 'package:kodago/widget/no_file_rack.dart';
import 'package:kodago/widget/popmenuButton.dart';
import 'package:provider/provider.dart';

import '../../../uitls/mixins.dart';

class FileRackListScreen extends StatefulWidget {
  final String groupId;
  final String groupName;
  const FileRackListScreen({required this.groupId, required this.groupName});

  @override
  State<FileRackListScreen> createState() => _FileRackListScreenState();
}

class _FileRackListScreenState extends State<FileRackListScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<FileRackProvider>(context, listen: false);
    provider.fileRackApiFunction(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<FileRackProvider>(builder: (context, myProvider, child) {
        return Scaffold(
          appBar: appBar(
              title: widget.groupName,
              actions: myProvider.model != null &&
                      myProvider.model!.data != null &&
                      myProvider.model!.data!.sheets != null &&
                      myProvider.model!.data!.sheets!.isNotEmpty
                  ? [
                      GestureDetector(
                        onTap: () {
                          AppRoutes.pushCupertinoNavigation(
                              const CreateFormScreen());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 6),
                          decoration: BoxDecoration(
                              color: AppColor.appColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: customText(
                            title: 'Add file racks',
                            color: AppColor.whiteColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: FontFamily.interRegular,
                          ),
                        ),
                      )
                    ]
                  : []),
          body: myProvider.isLoading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GropupShimmer(
                    route: '',
                  ),
                )
              : myProvider.model != null && myProvider.model!.data != null
                  ? myProvider.model!.data!.sheets == null ||
                          myProvider.model!.data!.sheets!.isEmpty
                      ? const NoFileRack()
                      : ListView.separated(
                          separatorBuilder: (context, sp) {
                            return ScreenSize.height(20);
                          },
                          itemCount: myProvider.model!.data!.sheets!.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                              left: 20, right: 0, top: 10, bottom: 25),
                          itemBuilder: (context, index) {
                            var model = myProvider.model!.data!.sheets![index];
                            return GestureDetector(
                              onTap: () {
                                AppRoutes.pushCupertinoNavigation(
                                    FileRackDetailsScreen(
                                  groupId: widget.groupId,
                                  sheetId: model.id,
                                  sheetDataId: '',
                                ));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffE7E7E7)),
                                    child: Image.asset(
                                      AppImages.fileIcon,
                                      height: 21,
                                    ),
                                  ),
                                  ScreenSize.width(15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        customText(
                                          title: model.name ?? '',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.blackColor,
                                          fontFamily: FontFamily.interMedium,
                                          maxLines: 1,
                                        ),
                                        customText(
                                          title:
                                              'Last update on ${TimeFormat.convertDateWithTime(model.updatedAt)}',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.grey6AColor,
                                          fontFamily: FontFamily.interRegular,
                                        )
                                      ],
                                    ),
                                  ),
                                  popupMenuButton(
                                      index: index, provider: myProvider)
                                ],
                              ),
                            );
                          })
                  : Container(),
        );
      }),
    );
  }

  PopupMenuButton popupMenuButton(
      {required int index, required FileRackProvider provider}) {
    return customPopupMenuButton(
        list: [
          customPopMenuItem(value: 0, title: 'Edit'),
          customPopMenuItem(value: 1, title: 'Assign Members'),
          customPopMenuItem(value: 2, title: 'Assign Topic'),
          customPopMenuItem(value: 3, title: 'Delete'),
        ],
        onSelected: (value) {
          if (value == 0) {
            AppRoutes.pushCupertinoNavigation(const AddDataScreen());
          } else if (value == 1) {
            AppRoutes.pushCupertinoNavigation(const AssignMembersScreen());
          } else if (value == 2) {
            // assignCategoryBottomSheet();
          } else if (value == 3) {
            deleteFileRackDialogBox(deleteTap: () {
              provider
                  .deleteFileRackApiFunction(
                      groupId: widget.groupId,
                      sheetId:
                          provider.model!.data!.sheets![index].id.toString())
                  .then((val) {
                if (val != null) {
                  Utils.showToast(val['message'], color: Colors.green);
                  provider.model!.data!.sheets!.removeAt(index);
                  setState(() {});
                }
              });
            });
          }
        });
  }
}
