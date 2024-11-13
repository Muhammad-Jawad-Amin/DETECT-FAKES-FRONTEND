import 'package:detect_fakes/common/forms/login_form.dart';
import 'package:detect_fakes/common/others/page_divider.dart';
import 'package:detect_fakes/common/others/social_buttons.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = Get.isDarkMode;
    String appnamelogo;
    if (dark) {
      appnamelogo = AppImages.darkAppNameLogo;
    } else {
      appnamelogo = AppImages.lightAppNameLogo;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    height: Get.height * 0.3,
                    image: AssetImage(
                      appnamelogo,
                    ),
                  ),
                  Text(
                    AppTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    AppTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.md,
              ),
              const LoginForm(),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              PageDivider(
                dark: dark,
                dividerText: AppTexts.orSignUpSignInWith.capitalize!,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              const SocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
