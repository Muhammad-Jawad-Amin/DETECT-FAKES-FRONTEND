import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/controllers/appdata/user_controller.dart';
import 'package:detect_fakes/screens/account/verifyemail_screen.dart';
import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();
  final fireStoreController = Get.find<FireStoreController>();
  late final UserController userController;

  final hideNewPassword = true.obs;
  final hideConfPassword = true.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeControllers();
    super.onInit();
  }

  void initializeControllers() {
    if (!Get.isRegistered<UserController>()) {
      userController = Get.put(UserController(), permanent: true);
    } else {
      userController = Get.find<UserController>();
    }
  }

  Future<void> signUp() async {
    try {
      ScreenLoader.openScreenLoader(
        "Please wait. While we are processing your information ...",
        AppImages.processingInfoAnimation,
      );

      if (!signUpFormKey.currentState!.validate()) {
        ScreenLoader.closeScreenLoader();
        return;
      }

      final user = await fireAuthController.signUpWithEmailPassword(
        emailController.text.trim(),
        newPasswordController.text.trim(),
      );

      final newUser = UserModel(
        userId: user!.uid,
        email: emailController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        gender: genderController.text.trim(),
        country: countryController.text.trim(),
        dateOfBirth: dateOfBirthController.text.trim(),
      );

      fireStoreController.addUser(newUser);
      userController.updateUserData(newUser);

      ScreenLoader.closeScreenLoader();

      CustomSnackbars.successSnackbar(
        title: "Congratulation",
        message: "Your account has been created verify the email to continue.",
      );

      Get.off(
        () => VerifyEmailScreen(
          email: emailController.text.trim(),
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
}
