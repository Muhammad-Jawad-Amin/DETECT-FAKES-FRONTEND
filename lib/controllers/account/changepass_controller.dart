import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/screens/main/settings_screen.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassController extends GetxController {
  static ChangePassController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();

  final hideNewPassword = true.obs;
  final hideConfPassword = true.obs;
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  GlobalKey<FormState> changePassFormKey = GlobalKey<FormState>();

  Future<void> reAuthenticate() async {
    try {
      ScreenLoader.openScreenLoader(
        "Please wait. While we are changing your password ...",
        AppImages.loadingAnimation,
      );

      if (!changePassFormKey.currentState!.validate()) {
        ScreenLoader.closeScreenLoader();
        return;
      }

      await fireAuthController.updatePassword(
        newPasswordController.text.trim(),
      );
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.successSnackbar(
        title: "Password Changed",
        message: "Now, you can use your new password to login to your account.",
      );
      Get.off(
        () => const SettingsScreen(),
      );
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }
}
