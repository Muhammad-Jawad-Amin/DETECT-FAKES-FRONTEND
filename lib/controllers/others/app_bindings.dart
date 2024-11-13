import 'package:detect_fakes/controllers/history/historyimage_controller.dart';
import 'package:detect_fakes/controllers/history/historyvideo_controller.dart';
import 'package:detect_fakes/controllers/others/network_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController(), permanent: true);
    Get.put(HistoryImageController(), permanent: true);
    Get.put(HistoryVideoController(), permanent: true);
  }
}
