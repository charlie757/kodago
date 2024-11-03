import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helper/app_color.dart';

showLoader(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColor.blackColor.withOpacity(.2),
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: CustomCircularProgressIndicator(),
        );
      });
}

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 37,
            height: 37,
            decoration: const BoxDecoration(
                color: AppColor.whiteColor, shape: BoxShape.circle),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(6),
            child: const CircularProgressIndicator(
              color: AppColor.appColor,
              strokeWidth: 3,
            )),
      ],
    );
  }
}
