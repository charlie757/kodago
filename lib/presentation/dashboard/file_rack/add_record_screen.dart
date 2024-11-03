import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'package:dropdown_button2/dropdown_button2.dart';

// ignore: must_be_immutable
class AddRecordScreen extends StatefulWidget {
  final String groupId;
  final String sheetId;
  final String sheetDataId;
  final String route;
  FileRackDetailsModel? fileRackDetailsModel;
  final int index;

  /// for edit the record
  AddRecordScreen(
      {required this.groupId,
      required this.sheetId,
      required this.sheetDataId,
      required this.route,
      required this.fileRackDetailsModel,
      this.index = -1});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<AddRecordProvider>(context, listen: false);
    if (widget.route == 'edit') {
      provider.setEditData(widget.fileRackDetailsModel, widget.index);
    } else {
      provider.setData(widget.fileRackDetailsModel);
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var model = widget.fileRackDetailsModel!.data!.sheetFields!;
    return Scaffold(
      appBar: appBar(
          title: "Add Data",),
      body: Consumer<AddRecordProvider>(builder: (context, myProvider, child) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
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
                      itemCount: myProvider.allData.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var model = myProvider.allData[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(TextSpan(
                                text: model.fieldName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.5,
                                  fontFamily: FontFamily.interRegular,
                                ),
                                children: [
                                  TextSpan(
                                    text: model.isRequired.toString() == '1'
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
                            model.fieldType == 'image' ||
                                    model.fieldType == 'video' ||
                                    model.fieldType == 'document'
                                ? fileWidget(index, myProvider)
                                : model.fieldType == 'signature'
                                    ? signatureWidget(index, myProvider)
                                    : model.fieldType == 'autoId'
                                        ? autoIdWidget(index, myProvider)
                                        : model.fieldType == 'dropdown' &&
                                                model.isMultiple.toString() ==
                                                    '1'
                                            ? multipleDropdownWidget(
                                                index, myProvider)
                                            : model.fieldType == 'dropdown'
                                                ? dropdownWidget(
                                                    index, myProvider)
                                                : model.fieldType == 'list'
                                                    ? listWidget(
                                                        index, myProvider)
                                                    : model.fieldType ==
                                                                'userlist' ||
                                                            model.fieldType ==
                                                                'DFOFR'
                                                        ? userAndDofValuesListWidget(
                                                            index, myProvider)
                                                        : CustomTextField(
                                                            controller: model
                                                                .controller,
                                                            onTap: () {
                                                              if (model
                                                                      .fieldType ==
                                                                  'date') {
                                                                myProvider
                                                                    .datePicker(
                                                                        selectedDate:
                                                                            model
                                                                                .selectedDate)
                                                                    .then(
                                                                        (value) {
                                                                  if (value !=
                                                                      null) {
                                                                    var day,
                                                                        month,
                                                                        year;
                                                                    day = value.day <
                                                                            10
                                                                        ? '0${value.day}'
                                                                        : value
                                                                            .day;
                                                                    month = value.month <
                                                                            10
                                                                        ? '0${value.month}'
                                                                        : value
                                                                            .month;
                                                                    year = value
                                                                        .year;
                                                                    model.selectedDate =
                                                                        value;
                                                                    model.controller
                                                                            .text =
                                                                        "${value.year}-$month-$day";
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                });
                                                              } else if (model
                                                                      .fieldType ==
                                                                  'time') {
                                                                myProvider
                                                                    .chooseTime(
                                                                        context:
                                                                            context,
                                                                        selectedTime:
                                                                            model
                                                                                .selectedTime)
                                                                    .then(
                                                                        (val) {
                                                                  if (val !=
                                                                      null) {
                                                                    TimeOfDay
                                                                        periodTime =
                                                                        val;
                                                                    model.controller
                                                                            .text =
                                                                        "${periodTime.hourOfPeriod.toString().padLeft(2, '0')}:${periodTime.minute.toString().padLeft(2, '0')} ${periodTime.period.name.toString().toUpperCase()}";
                                                                    model.selectedTime =
                                                                        periodTime;
                                                                    setState(
                                                                        () {});
                                                                  }
                                                                });
                                                              }
                                                            },
                                                            hintText: myProvider
                                                                        .isReadOnly(
                                                                            model.fieldType) ==
                                                                    false
                                                                ? 'Enter ${model.fieldName}'
                                                                : "Select ${model.fieldName}",
                                                            isReadOnly: myProvider
                                                                .isReadOnly(model
                                                                    .fieldType),
                                                            suffixWidget: model
                                                                            .fieldType ==
                                                                        'date' ||
                                                                    model.fieldType ==
                                                                        'time'
                                                                ? Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Image
                                                                        .asset(
                                                                      AppImages
                                                                          .dateIcon,
                                                                      height:
                                                                          15,
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 0,
                                                                    width: 0,
                                                                  ),
                                                            validator: (val) {
                                                              if (model
                                                                      .isRequired
                                                                      .toString() ==
                                                                  '1') {
                                                                if (val
                                                                    .isEmpty) {
                                                                  return "${model.fieldName} Field should not be empty";
                                                                }
                                                              }
                                                            },
                                                          ),
                          ],
                        );
                      }),
                  ScreenSize.height(17),
                  CustomBtn(
                      title: 'Save',
                      onTap: () {
                        // Utils.errorSnackBar('sdfsd');
                        // myProvider.convertDataInJson();
                        // if (formKey.currentState!.validate()) {
                          myProvider.sendRackDetailsFunction(
                              groupId: widget.groupId,
                              sheetId: widget.sheetId,
                              sheetDataId: widget.sheetDataId);
                        // }
                      })
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  autoIdWidget(int index, AddRecordProvider provider) {
    var model = provider.allData[index];
    model.controller.text = model.valuePrefix;
    return CustomTextField(
      controller: model.controller,
      hintText: 'Enter ${model.fieldName}',
      isReadOnly: true,
      validator: (val) {
        if (model.isRequired.toString() == '1') {
          if (val.isEmpty) {
            return "${model.fieldName} Field should not be empty";
          }
        }
      },
    );
  }

  userAndDofValuesListWidget(int index, AddRecordProvider provider) {
    var model = provider.allData[index];
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
                child: customText(
                    title: 'Select ${model.fieldType}',
                    fontWeight: FontWeight.w400,
                    fontSize: 13.5,
                    color: AppColor.hintTextColor,
                    fontFamily: FontFamily.interRegular)),
          ],
        ),
        items: model.list
            .map((item) => DropdownMenuItem<String>(
                value: item,
                child: customText(
                  title: item,
                )))
            .toList(),
        value: model.selectedDropDownValue,
        onChanged: (value) {
          setState(() {
            model.selectedDropDownValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.textfieldBorderColor,
            ),
            color: AppColor.whiteColor,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.sizeOf(context).width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColor.whiteColor,
          ),
          offset: const Offset(-10, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  listWidget(int index, AddRecordProvider provider) {
    List<String> list = [];
    var model = provider.allData[index];
    if (model.listColsValues != null &&
        model.listColsValues.toString().isNotEmpty) {
      list = model.listColsValues.toString().split(',');
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
                child: customText(
                    title: 'Select ${model.fieldType}',
                    fontWeight: FontWeight.w400,
                    fontSize: 13.5,
                    color: AppColor.hintTextColor,
                    fontFamily: FontFamily.interRegular)),
          ],
        ),
        items: list
            .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: customText(
                  title: item,
                )))
            .toList(),
        value: model.selectedDropDownValue,
        onChanged: (value) {
          setState(() {
            model.selectedDropDownValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.textfieldBorderColor,
            ),
            color: AppColor.whiteColor,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.sizeOf(context).width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColor.whiteColor,
          ),
          offset: const Offset(-10, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  dropdownWidget(int index, AddRecordProvider provider) {
    List<String> list = [];
    var model = provider.allData[index];
    if (model.dropdownValues != null &&
        model.dropdownValues.toString().isNotEmpty) {
      list = model.dropdownValues.toString().split(',');
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
                child: customText(
                    title: 'Select ${model.fieldType}',
                    fontWeight: FontWeight.w400,
                    fontSize: 13.5,
                    color: AppColor.hintTextColor,
                    fontFamily: FontFamily.interRegular)),
          ],
        ),
        items: list
            .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: customText(
                  title: item,
                )))
            .toList(),
        value: model.selectedDropDownValue,
        onChanged: (value) {
          setState(() {
            model.selectedDropDownValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.textfieldBorderColor,
            ),
            color: AppColor.whiteColor,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.sizeOf(context).width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColor.whiteColor,
          ),
          offset: const Offset(-10, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  multipleDropdownWidget(int index, AddRecordProvider provider) {
    List<String> list = [];
    var model = provider.allData[index];
    if (model.dropdownValues != null &&
        model.dropdownValues.toString().isNotEmpty) {
      list = model.dropdownValues
          .toString()
          .split(',')
          .map((value) => value.trim())
          .toList();
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: customText(
            title: 'Select ${model.fieldType}',
            fontWeight: FontWeight.w400,
            fontSize: 13.5,
            color: AppColor.hintTextColor,
            fontFamily: FontFamily.interRegular),
        items: list.map((item) {
          return DropdownMenuItem(
            value: item,
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = model.list.contains(item);
                return InkWell(
                  onTap: () {
                    isSelected ? model.list.remove(item) : model.list.add(item);
                    setState(() {});
                    menuSetState(() {});
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (isSelected)
                          const Icon(
                            Icons.check_box_outlined,
                            color: AppColor.appColor,
                          )
                        else
                          const Icon(
                            Icons.check_box_outline_blank,
                            color: AppColor.hintTextColor,
                          ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        value: model.list.isEmpty ? null : model.list.last,
        onChanged: (value) {},
        selectedItemBuilder: (context) {
          return list.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.centerStart,
                child: customText(
                  title: model.list.join(', '),
                  fontSize: 14,
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.textfieldBorderColor,
            ),
            color: AppColor.whiteColor,
          ),
          elevation: 0,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: MediaQuery.sizeOf(context).width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColor.whiteColor,
          ),
          offset: const Offset(-10, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 20,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }

  signatureWidget(int index, AddRecordProvider provider) {
    var model = provider.allData[index];
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
                      model.image = val['data'][0]['path'];
                      setState(() {});
                    }
                  });
                });
              });
            },
            child: customText(
              title: model.image != null ? "Change Signature" : 'Add Signature',
              fontSize: 14,
              color: AppColor.appColor,
              fontFamily: FontFamily.interMedium,
              decoration: TextDecoration.underline,
            ),
          ),
          model.image != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ViewNetworkImage(
                    img: model.image,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  fileWidget(int index, AddRecordProvider provider) {
    var model = provider.allData[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (model.fieldType == 'video') {
              /// check geo taging condition
              if (model.geoTagging.toString() == '1') {
                provider.geoTagingCameraPicker(
                    index: index,
                    type: 'video',
                    fileRackDetailsModel: widget.fileRackDetailsModel);
              } else {
                provider.addVideoBottomSheet(
                    index: index,
                    fileRackDetailsModel: widget.fileRackDetailsModel);
              }
            } else if (model.fieldType == 'image') {
              /// check geo taging condition
              if (model.geoTagging.toString() == '1') {
                provider.geoTagingCameraPicker(
                    index: index,
                    type: 'image',
                    fileRackDetailsModel: widget.fileRackDetailsModel);
              } else {
                provider.addImageBottomSheet(
                    index: index,
                    fileRackDetailsModel: widget.fileRackDetailsModel);
              }
            } else if (model.fieldType == 'document') {
              provider.pickFiles().then((val) {
                if (val != null) {
                  provider
                      .uploadMediaApiFunction(
                          filename: val, fileType: 'document')
                      .then((val) {
                    if (val != null) {
                      model.list = model.list + val['data'];
                      setState(() {});
                    }
                  });
                }
              });
            }
          },
          child: customText(
            title: model.fieldType == 'video'
                ? 'Add Video'
                : model.fieldType == 'image'
                    ? "Add Image"
                    : 'Add Document',
            fontSize: 14,
            color: AppColor.appColor,
            fontFamily: FontFamily.interMedium,
            decoration: TextDecoration.underline,
          ),
        ),
        model.list.isEmpty
            ? Container()
            : Container(
                height: 65,
                alignment: Alignment.centerLeft,
                child: ListView.separated(
                    separatorBuilder: (context, sp) {
                      return ScreenSize.width(10);
                    },
                    itemCount: model.list.length,
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
                                child: model.fieldType == 'image'
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: ViewNetworkImage(
                                          height: 60.0,
                                          width: 65.0,
                                          img: model.list[li]['path'],
                                        ),
                                      )
                                    : Image.asset(
                                        model.fieldType == 'video'
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
                                  model.list.removeAt(li);
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
