import 'package:detect_fakes/controllers/account/forgetpass_controller.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/others/validation_utils.dart';
import 'package:detect_fakes/screens/account/login_screen.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final bool changePassword;

  const ForgetPasswordScreen({
    super.key,
    required this.changePassword,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPassController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (changePassword) {
                Get.back();
              } else {
                Get.offAll(
                  () => const LoginScreen(),
                );
              }
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
          padding: const EdgeInsets.all(
            AppSizes.defaultSpace,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              Lottie.asset(
                AppImages.forgetPasswordAnimation,
                width: Get.width * 0.8,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections * 2,
              ),
              Text(
                AppTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwItems,
              ),
              Text(
                AppTexts.forgetPasswordSubTitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              Form(
                key: controller.forgetPassFormKey,
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Iconsax.direct_right,
                    ),
                    labelText: AppTexts.email,
                  ),
                  validator: (value) => ValidationUtils.validateEmail(
                    value,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      controller.sendResetPasswordEmail(changePassword),
                  child: const Text(
                    AppTexts.submit,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
