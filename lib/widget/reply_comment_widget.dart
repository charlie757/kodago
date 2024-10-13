import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/helper/app_images.dart';
import 'package:kodago/helper/custom_horizontal_line.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/helper/view_network_image.dart';
import 'package:kodago/uitls/white_space_formatter.dart';

replyCommentWidget({required String img, TextEditingController? controller, Function()?onTap, bool isDefault=true}) {
  return Column(
    children: [
      customHorizontalDivider(
          height: 2, color: const Color(0xffE7E7E7).withOpacity(.6)),
      ScreenSize.height(15),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            isDefault?
            Image.asset(
              img,
              height: 32,
              width: 32,
            ):ClipOval(
              child: ViewNetworkImage(
                img: img,height: 32.0,width: 32.0,
              ),
            ),
            ScreenSize.width(11),
            Expanded(
              child: TextFormField(
                cursorHeight: 20,
                controller: controller,
                inputFormatters: [
                  WhiteSpaceFormatter()
                ],
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: FontFamily.interRegular,
                        color: Color(0xffABABAB))),
              ),
            ),
            ScreenSize.width(8),
            InkWell(
              onTap: onTap,
              child: Image.asset(
                AppImages.shareIcon,
                height: 20,
                width: 20,
              ),
            )
          ],
        ),
      )
    ],
  );
}
