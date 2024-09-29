import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/custom_textfield.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/services/image_picker_service.dart';
import 'package:kodago/services/provider/group/group_details_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/image_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../uitls/mixins.dart';

class EditGroupProfile extends StatefulWidget {
  final String route;
  final String groupId;
  const EditGroupProfile({required this.route, required this.groupId});

  @override
  State<EditGroupProfile> createState() => _EditGroupProfileState();
}

class _EditGroupProfileState extends State<EditGroupProfile>
    with MediaQueryScaleFactor {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<GroupDetailsProvider>(context, listen: false);
    if (provider.model != null &&
        provider.model!.data != null &&
        provider.model!.data!.groupDetail != null) {
      provider.nameController.text =
          provider.model!.data!.groupDetail!.name ?? "";
    }
  }

  callUpdateNameFunction(GroupDetailsProvider provider) {
    if (formKey.currentState!.validate()) {
      provider.updateGroupNameApiFunction(widget.groupId);
    }
  }

  callUpdateImageFunction(GroupDetailsProvider provider) {
    if (file != null) {
      provider.updateGroupImageApiFunction(widget.groupId, file!);
    } else {
      Utils.showToast('Upload image');
    }
  }

  File? file;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupDetailsProvider>(
        builder: (context, myProvider, child) {
      return MediaQuery(
        data: mediaQuery,
        child: Scaffold(
          appBar: appBar(title: 'Edit profile'),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.route == 'image'
                      ? imageWidget(myProvider)
                      : Container(),
                  widget.route == 'name' ? nameWidget(myProvider) : Container(),
                  ScreenSize.height(30),
                  CustomBtn(
                      title: 'Save',
                      onTap: () {
                        if (widget.route == 'image') {
                          callUpdateImageFunction(myProvider);
                        } else {
                          callUpdateNameFunction(myProvider);
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  imageWidget(GroupDetailsProvider provider) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          provider.model == null
              ? Container(
                  height: 85,
                  width: 85,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                )
              : ClipOval(
                  child: ViewNetworkImage(
                  img: provider.model!.data!.groupDetail!.imageLink,
                  height: 85.0,
                  width: 85.0,
                )),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                imageBottomSheet(cameraTap: () {
                  ImagePickerService.pickImage(ImageSource.camera).then((val) {
                    if (val != null) {
                      file = val;
                      setState(() {});
                    }
                    Navigator.pop(context);
                  });
                }, galleryTap: () {
                  ImagePickerService.pickImage(ImageSource.gallery).then((val) {
                    print('val......$val');
                    if (val != null) {
                      file = val;
                      setState(() {});
                    }
                    Navigator.pop(context);
                  });
                });
              },
              child: Container(
                height: 26,
                width: 26,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffDAEFFD)),
                child: Image.asset(
                  AppImages.cameraIcon,
                  height: 13,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  nameWidget(GroupDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText(
          title: 'Enter group name',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.interMedium,
        ),
        ScreenSize.height(12),
        CustomTextField(
          hintText: 'Kodago Attendance',
          controller: provider.nameController,
          validator: (val) {
            if (val.isEmpty) {
              return "Enter group name";
            }
          },
        ),
      ],
    );
  }
}
