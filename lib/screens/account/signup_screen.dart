import 'package:detect_fakes/common/forms/signup_form.dart';
import 'package:detect_fakes/screens/account/login_screen.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.off(
                () => const LoginScreen(),
              );
            },
            icon: const Icon(
              CupertinoIcons.clear,
              size: AppSizes.iconXg,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          AppSizes.defaultSpace,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                AppImages.createAccountAnimation,
                width: Get.width * 0.5,
              ),
              const SizedBox(
                height: AppSizes.md,
              ),
              Text(
                AppTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              const SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
