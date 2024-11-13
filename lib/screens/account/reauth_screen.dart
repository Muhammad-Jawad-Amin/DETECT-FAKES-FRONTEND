import 'package:detect_fakes/common/forms/reauth_form.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ReauthScreen extends StatelessWidget {
  const ReauthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.clear,
              size: AppSizes.iconXg,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AppImages.reAuthenticationAnimation,
                width: Get.width * 0.8,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              Text(
                AppTexts.reAuthenticationTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Text(
                AppTexts.reAuthenticationSubTitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              const ReAuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
