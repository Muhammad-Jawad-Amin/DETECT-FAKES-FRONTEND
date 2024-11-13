import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerService {
  final ImagePicker _picker = ImagePicker();

  static const int maxImageSize = 5 * 1024 * 1024;
  static const int maxVideoSize = 50 * 1024 * 1024;

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        Get.snackbar("Image", "No image is selected.");
        return null;
      }

      final File imageFile = File(pickedFile.path);
      final int imageSize = await imageFile.length();
      if (imageSize > maxImageSize) {
        Get.snackbar("Image",
            "Can't slect image. Image size exceeds the maximum limit of 5MB.");
        return null;
      }

      return imageFile;
    } catch (e) {
      Get.snackbar("Image", "Unable to select the image. Try selecting again.");
      return null;
    }
  }

  Future<File?> pickVideoFromGallery() async {
    try {
      final XFile? pickedFile =
          await _picker.pickVideo(source: ImageSource.gallery);

      if (pickedFile == null) {
        Get.snackbar("Video", "No Video is selected.");
        return null;
      }

      final File videoFile = File(pickedFile.path);
      final int videoSize = await videoFile.length();
      if (videoSize > maxVideoSize) {
        Get.snackbar("Video",
            "Can't slect video. Video size exceeds the maximum limit of 50MB.");
        return null;
      }

      return videoFile;
    } catch (e) {
      Get.snackbar("Video", "Unable to select the video. Try selecting again.");
      return null;
    }
  }
}
