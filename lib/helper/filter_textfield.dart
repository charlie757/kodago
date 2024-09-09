// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';

// ignore: must_be_immutable
class FilterTextfield extends StatelessWidget {
  final hintText;
  final TextEditingController? controller;
  final icon;
  final isObscureText;
  final isReadOnly;
  final errorMsg;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final ValueChanged<String>? onChanged;
  TextInputAction? textInputAction;
  FilterTextfield(
      {super.key,
      this.hintText,
      this.controller,
      this.icon,
      this.isObscureText = false,
      this.isReadOnly = false,
      this.inputFormatters,
      this.textInputType = TextInputType.text,
      this.errorMsg = '',
      this.onChanged,
      this.textInputAction});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                    color: AppColor.blackColor.withOpacity(.2))
              ]),
          child: TextFormField(
            controller: controller,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            readOnly: isReadOnly,
            cursorColor: AppColor.blackColor,
            obscureText: isObscureText,
            keyboardType: textInputType,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: AppColor.blackColor,
                fontFamily: FontFamily.interRegular),
            decoration: InputDecoration(
                suffixIcon: icon,
                hintText: hintText,
                hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: AppColor.grey6AColor,
                    fontFamily: FontFamily.interRegular),
                fillColor: AppColor.whiteColor,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: errorMsg == '' || errorMsg == null
                            ? AppColor.whiteColor
                            : AppColor.redColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: errorMsg == '' || errorMsg == null
                            ? AppColor.whiteColor
                            : AppColor.redColor))),
            onChanged: onChanged,
          ),
        ),
        errorMsg == '' || errorMsg == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(left: 4, top: 5),
                child: customText(
                    title: errorMsg.toString(),
                    fontSize: 12,
                    fontFamily: FontFamily.poppinsRegular,
                    color: AppColor.redColor,
                    fontWeight: FontWeight.w500),
              )
      ],
    );
  }
}
