import 'package:detect_fakes/common/others/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:detect_fakes/common/drawer/side_drawer.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/common/faqs/general_faqs.dart';
import 'package:detect_fakes/common/faqs/technical_faqs.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    const Color themeColor = AppColors.primary;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Iconsax.message_question,
              color: themeColor,
              size: Get.height * 0.1,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Text(
              "Frequently Asked Questions",
              style: Theme.of(context).textTheme.headlineMedium,
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
                fillColor: themeColor,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'General Questions',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Technical Questions',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Expanded(
              child: SingleChildScrollView(
                child:
                    isSelected[0] ? const GeneralFaqs() : const TechnicalFaqs(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
