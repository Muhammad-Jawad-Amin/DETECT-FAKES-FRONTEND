import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';
import 'package:detect_fakes/controllers/appdata/profilepic_controller.dart';
import 'package:detect_fakes/controllers/appdata/user_controller.dart';
import 'package:detect_fakes/screens/main/profile_screen.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late final bool isGoogleUser, isAnonymousUser;
  final fireAuthController = Get.find<FireAuthController>();

  late UserController userController;
  late ProfilePicController profilePicController;

  @override
  void initState() {
    super.initState();
    isGoogleUser = fireAuthController.isGoogleUser();
    isAnonymousUser = fireAuthController.isAnonymousUser();
    userController = Get.find<UserController>();
    profilePicController = Get.find<ProfilePicController>();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          size: AppSizes.iconXg,
          color: AppColors.primary,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        Obx(() {
          if (profilePicController
              .profilePicModel.value.currentImageUrl.isNotEmpty) {
            return IconButton(
              onPressed: () => onProfileTap(),
              icon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.lg),
                  border: Border.all(color: AppColors.primary),
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profilePicController
                      .profilePicModel.value.currentImageUrl),
                ),
              ),
            );
          } else {
            return IconButton(
              onPressed: () => onProfileTap(),
              icon: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.md),
                  border: Border.all(color: AppColors.primary),
                ),
                child: const CircleAvatar(
                  backgroundImage: AssetImage(AppImages.guest),
                ),
              ),
            );
          }
        }),
        const SizedBox(width: AppSizes.sm),
      ],
    );
  }

  void onProfileTap() {
    if (!isGoogleUser && !isAnonymousUser) {
      userController.loadUserData();
      Get.off(() => const ProfileScreen());
    }
  }
}
