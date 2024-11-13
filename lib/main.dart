import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:detect_fakes/firebase_options.dart';
import 'package:detect_fakes/utils/theme/app_theme.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:detect_fakes/screens/others/splash_screen.dart';
import 'package:detect_fakes/controllers/others/app_bindings.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/firebase/firestore_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) {
    Get.put(FireAuthController(), permanent: true);
    Get.put(FireStoreController(), permanent: true);
  });
  runApp(const DFApp());
}

class DFApp extends StatelessWidget {
  const DFApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppTexts.appName,
      themeMode: getThemeMode(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: AppBindings(),
    );
  }

  ThemeMode getThemeMode() {
    final deviceStorage = GetStorage();
    deviceStorage.writeIfNull("AppTheme", "System");
    String themeMode = deviceStorage.read("AppTheme");
    if (themeMode == "Dark") {
      return ThemeMode.dark;
    } else if (themeMode == "Light") {
      return ThemeMode.light;
    }
    return ThemeMode.system;
  }
}
