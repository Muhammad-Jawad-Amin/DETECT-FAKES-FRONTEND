import 'package:detect_fakes/controllers/account/login_controller.dart';
import 'package:detect_fakes/screens/account/forgetpassword_screen.dart';
import 'package:detect_fakes/screens/account/signup_screen.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:detect_fakes/utils/others/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final controller = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.logInFormKey,
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
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value =
                            !controller.rememberMe.value;
                      },
                    ),
                  ),
                  const Text(AppTexts.rememberMe),
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.to(
                    () => const ForgetPasswordScreen(
                      changePassword: false,
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
              onPressed: () {
                controller.logIn();
              },
              child: const Text(
                AppTexts.signIn,
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.md,
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Get.off(() => const SignupScreen());
              },
              child: const Text(
                AppTexts.createAccount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
