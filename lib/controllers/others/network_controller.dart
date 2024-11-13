import 'package:get/get.dart';
import 'package:detect_fakes/screens/others/nointernet_screen.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkController extends GetxController {
  final InternetConnection connectivity = InternetConnection();

  @override
  void onInit() {
    super.onInit();
    connectivity.onStatusChange.listen(updateConnectionStatus);
  }

  void updateConnectionStatus(InternetStatus connectionStatus) {
    if (connectionStatus == InternetStatus.disconnected) {
      Get.to(() => const NoInternetScreen());
    } else {
      if (Get.currentRoute == '/NoInternetScreen') {
        Get.back();
      }
    }
  }
}
