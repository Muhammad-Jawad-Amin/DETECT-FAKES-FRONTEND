import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/screens/account/changepassword_screen.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReAuthController extends GetxController {
  static ReAuthController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();

  final hidePassword = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  Future<void> reAuthenticate() async {
    try {
      ScreenLoader.openScreenLoader(
        "Please wait. While we are re-authenticating you for critical operations ...",
        AppImages.loadingAnimation,
      );

      if (!reAuthFormKey.currentState!.validate()) {
        ScreenLoader.closeScreenLoader();
        return;
      }

      final isAutheticated = await fireAuthController.reauthenticateUser(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (isAutheticated) {
        ScreenLoader.closeScreenLoader();
        CustomSnackbars.successSnackbar(
          title: "Authentication Successful",
          message:
              "You are authenticated, now you can perform critical opearations.",
        );
        Get.off(
          () => const ChangePasswordScreen(),
        );
      } else {
        ScreenLoader.closeScreenLoader();
        CustomSnackbars.errorSnackbar(
          title: "Authentication UnSuccessful",
          message: "Please use the correct credentials for authentication.",
        );
      }
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }
}
