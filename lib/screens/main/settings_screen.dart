import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:detect_fakes/common/drawer/side_drawer.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/common/others/custom_appbar.dart';
import 'package:detect_fakes/screens/account/reauth_screen.dart';
import 'package:detect_fakes/utils/others/apphelper_functions.dart';
import 'package:detect_fakes/screens/account/changeprofilepic_screen.dart';
import 'package:detect_fakes/controllers/firebase/fireauth_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final fireAuthController = Get.find<FireAuthController>();

  late String selectedOption;
  late bool isGoogleUser, isAnonymousUser;
  final deviceStorage = GetStorage();
  static const themeColor = AppColors.primary;
  final redColor = AppHelperFunctions.getColor("Red");
  List<bool> isSelected = [false, false, false];
  List<String> selectionOptions = ["Light", "System", "Dark"];

  @override
  void initState() {
    super.initState();
    isGoogleUser = fireAuthController.isGoogleUser();
    isAnonymousUser = fireAuthController.isAnonymousUser();
    selectedOption = deviceStorage.read("AppTheme");
    updateToggleState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Iconsax.setting,
                color: themeColor,
                size: Get.height * 0.1,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Text(
                "App Settings",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              if (!isAnonymousUser && !isGoogleUser)
                Container(
                  padding: const EdgeInsets.all(AppSizes.sm),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: themeColor,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.md),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSizes.lg),
                        child: Text(
                          'Account Settings',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: themeColor,
                          ),
                          trailing: const Icon(
                            Iconsax.arrow_right,
                            color: themeColor,
                          ),
                          title: Text(
                            'Change Profile Picture',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onTap: () {
                            Get.to(() => const ChangeProfilePicScreen());
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.lock,
                            color: themeColor,
                          ),
                          trailing: const Icon(
                            Iconsax.arrow_right,
                            color: themeColor,
                          ),
                          title: Text(
                            'Change Password',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          onTap: () {
                            Get.to(() => const ReauthScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: themeColor,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.md),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSizes.lg),
                        child: Text(
                          'Theme Settings',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.md,
                          ),
                          child: ToggleButtons(
                            isSelected: isSelected,
                            onPressed: onToggleButtonPressed,
                            fillColor: themeColor,
                            borderRadius: BorderRadius.circular(AppSizes.md),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.iconMd,
                                ),
                                child: Text(
                                  'Light',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.iconMd,
                                ),
                                child: Text(
                                  'System',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.iconMd,
                                ),
                                child: Text(
                                  'Dark',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBtwSections),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.imageThumbSize),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: redColor!,
                    ),
                  ),
                  onPressed: () => fireAuthController.signOut(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.logout,
                        color: redColor,
                      ),
                      const SizedBox(width: AppSizes.md),
                      Text(
                        "Log Out",
                        style: TextStyle(
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onToggleButtonPressed(int index) {
    setState(() {
      isSelected = [false, false, false];
      isSelected[index] = true;

      switch (index) {
        case 0:
          selectedOption = selectionOptions[index];
          Get.changeThemeMode(ThemeMode.light);
          break;
        case 1:
          selectedOption = selectionOptions[index];
          Get.changeThemeMode(ThemeMode.system);
          break;
        case 2:
          selectedOption = selectionOptions[index];
          Get.changeThemeMode(ThemeMode.dark);
          break;
      }
      saveSelectedOption(selectedOption);
    });
  }

  void updateToggleState() {
    setState(() {
      isSelected = [
        selectedOption == selectionOptions[0],
        selectedOption == selectionOptions[1],
        selectedOption == selectionOptions[2],
      ];
    });
  }

  Future<void> saveSelectedOption(String option) async {
    deviceStorage.write("AppTheme", option);
  }
}
