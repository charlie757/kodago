import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kodago/helper/app_color.dart';
import 'package:kodago/widget/appbar.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {

  SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBar(title: 'Add Signature'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Signature(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              controller: signatureController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              padButtonOption(Colors.redAccent, 'Clear', (){
                signatureController.clear();
              }),
    
              padButtonOption(Colors.greenAccent, 'Done', () async {
                if(signatureController.isNotEmpty){
                  final signature = await exportSignature();
                  if(signature.isNotEmpty){
                    Navigator.pop(context,signature);
                    // Get.back(result: signature);
                  }
                }
              }),
            ],
          ),
        ],
      ),
    );
  }

  Future<Uint8List> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: signatureController.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature!;
  }

  ElevatedButton padButtonOption(Color btnClr, String btnTxt, Function() btnOnTapAction){
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(btnClr),),
        onPressed: btnOnTapAction,
        child: Text(btnTxt,style: const TextStyle(color: AppColor.whiteColor),));
  }

}