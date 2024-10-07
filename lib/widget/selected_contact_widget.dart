import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/services/provider/group/new_group_provider.dart';
import 'package:provider/provider.dart';

class SelectedContactWidget extends StatelessWidget {
  final bool topClose;
  const SelectedContactWidget({this.topClose = true});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewGroupProvider>(
      context,
    );
    return SizedBox(
      height: 75,
      child: ListView.separated(
          separatorBuilder: (context, sp) {
            return ScreenSize.width(15);
          },
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: provider.addedList.length,
          itemBuilder: (context, index) {
            var model = provider.addedList[index];
            return GestureDetector(
              onTap: () {
                provider.unselectedContacts(model.id);
              },
              child: SizedBox(
                width: 55,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: ViewNetworkImage(
                            img: model.image,
                            height: 48.8,
                          ),
                        ),
                        Positioned(
                          bottom: topClose ? null : 0,
                          right: 0,
                          child: Container(
                            height: 16,
                            width: 16,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColor.whiteColor),
                                shape: BoxShape.circle,
                                color: const Color(0xff979797)),
                            child: const Icon(
                              Icons.close,
                              color: AppColor.whiteColor,
                              size: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                    ScreenSize.height(5),
                    Text(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.interRegular,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
