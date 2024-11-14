import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:detect_fakes/screens/main/faqs_screen.dart';
import 'package:detect_fakes/screens/main/history_screen.dart';
import 'package:detect_fakes/screens/main/home_screen.dart';
import 'package:detect_fakes/screens/main/settings_screen.dart';
import 'package:detect_fakes/screens/main/timeline_screen.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/screens/main/aboutus_screen.dart';
import 'package:detect_fakes/common/drawer/drawer_tile.dart';
import 'package:detect_fakes/screens/main/profile_screen.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final fireAuthController = Get.find<FireAuthController>();
    final isGoogleUser = fireAuthController.isGoogleUser();
    final isAnonymousUser = fireAuthController.isAnonymousUser();
    bool dark = Get.isDarkMode;

    return Drawer(
      width: Get.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    Center(
                      child: SizedBox(
                        height: Get.height * 0.14,
                        child: Image.asset(
                          dark
                              ? AppImages.darkAppNameLogo
                              : AppImages.lightAppNameLogo,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSizes.lg),
                child: Column(
                  children: [
                    DrawerTile(
                      callBack: () => Get.offAll(() => const HomeScreen()),
                      screenIcon: const Icon(Iconsax.home),
                      screenTitle: "Home",
                    ),
                    if (!isAnonymousUser && !isGoogleUser)
                      DrawerTile(
                        callBack: () => Get.to(() => const ProfileScreen()),
                        screenIcon: const Icon(Iconsax.personalcard),
                        screenTitle: "Profile",
                      ),
                    DrawerTile(
                      callBack: () => Get.to(() => const HistoryScreen()),
                      screenIcon: const Icon(Iconsax.timer),
                      screenTitle: "History",
                    ),
                    DrawerTile(
                      callBack: () => Get.to(() => const TimeLineScreen()),
                      screenIcon: const Icon(Iconsax.clock),
                      screenTitle: "Timeline",
                    ),
                    DrawerTile(
                      callBack: () => Get.to(() => const FaqsScreen()),
                      screenIcon: const Icon(Iconsax.message_question),
                      screenTitle: "FAQs",
                    ),
                    DrawerTile(
                      callBack: () => Get.to(() => const AboutUsScreen()),
                      screenIcon: const Icon(Iconsax.info_circle),
                      screenTitle: "About Us",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.lg),
            child: Column(
              children: [
                DrawerTile(
                  callBack: () => Get.to(() => const SettingsScreen()),
                  screenIcon: const Icon(Iconsax.setting),
                  screenTitle: "Settings",
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.clear),
                      SizedBox(
                        width: AppSizes.sm,
                      ),
                      Text("Close"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
