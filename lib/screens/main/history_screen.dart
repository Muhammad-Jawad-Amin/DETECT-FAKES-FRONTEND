import 'package:detect_fakes/common/history/historyimagesection.dart';
import 'package:detect_fakes/common/history/historyvideosection.dart';
import 'package:detect_fakes/common/others/custom_appbar.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/common/drawer/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<bool> isSelected = [true, false];

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
            Icon(
              Iconsax.timer,
              color: AppColors.primary,
              size: Get.height * 0.1,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Text(
              "Detection History",
              style: Theme.of(context).textTheme.headlineLarge,
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
                      'Image History',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Video History',
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
                    ? const HistoryImageSection()
                    : const HistoryVideoSection(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
