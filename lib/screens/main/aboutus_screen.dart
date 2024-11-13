import 'package:detect_fakes/common/about/about_contactus.dart';
import 'package:detect_fakes/common/about/about_ourteam.dart';
import 'package:detect_fakes/common/about/about_paragraphs.dart';
import 'package:detect_fakes/common/drawer/side_drawer.dart';
import 'package:detect_fakes/common/about/about_supervisor.dart';
import 'package:detect_fakes/common/others/custom_appbar.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool dark = Get.isDarkMode;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                height: Get.height * 0.2,
                image: AssetImage(
                  dark ? AppImages.darkAppNameLogo : AppImages.lightAppNameLogo,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text(
                "About Us",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              const AboutParagraphs(),
              const SizedBox(height: AppSizes.xl),
              const AboutOurTeam(),
              const SizedBox(height: AppSizes.xl),
              const AboutSupervisor(),
              const AboutContactUs(),
            ],
          ),
        ),
      ),
    );
  }
}
