import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/services/image_picker_service.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:kodago/widget/image_bottomsheet.dart';
import 'package:kodago/widget/selected_contact_widget.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../uitls/mixins.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen>
    with MediaQueryScaleFactor {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: mediaQuery,
      child: Consumer<NewGroupProvider>(builder: (context, myProvider, child) {
        return Scaffold(
            backgroundColor: const Color(0xffF8F8F8),
            appBar: appBar(title: 'New group'),
            body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [headerWidget(myProvider), membersWidget(myProvider)],
              ),
            ),
            floatingActionButton: GestureDetector(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  if (myProvider.addedList.isNotEmpty) {
                    myProvider.createGroupApiFunction();
                  } else {
                    Utils.showToast("Please add members");
                  }
                }
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
            ));
      }),
    );
  }

  membersWidget(NewGroupProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 18),
          child: customText(
            title: 'Members: ${provider.addedList.length}',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamily.interMedium,
            color: const Color(0xff585757),
          ),
        ),
        ScreenSize.height(21),
        const SelectedContactWidget()
      ],
    );
  }

  headerWidget(NewGroupProvider provider) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      color: AppColor.whiteColor,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              imageBottomSheet(
                cameraTap: () {
                  ImagePickerService.pickImage(ImageSource.camera).then((val) {
                    if (val != null) {
                      provider.img = val;
                      setState(() {});
                    }
                    Navigator.pop(context);
                  });
                },
                galleryTap: () {
                  ImagePickerService.pickImage(ImageSource.gallery).then((val) {
                    if (val != null) {
                      provider.img = val;
                      setState(() {});
                    }
                    Navigator.pop(context);
                  });
                },
              );
            },
            child: provider.img != null
                ? ClipOval(
                    child: Image.file(
                      provider.img!,
                      height: 38,
                    ),
                  )
                : Container(
                    height: 38,
                    width: 38,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffEAEAEA)),
                    alignment: Alignment.center,
                    child: Image.asset(
                      AppImages.cameraIcon,
                      height: 20,
                      width: 20,
                    ),
                  ),
          ),
          ScreenSize.width(12),
          Expanded(
              child: TextFormField(
            cursorHeight: 20,
            controller: provider.groupNameController,
            decoration: const InputDecoration(
                isDense: false,
                // suffixIcon: Container(
                //   height: 20,
                //   width: 20,
                //   alignment: Alignment.center,
                //   child: Image.asset(
                //     AppImages.emojiIcon,
                //     height: 18,
                //     width: 18,
                //   ),
                // ),
                hintText: 'Group name',
                hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff9D9D9D),
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.interRegular),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEEEEEE)),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.redColor, width: 1),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.redColor, width: 1),
                ),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffEEEEEE)))),
            validator: (val) {
              if (val!.isEmpty) {
                return "Please enter group name";
              }
              return null;
            },
          ))
        ],
      ),
    );
  }
}
