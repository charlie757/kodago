import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/helper/custom_btn.dart';
import 'package:kodago/helper/custom_text.dart';
import 'package:kodago/helper/font_family.dart';
import 'package:kodago/helper/screen_size.dart';
import 'package:kodago/provider/auth_provider/otp_provider.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;
  final String route;
  OtpVerificationScreen({required this.mobileNumber, required this.route});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  void initState() {
    callInitFunction();
    super.initState();
  }

  callInitFunction() {
    final provider = Provider.of<OtpProvider>(context, listen: false);
    provider.resetValues();
    provider.startTimer();
    if (widget.route == OtpVerificationScreenRoute.forgot.name) {
      provider.resendApiUrl = ApiUrl.forgotResendUrl;
    } else {
      provider.resendApiUrl = ApiUrl.resendOtpUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpProvider>(builder: (context, myProvider, child) {
      return Scaffold(
        appBar: appBar(title: ''),
        body: Form(
          key: myProvider.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 59),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  title: 'OTP Verification',
                  fontFamily: FontFamily.interBold,
                  color: AppColor.blackDarkColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
                customText(
                  title:
                      'Enter the verification code we just sent on your phone number xxxxxx${widget.mobileNumber.substring(6)}.',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.interRegular,
                  color: AppColor.b45Color,
                ),
                ScreenSize.height(60),
                otpField(myProvider),
                ScreenSize.height(18),
                CustomBtn(
                    title: 'Verify',
                    borderRadius: 50,
                    isLoading: myProvider.isLoading,
                    onTap: () {
                      myProvider.isLoading
                          ? null
                          : myProvider.checkValidation(widget.route);
                    }),
                ScreenSize.height(15),
                InkWell(
                  onTap: () {
                    myProvider.counter == 0
                        ? myProvider.resendApiFunction('123123123123')
                        : null;
                  },
                  child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text.rich(TextSpan(
                          text: 'Don’t receive the OTP? ',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: FontFamily.interMedium,
                              color: AppColor.blackDarkColor),
                          children: [
                            TextSpan(
                                text: myProvider.counter == 0
                                    ? "Resend OTP"
                                    : "00:${myProvider.counter}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.interMedium,
                                    color: myProvider.counter == 0
                                        ? AppColor.appColor
                                        : AppColor.blackDarkColor))
                          ]))),
                ),
                ScreenSize.height(10),
              ],
            ),
          ),
        ),
      );
    });
  }

  otpField(OtpProvider provider) {
    final decoration = BoxDecoration(
      border: Border.all(color: const Color(0xffD0D5DD)),
      borderRadius: BorderRadius.circular(8),
    );

    return Pinput(
      length: 6,
      controller: provider.otpController,
      validator: (val) {
        if (val!.isEmpty) {
          return 'Enter otp';
        } else if (val.length < 6) {
          return 'Incorrect otp';
        }
        return null;
      },
      forceErrorState: true,
      defaultPinTheme: PinTheme(
          width: 52,
          height: 50,
          textStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          decoration: decoration),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      focusedPinTheme: PinTheme(
          width: 52,
          height: 50,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: decoration),
      submittedPinTheme: PinTheme(
          width: 52,
          height: 50,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: decoration),
      showCursor: true,
      errorTextStyle: const TextStyle(
          fontWeight: FontWeight.w400, color: AppColor.redColor),
      onCompleted: (pin) => print(pin),
    );
  }
}
