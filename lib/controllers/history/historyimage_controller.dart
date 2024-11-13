import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/services/download_service.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/models/image_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryImageController extends GetxController {
  var images = <ImageModel>[].obs;
  final fireStoreController = Get.find<FireStoreController>();
  final fireAuthController = Get.find<FireAuthController>();
  final downloadService = DownloadService();

  @override
  void onInit() {
    super.onInit();
    observeImageHistory();
  }

  void observeImageHistory() {
    try {
      fireStoreController.listenToImagesCollection(
        images,
        fireAuthController.currentUserId!,
      );
    } catch (e) {
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> deleteImage(String imageId) async {
    try {
      ScreenLoader.openScreenLoader(
        "Deleting the image please wait ...",
        AppImages.loadingAnimation,
        color: Colors.transparent,
      );
      await fireStoreController.deleteImage(imageId);
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.successSnackbar(
        title: "Deletion Succesfull",
        message: "Image is deleted successfully.",
      );
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> downloadImage(String imageUrl) async {
    try {
      ScreenLoader.openScreenLoader(
        "Downloading image in the local storage ...",
        AppImages.downloadingDataAnimation,
        color: Colors.transparent,
      );
      await downloadService.saveImageToGallery(imageUrl);
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.successSnackbar(
        title: "Downloading Succesfull",
        message: "Now, you can view the image from your device gallery.",
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
