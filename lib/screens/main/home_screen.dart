import 'package:detect_fakes/controllers/appdata/profilepic_controller.dart';
import 'package:detect_fakes/controllers/appdata/user_controller.dart';
import 'package:detect_fakes/common/drawer/side_drawer.dart';
import 'package:detect_fakes/common/home/homeimagesection.dart';
import 'package:detect_fakes/common/home/homevideosection.dart';
import 'package:detect_fakes/common/others/custom_appbar.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> isSelected = [true, false];

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  void initializeControllers() {
    if (!Get.isRegistered<UserController>()) {
      Get.put(UserController(), permanent: true);
    }

    if (!Get.isRegistered<ProfilePicController>()) {
      Get.put(ProfilePicController(), permanent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.darkAppName,
              width: Get.width * 0.8,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Center(
              child: ToggleButtons(
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(
                    () {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                    },
                  );
                },
                borderRadius: BorderRadius.circular(AppSizes.md),
                fillColor: AppColors.primary,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Scan Image',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Scan Video',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Expanded(
              child: SingleChildScrollView(
                child: isSelected[0]
                    ? const HomeImageSection()
                    : const HomeVideoSection(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
