import 'package:detect_fakes/controllers/account/changeprofilepic_controller.dart';
import 'package:detect_fakes/controllers/appdata/profilepic_controller.dart';
import 'package:detect_fakes/screens/others/imageviewer_screen.dart';
import 'package:detect_fakes/services/mediapicker_service.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_images.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class ChangeProfilePicScreen extends StatefulWidget {
  const ChangeProfilePicScreen({super.key});

  @override
  State<ChangeProfilePicScreen> createState() => _ChangeProfilePicScreenState();
}

class _ChangeProfilePicScreenState extends State<ChangeProfilePicScreen> {
  File? imageFile;
  MediaPickerService imagePicker = MediaPickerService();
  final profilePicController = Get.find<ProfilePicController>();
  final changeProfilePicController = Get.put(ChangeProfilePicController());

  void clearImage() {
    if (imageFile != null) {
      setState(() {
        imageFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color themeColor = AppColors.primary;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.clear,
              size: AppSizes.iconXg,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              Text(
                'Select Profile Picture',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections * 2,
              ),
              GestureDetector(
                onTap: () {
                  if (imageFile != null) {
                    Get.to(
                      () => ImageViewerScreen(
                        imageFile: imageFile,
                      ),
                    );
                  }
                  Get.snackbar("Image", "No selected image to view.");
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
                    radius: Get.height * 0.15,
                    backgroundImage: imageFile != null
                        ? FileImage(imageFile!)
                        : profilePicController.profilePicModel.value
                                .currentImageUrl.isNotEmpty
                            ? NetworkImage(profilePicController
                                .profilePicModel.value.currentImageUrl)
                            : const AssetImage(AppImages.guest),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    imageFile = await imagePicker.pickImageFromGallery();
                    setState(() {});
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo),
                      SizedBox(width: AppSizes.sm),
                      Text('Pick Image From Gallery'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.md),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: clearImage,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.clear,
                        color: themeColor,
                      ),
                      SizedBox(width: AppSizes.sm),
                      Text('Clear Image'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      changeProfilePicController.uploadProfilePic(imageFile),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.change_circle),
                      SizedBox(width: AppSizes.sm),
                      Text('Change Profile Pic'),
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
}
