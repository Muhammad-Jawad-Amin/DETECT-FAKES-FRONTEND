import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/screens/main/videoresult_screen.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/services/storage_service.dart';
import 'package:detect_fakes/models/video_model.dart';
import 'package:detect_fakes/services/api_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'dart:io';

class DetectVideoController extends GetxController {
  final ApiService apiService = ApiService();
  final StorageService storageService = StorageService();
  final fireAuthController = Get.find<FireAuthController>();
  final fireStoreController = Get.find<FireStoreController>();

  Future<void> detectVideo(
    File videoFile,
    int numFrames,
  ) async {
    late File detectedVideo;
    late File detectedThumbnail;
    try {
      ScreenLoader.openScreenLoader(
        "Uploading video to server for detection ...",
        AppImages.uploadingDataAnimation,
      );

      VideoModel videoData = await apiService.detectVideo(
        videoFile,
        numFrames.toString(),
      );

      final String deleteVideoPath = videoData.videoUrl;
      final String deleteThumbnailPath = videoData.thumbnailUrl;

      detectedVideo = await apiService.downloadFile(
        videoData.videoUrl,
        "DFTempVideo_${DateTime.now()}.mp4",
      );
      detectedThumbnail = await apiService.downloadFile(
        videoData.thumbnailUrl,
        "DFTempThumbnail_${DateTime.now()}.png",
      );

      await apiService.deleteFile(deleteVideoPath, "Video");
      await apiService.deleteFile(deleteThumbnailPath, "Thumbnail");

      ScreenLoader.closeScreenLoader();
      ScreenLoader.openScreenLoader(
        "Performing detection please wait ...",
        AppImages.scanningDataAnimation,
      );

      String uploadedVideoUrl = await storageService.uploadFile(
        file: detectedVideo,
        userId: fireAuthController.currentUserId!,
        fileId: videoData.videoId,
        detectionDateTime: videoData.detectionDateTime,
        isImage: false,
      );

      String uploadedThumbnailUrl = await storageService.uploadFile(
        file: detectedThumbnail,
        userId: fireAuthController.currentUserId!,
        fileId: videoData.videoId,
        detectionDateTime: videoData.detectionDateTime,
        isImage: false,
      );

      videoData.userId = fireAuthController.currentUserId!;
      videoData.videoId = "${videoData.userId}&${videoData.videoId}";
      videoData.videoUrl = uploadedVideoUrl;
      videoData.thumbnailUrl = uploadedThumbnailUrl;

      ScreenLoader.closeScreenLoader();
      ScreenLoader.openScreenLoader(
        "Saving the results please wait ...",
        AppImages.savingDataAnimation,
      );

      await fireStoreController.addVideo(videoData);

      ScreenLoader.closeScreenLoader();
      CustomSnackbars.successSnackbar(
        title: "Detection Succesfull",
        message: "Now, you can use see the results of the detection.",
      );

      Get.to(
        () => VideoResultScreen(
          videoData: videoData,
          detectedVideo: detectedVideo,
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

  @override
  void dispose() {
    deleteAllTempFiles();
    super.dispose();
  }

  Future<void> deleteAllTempFiles() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        tempDir.listSync().forEach(
          (file) async {
            if (file is File) {
              try {
                await file.delete();
              } catch (e) {
                CustomSnackbars.errorSnackbar(
                  title: "On Snap",
                  message: e.toString(),
                );
              }
            }
          },
        );
      }
    } catch (e) {
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }
}
