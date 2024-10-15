import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/model/file_rack/file_rack_details_model.dart';
import 'package:kodago/services/provider/file_rack/add_record_provider.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:provider/provider.dart';
import '../../../uitls/mixins.dart';

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
      widget.fileRackDetailsModel == null ? callInitFunction() : null;
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 17, right: 20,bottom: 20),
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
                separatorBuilder: (context,sp){
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
                      style:const TextStyle(
                         fontWeight: FontWeight.w400,
                      fontSize: 12.5,
                      fontFamily: FontFamily.interRegular,
                      ),
                      children: [
                        TextSpan(
                          text:model[index].isRequired.toString()=='1'? '*':'',
                          style:const TextStyle(
                         fontWeight: FontWeight.w400,
                      fontSize: 12.5,color: AppColor.redColor,
                      fontFamily: FontFamily.interRegular,
                      ),
                        )
                      ]
                    )),
                    ScreenSize.height(8),
                    CustomTextField(hintText: ''),
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
      ),
    );
  }
}
