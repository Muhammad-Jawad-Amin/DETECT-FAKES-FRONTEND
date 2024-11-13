import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/services/download_service.dart';
import 'package:detect_fakes/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryVideoController extends GetxController {
  var videos = <VideoModel>[].obs;
  final fireStoreController = Get.find<FireStoreController>();
  final fireAuthController = Get.find<FireAuthController>();
  final downloadService = DownloadService();

  @override
  void onInit() {
    super.onInit();
    observeVideoHistory();
  }

  void observeVideoHistory() {
    try {
      fireStoreController.listenToVideoCollection(
        videos,
        fireAuthController.currentUserId!,
      );
    } catch (e) {
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> deleteVideo(String videoId) async {
    try {
      ScreenLoader.openScreenLoader(
        "Deleting the video please wait ...",
        AppImages.loadingAnimation,
        color: Colors.transparent,
      );
      await fireStoreController.deleteImage(videoId);
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.successSnackbar(
        title: "Deletion Succesfull",
        message: "Video is deleted successfully.",
      );
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> downloadVideo(String videoUrl) async {
    try {
      ScreenLoader.openScreenLoader(
        "Downloading video in the local storage ...",
        AppImages.downloadingDataAnimation,
        color: Colors.transparent,
      );
      await downloadService.saveVideoToGallery(videoUrl);
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.successSnackbar(
        title: "Downloading Succesfull",
        message: "Now, you can view the video from your device gallery.",
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
