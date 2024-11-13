import 'package:detect_fakes/utils/others/apphelper_functions.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;
    bool dark = AppHelperFunctions.isDarkMode();
    String appnamelogo;
    String appbranding;
    if (dark) {
      appnamelogo = AppImages.darkAppNameLogo;
      appbranding = AppImages.darkAppBranding;
    } else {
      appnamelogo = AppImages.lightAppNameLogo;
      appbranding = AppImages.lightAppBranding;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.3,
              child: Image.asset(appnamelogo),
            ),
            SizedBox(height: screenHeight * 0.05),
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: screenHeight * 0.1,
        width: screenWidth * 0.8,
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Image.asset(appbranding),
      ),
    );
  }
}
