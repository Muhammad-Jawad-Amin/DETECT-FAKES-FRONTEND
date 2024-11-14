import 'package:detect_fakes/controllers/detection/detectimage_controller.dart';
import 'package:detect_fakes/services/mediapicker_service.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class HomeImageSection extends StatefulWidget {
  const HomeImageSection({super.key});

  @override
  State<HomeImageSection> createState() => _HomeImageSectionState();
}

class _HomeImageSectionState extends State<HomeImageSection> {
  File? selectedImage;
  static const Color themeColor = AppColors.primary;
  final MediaPickerService imagePicker = MediaPickerService();
  final detectImageController = Get.put(DetectImageController());

  @override
  void initState() {
    clearImage();
    super.initState();
  }

  Future<void> pickImage() async {
    final pickedImage = await imagePicker.pickImageFromGallery();
    if (pickedImage != null) {
      selectedImage = pickedImage;
      setState(() {});
    }
  }

  void clearImage() {
    selectedImage = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedImage != null ? themeColor : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: selectedImage != null
                ? Image.file(selectedImage!)
                : Container(
                    height: Get.height * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: themeColor),
                      borderRadius: BorderRadius.circular(AppSizes.md),
                    ),
                    child: Center(
                      child: Text(
                        'No Image Selected',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: pickImage,
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
        const SizedBox(height: AppSizes.md),
        Divider(
          color: Get.isDarkMode ? AppColors.darkGrey : AppColors.grey,
          thickness: 0.5,
        ),
        const SizedBox(height: AppSizes.md),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (selectedImage != null) {
                detectImageController.detectImage(selectedImage!);
              } else {
                Get.snackbar(
                  "Image",
                  "Please select an image first for scanning.",
                );
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.change_circle),
                SizedBox(width: AppSizes.sm),
                Text('Start Scanning'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
