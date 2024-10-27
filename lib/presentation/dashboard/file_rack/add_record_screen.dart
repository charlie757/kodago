import 'package:flutter/material.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/presentation/dashboard/file_rack/signature_screen.dart';
import 'package:kodago/services/provider/file_rack/add_record_provider.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../uitls/mixins.dart';

// ignore: must_be_immutable
class AddRecordScreen extends StatefulWidget {
  final String groupId;
  final String sheetId;
  final String sheetDataId;
  final String route;
  FileRackDetailsModel? fileRackDetailsModel;
  AddRecordScreen({
    required this.groupId,
    required this.sheetId,
    required this.sheetDataId,
    required this.route,
    required this.fileRackDetailsModel,
  });

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      // widget.fileRackDetailsModel == null ? callInitFunction() : null;
    });
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<AddRecordProvider>(context, listen: false);
    provider.viewSheetFeedDataApiFunction(
        groupId: widget.groupId,
        sheetId: widget.sheetId,
        sheetDataId: widget.sheetDataId);
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.fileRackDetailsModel!.data!.sheetFields!;
    return Scaffold(
      appBar: appBar(title: "Add Data"),
      body: Consumer<AddRecordProvider>(builder: (context, myProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 17, right: 20, bottom: 20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColor.borderColor)),
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.height(15);
                    },
                    itemCount: model.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(TextSpan(
                              text: model[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                                fontFamily: FontFamily.interRegular,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      model[index].isRequired.toString() == '1'
                                          ? '*'
                                          : '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.5,
                                    color: AppColor.redColor,
                                    fontFamily: FontFamily.interRegular,
                                  ),
                                )
                              ])),
                          ScreenSize.height(8),
                          model[index].type == 'image' ||
                                  model[index].type == 'video' ||
                                  model[index].type == 'document'
                              ? fileWidget(index, myProvider)
                              : model[index].type == 'signature'
                                  ? signatureWidget(index, myProvider)
                                  :model[index].type=='autoId'?
                                  autoIdWidget(index, myProvider):
                                   CustomTextField(
                                      controller: model[index].controller,
                                      onTap: () {
                                        if (model[index].type == 'date') {
                                          myProvider
                                              .datePicker(
                                                  selectedDate:
                                                      model[index].selectedDate)
                                              .then((value) {
                                            if (value != null) {
                                              var day, month, year;
                                              day = value.day < 10
                                                  ? '0${value.day}'
                                                  : value.day;
                                              month = value.month < 10
                                                  ? '0${value.month}'
                                                  : value.month;
                                              year = value.year;
                                              model[index].selectedDate = value;
                                              model[index].controller.text =
                                                  "${value.year}-$month-$day";
                                              setState(() {});
                                            }
                                          });
                                        } else if (model[index].type ==
                                            'time') {
                                          myProvider
                                              .chooseTime(
                                                  context: context,
                                                  selectedTime:
                                                      model[index].selectedTime)
                                              .then((val) {
                                            if (val != null) {
                                              TimeOfDay periodTime = val;
                                              model[index].controller.text =
                                                  "${periodTime.hourOfPeriod.toString().padLeft(2, '0')}:${periodTime.minute.toString().padLeft(2, '0')} ${periodTime.period.name.toString().toUpperCase()}";
                                              model[index].selectedTime =
                                                  periodTime;
                                              setState(() {});
                                            }
                                          });
                                        }
                                      },
                                      hintText: myProvider.isReadOnly(
                                                  model[index].type) ==
                                              false
                                          ? 'Enter ${model[index].name}'
                                          : "Select ${model[index].name}",
                                      isReadOnly: myProvider
                                          .isReadOnly(model[index].type),
                                      suffixWidget:
                                          model[index].type == 'date' ||
                                                  model[index].type == 'time'
                                              ? Container(
                                                  height: 20,
                                                  width: 20,
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    AppImages.dateIcon,
                                                    height: 15,
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                    ),
                        ],
                      );
                    }),
                ScreenSize.height(17),
                CustomBtn(
                    title: 'Save',
                    onTap: () {
                      // AppRoutes.pushCupertinoNavigation(
                      //     const NoFileRacksScreen());
                    })
              ],
            ),
          ),
        );
      }),
    );
  }

  autoIdWidget(int index, AddRecordProvider provider) {
     var model = widget.fileRackDetailsModel!.data!.sheetFields!;
     model[index].controller.text = model[index].valuePrefix;
    return CustomTextField(
      controller: model[index].controller,
      hintText: 'Enter ${model[index].name}',
      isReadOnly: true,
    );
  }

dropdownWidget(){
  return Column(
    children: [
      
    ],
  );
}

  signatureWidget(int index, AddRecordProvider provider) {
    var model = widget.fileRackDetailsModel!.data!.sheetFields!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              AppRoutes.pushCupertinoNavigation(const SignatureScreen())
                  .then((val) {
                provider
                    .saveImageToDevice(val, 'my_signature.png')
                    .then((sign) {
                  provider
                      .uploadMediaApiFunction(filename: sign, fileType: 'image')
                      .then((val) {
                    if (val != null) {
                      model[index].image = val['data'][0]['path'];
                      setState(() {});
                    }
                  });
                });
              });
            },
            child: customText(
              title: model[index].image != null
                  ? "Change Signature"
                  : 'Add Signature',
              fontSize: 14,
              color: AppColor.appColor,
              fontFamily: FontFamily.interMedium,
              decoration: TextDecoration.underline,
            ),
          ),
          model[index].image != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ViewNetworkImage(
                    img: model[index].image,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  fileWidget(int index, AddRecordProvider provider) {
    var model = widget.fileRackDetailsModel!.data!.sheetFields!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (model[index].type == 'video') {
              provider.addVideoBottomSheet(
                  index: index,
                  fileRackDetailsModel: widget.fileRackDetailsModel);
            } else if (model[index].type == 'image') {
              provider.addImageBottomSheet(
                  index: index,
                  fileRackDetailsModel: widget.fileRackDetailsModel);
            } else if (model[index].type == 'document') {
              provider.pickFiles().then((val) {
                if (val != null) {
                  provider
                      .uploadMediaApiFunction(
                          filename: val, fileType: 'document')
                      .then((val) {
                    if (val != null) {
                      model[index].list = model[index].list + val['data'];
                      setState(() {});
                    }
                  });
                }
              });
            }
          },
          child: customText(
            title: model[index].type == 'video'
                ? 'Add Video'
                : model[index].type == 'image'
                    ? "Add Image"
                    : 'Add Document',
            fontSize: 14,
            color: AppColor.appColor,
            fontFamily: FontFamily.interMedium,
            decoration: TextDecoration.underline,
          ),
        ),
        // Row(
        //   children: [
        //     // customContainerWidget(Icon(
        //     //   model[index].type == 'video'
        //     //       ? Icons.video_file
        //     //       : model[index].type == 'image'
        //     //           ? Icons.image
        //     //           : Icons.folder,
        //     //   color: AppColor.appColor,
        //     // )),
        //     ScreenSize.width(10),
        //     InkWell(
        //       onTap: () {
        //         if (model[index].type == 'video') {
        //           provider.addVideoBottomSheet(
        //               index: index,
        //               fileRackDetailsModel: widget.fileRackDetailsModel);
        //         } else if (model[index].type == 'image') {
        //           provider.addImageBottomSheet(
        //               index: index,
        //               fileRackDetailsModel: widget.fileRackDetailsModel);
        //         } else if (model[index].type == 'document') {
        //           provider.pickFiles().then((val) {
        //             if (val != null) {
        //               provider
        //                   .uploadMediaApiFunction(
        //                       filename: val, fileType: 'document')
        //                   .then((val) {
        //                 if (val != null) {
        //                   model[index].list = val['data'];
        //                   setState(() {});
        //                 }
        //               });
        //             }
        //           });
        //         }
        //       },
        //       child: customText(
        //         title: model[index].type == 'video'
        //             ? 'Add Video'
        //             : model[index].type == 'image'
        //                 ? "Add Image"
        //                 : 'Add Document',
        //         fontSize: 14,
        //         color: AppColor.appColor,
        //         fontFamily: FontFamily.interMedium,
        //         decoration: TextDecoration.underline,
        //       ),
        //     )
        //   ],
        // ),
        model[index].list.isEmpty
            ? Container()
            : Container(
                height: 65,
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.width(10);
                    },
                    itemCount: model[index].list.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(top: 8, bottom: 0),
                    itemBuilder: (context, li) {
                      return SizedBox(
                        height: 65,
                        width: 60,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 50,
                                width: 55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColor.appColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: model[index].type == 'image'
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: ViewNetworkImage(
                                          height: 60.0,
                                          width: 65.0,
                                          img: model[index].list[li]['path'],
                                        ),
                                      )
                                    : Image.asset(
                                        model[index].type == 'video'
                                            ? AppImages.videoIcon
                                            : AppImages.fileIcon,
                                        height: 25,
                                      ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: InkWell(
                                onTap: () {
                                  model[index].list.removeAt(li);
                                  setState(() {});
                                },
                                child: Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColor.redColor,
                                          width: 1.5)),
                                  child: const Icon(
                                    Icons.close,
                                    color: AppColor.redColor,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
      ],
    );
  }

  customContainerWidget(Icon icon) {
    return DottedBorder(
      borderType: BorderType.Rect,
      color: AppColor.appColor,
      strokeWidth: 1,
      dashPattern: const [6, 3],
      child: Container(
        width: 50,
        height: 45,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
