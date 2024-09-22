import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kodago/api/api_service.dart';
import 'package:kodago/api/api_url.dart';
import 'package:kodago/config/app_routes.dart';
import 'package:kodago/model/profile_model.dart';
import 'package:kodago/presentation/auth/otp_verification_screen.dart';
import 'package:kodago/presentation/dashboard/profile/change_password_screen.dart';
import 'package:kodago/presentation/dashboard/profile/edit_profile_screen.dart';
import 'package:kodago/presentation/dashboard/profile/profile_screen.dart';
import 'package:kodago/uitls/constants.dart';
import 'package:kodago/uitls/enum.dart';
import 'package:kodago/uitls/session_manager.dart';
import 'package:kodago/uitls/show_loader.dart';
import 'package:kodago/uitls/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileProvider extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  ProfileModel? profileModel;
  File? img;

  updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  menuClickable(int index) {
    switch (index) {
      case 0:
        AppRoutes.pushCupertinoNavigation(const EditProfileScreen())
            .then((val) {
          getProfileApiFunction();
        });
        break;
      case 1:
        AppRoutes.pushCupertinoNavigation(const ChangePasswordScreen());
        break;
      case 2:
        logoutDialog();
        break;
      default:
    }
  }

  setControllersValues() {
    nameController.text = profileModel!.data!.name ?? "";
    emailController.text = profileModel!.data!.email ?? "";
    mobileController.text = profileModel!.data!.phoneNumber ?? "";
  }

  getProfileApiFunction() async {
    profileModel == null ? showLoader(navigatorKey.currentContext!) : null;
    var body = {
      "Authkey": Constants.authkey,
      "Userid": SessionManager.userId,
      "Token": SessionManager.token
    };
    print(body);
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.getProfileUrl, body: body);
    profileModel == null ? Navigator.pop(navigatorKey.currentContext!) : null;
    if (response != null) {
      profileModel = ProfileModel.fromJson(response);
      setControllersValues();
    } else {
      profileModel = null;
    }
    notifyListeners();
  }

  updateProfileApiFunction(bool isShowLoader,
      {String otp = '', bool isOtp = false}) async {
    isShowLoader
        ? showLoader(navigatorKey.currentContext!)
        : updateLoading(true);
    var body = {
      "Authkey": Constants.authkey,
      "Userid": SessionManager.userId,
      "Token": SessionManager.token,
      'name': nameController.text,
      'email': emailController.text,
      'phone_number': mobileController.text,
      'verify_otp': otp
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.updateProfileUrl, body: body);
    isShowLoader
        ? Navigator.pop(navigatorKey.currentContext!)
        : updateLoading(false);
    if (response != null) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      if (isOtp == false) {
        if (response['show_verify_popup'] == true) {
          AppRoutes.pushCupertinoNavigation(OtpVerificationScreen(
              mobileNumber: mobileController.text,
              route: OtpVerificationScreenRoute.update.name));
        }
      } else {
        Navigator.pop(navigatorKey.currentContext!);
      }
    }
  }

  changePasswordApiFunction() async {
    updateLoading(true);
    var body = {
      "Authkey": Constants.authkey,
      "Userid": SessionManager.userId,
      "Token": SessionManager.token,
      "current_password": currentPasswordController.text,
      "new_password": passwordController.text,
      'confirm_password': confirmPasswordController.text
    };
    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.changePasswordUrl, body: body);
    updateLoading(false);
    if (response != null && response['status'] == 1) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      Navigator.pop(navigatorKey.currentContext!);
    }
  }

  uploadImageApiFunction() async {
    showLoader(navigatorKey.currentContext!);
    var body = {
      "Authkey": Constants.authkey,
      "Userid": SessionManager.userId,
      "Token": SessionManager.token,
    };

    final response = await ApiService.multiPartApiMethod(
        url: ApiUrl.updateImageUrl, body: body, imgFile: img);
    Navigator.pop(navigatorKey.currentContext!);
    if (response != null && response['status'] == 1) {
      Utils.successSnackBar(response['message'], navigatorKey.currentContext!);
      getProfileApiFunction();
    }
  }

  pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
      notifyListeners();
      return pickedFile.path;
    } else {}
  }

  _cropImage(File imgFile) async {
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
      img = File(croppedFile.path);
      uploadImageApiFunction();
    }
  }
}
