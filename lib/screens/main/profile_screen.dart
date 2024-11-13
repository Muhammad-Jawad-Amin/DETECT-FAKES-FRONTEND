import 'package:detect_fakes/common/others/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:detect_fakes/controllers/appdata/user_controller.dart';
import 'package:detect_fakes/common/drawer/side_drawer.dart';
import 'package:detect_fakes/screens/others/imageviewer_screen.dart';
import 'package:detect_fakes/common/others/profileinfo_tile.dart';
import 'package:detect_fakes/controllers/appdata/profilepic_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const Color themeColor = AppColors.primary;
    final userController = Get.find<UserController>();
    final profilePicController = Get.find<ProfilePicController>();

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (profilePicController
                      .profilePicModel.value.currentImageUrl.isNotEmpty) {
                    Get.to(
                      () => ImageViewerScreen(
                        imageUrl: profilePicController
                            .profilePicModel.value.currentImageUrl,
                      ),
                    );
                  } else {
                    Get.snackbar("Image", "No profile picture to view.");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: themeColor,
                      width: 4.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: Get.height * 0.1,
                    backgroundImage: profilePicController
                            .profilePicModel.value.currentImageUrl.isNotEmpty
                        ? NetworkImage(profilePicController.profilePicModel
                            .value.currentImageUrl) as ImageProvider
                        : const AssetImage(AppImages.guest),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              Text(
                "Profile Information",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Column(
                children: [
                  ProfileInfoTile(
                    label: AppTexts.firstName,
                    value: userController.user.value.firstName,
                    tileIcon: const Icon(
                      Iconsax.user,
                      color: themeColor,
                    ),
                  ),
                  ProfileInfoTile(
                    label: AppTexts.lastName,
                    value: userController.user.value.lastName,
                    tileIcon: const Icon(
                      Iconsax.user,
                      color: themeColor,
                    ),
                  ),
                  ProfileInfoTile(
                    label: AppTexts.dateOfBirth,
                    value: userController.user.value.dateOfBirth,
                    tileIcon: const Icon(
                      Iconsax.calendar,
                      color: themeColor,
                    ),
                  ),
                  ProfileInfoTile(
                    label: AppTexts.email,
                    value: userController.user.value.email,
                    tileIcon: const Icon(
                      Iconsax.direct,
                      color: themeColor,
                    ),
                  ),
                  ProfileInfoTile(
                    label: AppTexts.gender,
                    value: userController.user.value.gender,
                    tileIcon: Icon(
                      getGenderIcon(userController.user.value.gender),
                      color: themeColor,
                    ),
                  ),
                  ProfileInfoTile(
                    label: AppTexts.country,
                    value: userController.user.value.country,
                    tileIcon: const Icon(
                      Iconsax.global,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData getGenderIcon(String gender) {
    if (gender == "Male") {
      return Icons.male;
    } else if (gender == "Female") {
      return Icons.female;
    } else {
      return Icons.block;
    }
  }
}
