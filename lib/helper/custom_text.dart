import 'package:flutter/material.dart';
import 'package:kodago/helper/font_family.dart';

// ignore: must_be_immutable
class customText extends StatelessWidget {
  String title;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  String fontFamily;
  TextAlign textAlign;
  int? maxLines;
  customText({
    required this.title,
    this.fontSize = 14,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.fontFamily = FontFamily.interRegular,
    this.textAlign = TextAlign.start,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }
}
