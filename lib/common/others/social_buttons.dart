import 'package:detect_fakes/controllers/account/login_controller.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogInController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.xs,
              ),
            ),
            onPressed: () => controller.signInWithGoogle(),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: null,
                  icon: Image(
                    width: AppSizes.iconLg,
                    height: AppSizes.iconLg,
                    image: AssetImage(AppImages.google),
                  ),
                ),
                SizedBox(
                  width: AppSizes.sm,
                ),
                Text(AppTexts.google),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: AppSizes.md,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.xs,
              ),
            ),
            onPressed: () => controller.signInAsGuestUser(),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: null,
                  icon: Image(
                    width: AppSizes.iconLg,
                    height: AppSizes.iconLg,
                    image: AssetImage(AppImages.guest),
                  ),
                ),
                SizedBox(
                  width: AppSizes.md,
                ),
                Text(AppTexts.guest),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
