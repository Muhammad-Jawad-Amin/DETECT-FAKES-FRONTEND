import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/screens/account/resetpassword_screen.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassController extends GetxController {
  static ForgetPassController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> forgetPassFormKey = GlobalKey<FormState>();

  Future<void> sendResetPasswordEmail(bool changePassword) async {
    try {
      ScreenLoader.openScreenLoader(
        "Sending Password Reset Email.....",
        AppImages.loadingAnimation,
      );

      if (!forgetPassFormKey.currentState!.validate()) {
        ScreenLoader.closeScreenLoader();
        return;
      }

      await fireAuthController.sendPasswordResetEmail(
        emailController.text.trim(),
      );

      ScreenLoader.closeScreenLoader();

      CustomSnackbars.successSnackbar(
        title: "Email Sent",
        message: "Check your inbox for the email and chnage the password.",
      );

      Get.to(
        () => ResetPasswordScreen(
          userEmail: emailController.text.trim(),
          changePassword: changePassword,
        ),
      );
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> resendResetPasswordEmail(String email) async {
    try {
      ScreenLoader.openScreenLoader(
        "Re-Sending Password Reset Email.....",
        AppImages.loadingAnimation,
      );

      await fireAuthController.sendPasswordResetEmail(
        email,
      );

      ScreenLoader.closeScreenLoader();

      CustomSnackbars.successSnackbar(
        title: "Email Re-Sent",
        message: "Check your inbox for the email and chnage the password.",
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
