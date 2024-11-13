import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/screens/main/imageresult_screen.dart';
import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/services/storage_service.dart';
import 'package:detect_fakes/services/api_service.dart';
import 'package:detect_fakes/models/image_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'dart:io';

class DetectImageController extends GetxController {
  final ApiService apiService = ApiService();
  final StorageService storageService = StorageService();
  final fireAuthController = Get.find<FireAuthController>();
  final fireStoreController = Get.find<FireStoreController>();

  Future<void> detectImage(File imageFile) async {
    late File detectedImage;
    try {
      ScreenLoader.openScreenLoader(
        "Uploading image to server for detection ...",
        AppImages.uploadingDataAnimation,
      );

      ImageModel imageData = await apiService.detectImage(imageFile);
      final String deleteImagePath = imageData.imageUrl;
      detectedImage = await apiService.downloadFile(
        imageData.imageUrl,
        "DFTempImage_${DateTime.now()}.png",
      );
      await apiService.deleteFile(deleteImagePath, "Image");

      ScreenLoader.closeScreenLoader();
      ScreenLoader.openScreenLoader(
        "Performing detection please wait ...",
        AppImages.scanningDataAnimation,
      );

      String uploadedImageUrl = await storageService.uploadFile(
        file: detectedImage,
        userId: fireAuthController.currentUserId!,
        fileId: imageData.imageId,
        detectionDateTime: imageData.detectionDateTime,
        isImage: true,
      );

      imageData.userId = fireAuthController.currentUserId!;
      imageData.imageId = "${imageData.userId}&${imageData.imageId}";
      imageData.imageUrl = uploadedImageUrl;

      ScreenLoader.closeScreenLoader();
      ScreenLoader.openScreenLoader(
        "Saving the results please wait ...",
        AppImages.savingDataAnimation,
      );

      await fireStoreController.addImage(imageData);

      ScreenLoader.closeScreenLoader();
      CustomSnackbars.successSnackbar(
        title: "Detection Succesfull",
        message: "Now, you can use see the results of the detection.",
      );

      Get.to(
        () => ImageResultScreen(
          imageData: imageData,
          detectedImage: detectedImage,
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
