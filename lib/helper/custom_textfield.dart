// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/helper/font_family.dart';

import 'app_color.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final validator;
  final ValueChanged<String>? onChanged;
  final TextCapitalization textCapitalization;
  Widget? suffixWidget;
  Widget? prefixWidget;
  FocusNode? focusNode;
  Color? fillColor;
  Function()? onTap;
  Color borderColor;
  int maxLines;
  bool isObscureText;
  CustomTextField(
      {required this.hintText,
      this.controller,
      this.textInputType = TextInputType.text,
      this.inputFormatters,
      this.isReadOnly = false,
      this.textInputAction,
      this.validator,
      this.onChanged,
      this.suffixWidget,
      this.prefixWidget,
      this.textCapitalization = TextCapitalization.none,
      this.focusNode,
      this.fillColor,
      this.onTap,
      this.maxLines = 1,
      this.borderColor = AppColor.textfieldBorderColor,
      this.isObscureText = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // focusNode: widget.focusNode,
      onTap: widget.onTap,
      readOnly: widget.isReadOnly,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.isObscureText,
      controller: widget.controller,
      autofocus: false,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13.5,
          color: AppColor.blackColor,
          fontFamily: FontFamily.interMedium),
      cursorColor: AppColor.blackColor,
      decoration: InputDecoration(
        suffixIcon: widget.suffixWidget,
        prefixIcon: widget.prefixWidget,
        // isDense: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: 1),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.redColor, width: 1),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor, width: 1),
            borderRadius: BorderRadius.circular(10)),
        hintText: widget.hintText,
        errorStyle: const TextStyle(
          color: AppColor.redColor,
        ),
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13.5,
            color: AppColor.hintTextColor,
            fontFamily: FontFamily.interRegular),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
