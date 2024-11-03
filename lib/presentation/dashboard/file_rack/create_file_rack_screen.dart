
import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/check_box.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/provider/file_rack/create_file_rack_provider.dart';
import 'package:kodago/uitls/my_sperator.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../uitls/mixins.dart';
import 'package:provider/provider.dart';

class CreateFileRackScreen extends StatefulWidget {
  final String name;
  final String groupId;
  final String sheetId;
  final String route;
  final String sheetName;
  const CreateFileRackScreen({super.key, this.name = '',required this.groupId,required this.sheetId,
  required this.route,this.sheetName = ''
  });

  @override
  State<CreateFileRackScreen> createState() => _CreateFileRackScreenState();
}

class _CreateFileRackScreenState extends State<CreateFileRackScreen>
    with MediaQueryScaleFactor {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((val) {
      callInitFunction();
    });
    super.initState();
  }

  callInitFunction() {
    final provider =
        Provider.of<CreateFileRackProvider>(context, listen: false);
        provider.clearValues();
        if(widget.route=='edit'){
          provider.formNameController.text = widget.sheetName;
      provider.fileRackDetailsApiFunction(
        groupId: widget.groupId, sheetId: widget.sheetId, sheetDataId: '',isLoader: true);
        }
       else{
        provider.addRecord();
       }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<CreateFileRackProvider>(
          builder: (context, myProvider, child) {
            String  deleteId =myProvider.deleteRecordId.join(',');    
            print(deleteId);        
        return Scaffold(
          appBar: appBar(title: widget.name),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              controller: myProvider.controller,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    hintText: 'Enter your form name',
                    borderColor: AppColor.appColor.withOpacity(.4),
                    controller: myProvider.formNameController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Enter your form name";
                      }
                    },
                  ),
                  ScreenSize.height(22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        title: 'Create record',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.interMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            myProvider.addRecord();
                          }
                          else{
                            myProvider.scrollDown();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.appColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: customText(
                              title: 'Create More',
                              fontSize: 13,
                              fontFamily: FontFamily.interRegular,
                              color: AppColor.whiteColor,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  ScreenSize.height(16),
                  ListView.separated(
                      separatorBuilder: (context, sp) {
                        return ScreenSize.height(17);
                      },
                      itemCount: myProvider.recordList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return recordWidget(myProvider, index);
                      }),
                  ScreenSize.height(25),
                  CustomBtn(
                      title: 'Submit',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if(widget.route=='add'){
                            myProvider.callCreateRecod(widget.groupId);
                          }
                          else{
                            myProvider.callUpdateRecod(widget.groupId, widget.sheetId);
                          }
                        }
                        
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  recordWidget(CreateFileRackProvider provider, int index) {
    var model = provider.recordList[index];
    return Container(
      decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColor.borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          provider.recordList.length>1?
           Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (){
                provider.recordList.removeAt(index);
                if(model.fieldId!=null){
                  provider.deleteRecordId.add(model.fieldId);
                }
                setState(() {
                });
              },
              child:const Padding(
                padding:  EdgeInsets.only(top: 2,right: 2),
                child: Icon(Icons.close,color: AppColor.redColor,size: 20,),
              ),
            ),
          ):Container(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: 'Enter field name',
                  controller: model.fieldController,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter your field name";
                    }
                  },
                ),
                ScreenSize.height(12),
                CustomTextField(
                  hintText: 'Select data type',
                  isReadOnly: true,
                  controller: model.dataTypeController,
                  suffixWidget: Container(
                    height: 16,
                    width: 16,
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.keyboardDownIcon,
                      width: 15,
                      height: 15,
                    ),
                  ),
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Select your data type";
                    }
                  },
                  onTap: () {
                    dataTypesBottomSheet(provider, index);
                  },
                ),
                ScreenSize.height(13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customText(
                      title: 'Highlight',
                      color: AppColor.lightTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontFamily: FontFamily.interRegular,
                    ),
                    FlutterSwitch(
                        width: 48.0,
                        activeText: '',
                        inactiveText: '',
                        height: 22.0,
                        inactiveColor: const Color(0xffD8D8D8),
                        // valueFontSize: 25.0,
                        toggleSize: 20.0,
                        value: model.isHightlight,
                        borderRadius: 30.0,
                        inactiveToggleColor: const Color(0xff737272),
                        // padding: 8.0,
                        showOnOff: true,
                        onToggle: (val) {
                          model.isHightlight = val;
                          setState(() {});
                        }),
                  ],
                ),
                ScreenSize.height(12),
                const MySeparator(
                  color: Color(0xffD3D3D3),
                ),
                ScreenSize.height(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    typesCheckboxWidget(
                        title: 'Mandatory',
                        index: 1,
                        selectedIndex: model.isMandatory,
                        onTap: () {
                          if (model.isMandatory != 1) {
                            model.isMandatory = 1;
                          } else {
                            model.isMandatory = 0;
                          }
                          setState(() {});
                        }),
                    typesCheckboxWidget(
                        title: 'Lock',
                        index: 1,
                        selectedIndex: model.isLock,
                        onTap: () {
                          if (model.isLock != 1) {
                            model.isLock = 1;
                          } else {
                            model.isLock = 0;
                          }
                          setState(() {});
                        }),
                    typesCheckboxWidget(
                        title: 'Non-editable',
                        index: 1,
                        selectedIndex: model.nonEditable,
                        onTap: () {
                          if (model.nonEditable != 1) {
                            model.nonEditable = 1;
                          } else {
                            model.nonEditable = 0;
                          }
                          setState(() {});
                        }),
                  ],
                ),
                ScreenSize.height(12),
                typesCheckboxWidget(
                    title: 'Default Data',
                    index: 1,
                    selectedIndex: model.defaultData,
                    onTap: () {
                      if (model.defaultData != 1) {
                        model.defaultData = 1;
                      } else {
                        model.defaultData = 0;
                      }
                      setState(() {});
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  typesCheckboxWidget(
      {required String title,
      required int index,
      Function()? onTap,
      required int selectedIndex}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          customCheckBox(index: index, selectedIndex: selectedIndex),
          ScreenSize.width(8),
          customText(
            title: title,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColor.grey6AColor,
            fontFamily: FontFamily.interMedium,
          )
        ],
      ),
    );
  }

  dataTypesBottomSheet(CreateFileRackProvider provider, int mainIndex) {
    var model = provider.recordList[mainIndex];
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColor.whiteColor,
        shape: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.whiteColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height * .9,
              padding: const EdgeInsets.only(
                  top: 23, left: 20, right: 20, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      title: 'Add Template Fields',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontFamily.interMedium,
                    ),
                  ),
                  ScreenSize.height(24),
                  CustomTextField(
                    hintText: 'Enter data label',
                    onChanged: (val) {},
                  ),
                  ScreenSize.height(22),
                  customText(
                    title: 'Data type',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.interMedium,
                  ),
                  ScreenSize.height(20),
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, sp) {
                          return ScreenSize.height(21);
                        },
                        itemCount: provider.list.length,
                        padding: const EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              model.dataTypeController.text =
                                  provider.list[index]['title'];
                              state(() {});
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  provider.list[index]['img'],
                                  height: 44,
                                  width: 44,
                                ),
                                ScreenSize.width(14),
                                Expanded(
                                  child: customText(
                                    title: provider.list[index]['title'],
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.interSemiBold,
                                  ),
                                ),
                                ScreenSize.width(5),
                                customRadio(
                                    isSelected: model.dataTypeController.text ==
                                            provider.list[index]['title']
                                        ? true
                                        : false)
                              ],
                            ),
                          );
                        }),
                  ),
                  // ScreenSize.height(10),
                  CustomBtn(
                      title: 'Add Template',
                      onTap: () {
                        if (model.dataTypeController.text.isEmpty) {
                          Utils.showToast('Please select template');
                        } else {
                          Navigator.pop(context);
                        }
                      })
                ],
              ),
            );
          });
        });
  }

  customRadio({required bool isSelected}) {
    return Container(
      height: 20,
      width: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColor.appColor : AppColor.greyD8Color),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: AppColor.whiteColor,
              size: 14,
            )
          : Container(),
    );
  }
}
