import 'package:detect_fakes/controllers/account/reauth_controller.dart';
import 'package:detect_fakes/screens/account/forgetpassword_screen.dart';
import 'package:detect_fakes/utils/others/validation_utils.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class ReAuthForm extends StatelessWidget {
  const ReAuthForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReAuthController());

    return Form(
      key: controller.reAuthFormKey,
      child: Column(
        children: [
          TextFormField(
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
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              obscureText: controller.hidePassword.value,
              controller: controller.passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Iconsax.password_check,
                ),
                labelText: AppTexts.password,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.hidePassword.value =
                        !controller.hidePassword.value;
                  },
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
              validator: (value) => ValidationUtils.validatePassword(
                AppTexts.password,
                value,
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.xs,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppTexts.forgetPasswordQuestion,
              ),
              TextButton(
                onPressed: () {
                  Get.to(
                    () => const ForgetPasswordScreen(
                      changePassword: true,
                    ),
                  );
                },
                child: Text(
                  AppTexts.forgetPasswordTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppSizes.xs,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.reAuthenticate(),
              child: const Text(
                AppTexts.reAuthenticate,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
