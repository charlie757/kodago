import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      final response = _cropImage(File(pickedFile.path));
      return response;
    } else {}
  }

static Future imagePickerWithoutCrop(ImageSource imageSource)async{
 final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      // final response = _cropImage(File(pickedFile.path));
      return File(pickedFile.path);
    } else {}
}

static Future videoPicker(ImageSource imageSource)async{
 final pickedFile = await ImagePicker().pickVideo(source: imageSource);
    if (pickedFile != null) {
      // final response = _cropImage(File(pickedFile.path));
      return File(pickedFile.path);
    } else {}

}

  static Future _cropImage(File imgFile) async {
    final croppedFile =
        await ImageCropper().cropImage(sourcePath: imgFile.path, uiSettings: [
      AndroidUiSettings(
          toolbarTitle: "Image Cropper",
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]),
      IOSUiSettings(
        title: "Image Cropper",
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
      )
    ]);
    if (croppedFile != null) {
      imageCache.clear();
      // img = File(croppedFile.path);
      // uploadImageApiFunction();
      return File(croppedFile.path);
    }
  }
}
