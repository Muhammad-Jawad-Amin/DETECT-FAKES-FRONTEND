import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class CustomSnackbars {
  static hideSnackbar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(AppSizes.md),
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.xl),
            color: Get.isDarkMode
                ? AppColors.darkGrey.withOpacity(0.9)
                : AppColors.grey.withOpacity(0.9),
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.labelLarge,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static successSnackbar({required title, message = ""}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: AppColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(AppSizes.md),
      icon: const Icon(
        Icons.check_circle,
        color: AppColors.white,
      ),
    );
  }

  static warningSnackbar({required title, message = ""}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(AppSizes.md),
      icon: const Icon(
        Iconsax.warning_2,
        color: AppColors.white,
      ),
    );
  }

  static errorSnackbar({required title, message = ""}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(AppSizes.md),
      icon: const Icon(
        Iconsax.warning_2,
        color: AppColors.white,
      ),
    );
  }
}
