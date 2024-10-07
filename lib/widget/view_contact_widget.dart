import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ViewContactWidget extends StatelessWidget {
  List contactList;
  int index;
  bool isSelect;
  ViewContactWidget(
      {required this.contactList, required this.index, this.isSelect = true});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewGroupProvider>(context);
    var model = contactList[index];
    return GestureDetector(
      onTap: () {
        if (isSelect) {
          if (model.isSelected) {
            model.isSelected = false;
            provider.removeSelectedContact(model.id);
          } else {
            model.isSelected = true;
            provider.addContact(model);
          }
          // setState(() {});
        }
      },
      child: Container(
        color: AppColor.whiteColor,
        child: Row(
          children: [
            SizedBox(
              width: 38,
              child: Stack(
                children: [
                  ClipOval(
                    child: ViewNetworkImage(
                      img: model.image,
                      height: 33.0,
                    ),
                  ),
                  model.isSelected
                      ? Positioned(
                          bottom: 0 + 2,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.whiteColor),
                                shape: BoxShape.circle,
                                color: AppColor.appColor),
                            child: const Icon(
                              Icons.check,
                              color: AppColor.whiteColor,
                              size: 12,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            ScreenSize.width(15),
            Expanded(
              child: customText(
                title: model.name ?? '',
                fontSize: 14,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.interSemiBold,
              ),
            ),
            // customText(
            //   title: index == 4 ? 'Invite' : '',
            //   color: AppColor.appColor,
            //   fontSize: 14,
            //   fontWeight: FontWeight.w500,
            //   fontFamily: FontFamily.interMedium,
            // )
          ],
        ),
      ),
    );
  }
}
