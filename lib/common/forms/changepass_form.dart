import 'package:detect_fakes/controllers/account/changepass_controller.dart';
import 'package:detect_fakes/utils/others/validation_utils.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class ChangePassForm extends StatelessWidget {
  const ChangePassForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePassController());
    return Form(
      key: controller.changePassFormKey,
      child: Column(
        children: [
          Obx(
            () => TextFormField(
              obscureText: controller.hideNewPassword.value,
              controller: controller.newPasswordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Iconsax.password_check,
                ),
                labelText: AppTexts.newPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.hideNewPassword.value =
                        !controller.hideNewPassword.value;
                  },
                  icon: Icon(
                    controller.hideNewPassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
              validator: (value) => ValidationUtils.validatePassword(
                AppTexts.newPassword,
                value,
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwInputFields,
          ),
          Obx(
            () => TextFormField(
              obscureText: controller.hideConfPassword.value,
              controller: controller.confPasswordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Iconsax.password_check,
                ),
                labelText: AppTexts.confPassword,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.hideConfPassword.value =
                        !controller.hideConfPassword.value;
                  },
                  icon: Icon(
                    controller.hideConfPassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
              validator: (value) {
                String? error = ValidationUtils.validatePassword(
                  AppTexts.confPassword,
                  value,
                );
                error ??= ValidationUtils.validateMatchingPasswords(
                  controller.newPasswordController.text,
                  value,
                );
                return error;
              },
            ),
          ),
          const SizedBox(
            height: AppSizes.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.reAuthenticate(),
              child: const Text(
                AppTexts.changePassword,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
