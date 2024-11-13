import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  static LogInController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();
  final fireStoreController = Get.find<FireStoreController>();

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final deviceStorage = GetStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    emailController.text = deviceStorage.read("RememberMeEmail") ?? "";
    passwordController.text = deviceStorage.read("RememberMePassword") ?? "";
    super.onInit();
  }

  Future<void> logIn() async {
    try {
      ScreenLoader.openScreenLoader(
        "Please wait. While we are logging you in.....",
        AppImages.loadingAnimation,
      );

      if (!logInFormKey.currentState!.validate()) {
        ScreenLoader.closeScreenLoader();
        return;
      }

      if (rememberMe.value) {
        deviceStorage.write(
          "RememberMeEmail",
          emailController.text.trim(),
        );
        deviceStorage.write(
          "RememberMePassword",
          passwordController.text.trim(),
        );
      }

      await fireAuthController.signInWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      ScreenLoader.closeScreenLoader();

      CustomSnackbars.successSnackbar(
        title: "Login Successfull",
        message: "You can now start using the app to Detect Fakes.",
      );

      fireAuthController.screenRedirect();
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      ScreenLoader.openScreenLoader(
          "Logging you in .....", AppImages.loadingAnimation);

      final user = await fireAuthController.signInWithGoogle();
      final nameParts = UserModel.nameParts(user!.displayName ?? "");
      final userData = UserModel(
        userId: user.uid,
        email: user.email ?? "",
        firstName: nameParts[0],
        lastName: nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "",
        gender: "Google",
        country: "Google",
        dateOfBirth: DateTime.now().toString(),
      );

      fireStoreController.addUser(userData);
      ScreenLoader.closeScreenLoader();

      CustomSnackbars.successSnackbar(
        title: "Login Successfull",
        message: "You can now start using the app to Detect Fakes.",
      );

      fireAuthController.screenRedirect();
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> signInAsGuestUser() async {
    try {
      ScreenLoader.openScreenLoader(
          "Logging you in .....", AppImages.loadingAnimation);

      final user = await fireAuthController.signInAnonymously();
      final userData = UserModel(
        userId: user!.uid,
        email: "Guest User",
        firstName: "Guest",
        lastName: "User",
        gender: "Guest",
        country: "Guest",
        dateOfBirth: DateTime.now().toString(),
      );

      fireStoreController.addUser(userData);
      ScreenLoader.closeScreenLoader();

      CustomSnackbars.successSnackbar(
        title: "Login Successfull",
        message: "You can now start using the app to Detect Fakes.",
      );

      fireAuthController.screenRedirect();
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }
}
