import 'package:detect_fakes/common/loaders/animation_loader.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenLoader {
  static void openScreenLoader(String text, String animation, {Color? color}) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: color ?? (Get.isDarkMode ? AppColors.dark : AppColors.light),
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              AnimationLoader(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static void closeScreenLoader() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
