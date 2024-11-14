import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/others/network_controller.dart';
import 'package:get/get.dart';

class AppBindings {
  static void initNetworkController() {
    Get.put(NetworkController(), permanent: true);
  }

  static void initFirebaseControllers() {
    Get.put(FireAuthController(), permanent: true);
    Get.put(FireStoreController(), permanent: true);
  }
}
