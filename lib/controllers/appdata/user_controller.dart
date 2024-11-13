import 'package:detect_fakes/common/loaders/custom_snackbars.dart';
import 'package:detect_fakes/common/loaders/screen_loader.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final fireAuthController = Get.find<FireAuthController>();
  final fireStoreController = Get.find<FireStoreController>();

  Rx<UserModel> user = UserModel(
    userId: '',
    email: '',
    firstName: '',
    lastName: '',
    gender: '',
    country: '',
    dateOfBirth: '',
  ).obs;

  @override
  void onInit() {
    loadUserData();
    super.onInit();
  }

  Future<void> loadUserData() async {
    try {
      String? userId = fireAuthController.currentUserId;
      if (userId != null) {
        UserModel? fetchedUser = await fireStoreController.getUserById(userId);
        if (fetchedUser != null) {
          user.value = fetchedUser;
        }
      }
    } catch (e) {
      ScreenLoader.closeScreenLoader();
      CustomSnackbars.errorSnackbar(
        title: "On Snap",
        message: e.toString(),
      );
    }
  }

  Future<void> updateUserData(UserModel userData) async {
    user.value = userData;
  }
}
