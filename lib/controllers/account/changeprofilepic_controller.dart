import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/appdata/profilepic_controller.dart';
import 'package:detect_fakes/screens/main/settings_screen.dart';
import 'package:detect_fakes/services/storage_service.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:get/get.dart';
import 'dart:io';

class ChangeProfilePicController extends GetxController {
  static ChangeProfilePicController get instance => Get.find();
  final profilePicController = Get.find<ProfilePicController>();
  final fireAuthController = Get.find<FireAuthController>();
  final storageService = StorageService();

  Future<void> uploadProfilePic(File? profilePic) async {
    try {
      ScreenLoader.openScreenLoader(
        "Uploading profile picture.....",
        AppImages.uploadingDataAnimation,
      );

      if (profilePic == null) {
        ScreenLoader.closeScreenLoader();
        CustomSnackbars.errorSnackbar(
            title: "No Image Found",
            message: "Please select an image to change your profile picture.");
        return;
      }

      final pictureUrl = await storageService.uploadProfilePicture(
        file: profilePic,
        userId: fireAuthController.currentUserId!,
      );

      await profilePicController.updateProfilePicture(pictureUrl);

      ScreenLoader.closeScreenLoader();

      CustomSnackbars.successSnackbar(
        title: "Profile Picture Set.",
        message:
            "Your profile picture is set, you can also change it from settings.",
      );

      Get.off(() => const SettingsScreen());
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }
}
