import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/models/profilepic_model.dart';
import 'package:get/get.dart';

class ProfilePicController extends GetxController {
  static ProfilePicController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();
  final fireStoreController = Get.find<FireStoreController>();

  var profilePicModel = ProfilePicModel(
    userId: '',
    currentImageUrl: '',
    previousImageUrls: [],
  ).obs;

  @override
  void onInit() {
    loadProfilePicture();
    super.onInit();
  }

  Future<void> loadProfilePicture() async {
    String? userId = fireAuthController.currentUserId;
    if (userId != null) {
      ProfilePicModel? profilePicture =
          await fireStoreController.getUserProfilePicture(userId);
      if (profilePicture != null) {
        profilePicModel.value = profilePicture;
      }
    }
  }

  Future<void> updateProfilePicture(String newImageUrl) async {
    String? userId = fireAuthController.currentUserId;
    if (userId != null) {
      var updatedPreviousImages =
          List<String>.from(profilePicModel.value.previousImageUrls)
            ..add(profilePicModel.value.currentImageUrl);
      profilePicModel.value = profilePicModel.value.copyWith(
        userId: fireAuthController.currentUserId,
        currentImageUrl: newImageUrl,
        previousImageUrls: updatedPreviousImages,
      );
      await fireStoreController.updateProfilePicture(profilePicModel.value);
    }
  }
}
