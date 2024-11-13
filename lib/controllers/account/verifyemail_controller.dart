import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/screens/account/success_screen.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:get/get.dart';
import 'dart:async';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  Future<void> sendEmailVerification() async {
    try {
      await fireAuthController.sendEmailVerification();
      CustomSnackbars.successSnackbar(
        title: "Email Sent",
        message: "Please check your inbox and verify your email.",
      );
    } catch (e) {
      CustomSnackbars.errorSnackbar(
        title: "On Snap!",
        message: e.toString(),
      );
    }
  }

  void setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        bool isEmailVerified = await fireAuthController.isUserEmailVerified();
        if (isEmailVerified) {
          timer.cancel();
          Get.off(
            () => SuccessScreen(
              imageSuccess: AppImages.accountSuccessfulAnimation,
              titleSuccess: AppTexts.yourAccountCreatedTitle,
              subTitleSuccess: AppTexts.yourAccountCreatedSubTitle,
              onPressedSuccess: fireAuthController.screenRedirect,
            ),
          );
        }
      },
    );
  }

  Future<void> checkEmailVerified() async {
    bool isEmailVerified = await fireAuthController.isUserEmailVerified();
    if (isEmailVerified) {
      SuccessScreen(
        imageSuccess: AppImages.accountSuccessfulAnimation,
        titleSuccess: AppTexts.yourAccountCreatedTitle,
        subTitleSuccess: AppTexts.yourAccountCreatedSubTitle,
        onPressedSuccess: fireAuthController.screenRedirect,
      );
    } else {
      CustomSnackbars.warningSnackbar(
        title: "Email Not Verified",
        message: "Please check your inbox and verify your email first.",
      );
    }
  }
}
