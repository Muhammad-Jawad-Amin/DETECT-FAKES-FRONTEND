import 'package:detect_fakes/common/drawer/side_drawer.dart';
import 'package:detect_fakes/common/others/custom_appbar.dart';
import 'package:detect_fakes/common/others/timeline_event.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const themeColor = AppColors.primary;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const SideDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.clock,
              color: themeColor,
              size: Get.height * 0.1,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Text(
              "DeepFakes Timeline",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections * 2),
            Expanded(
              child: ListView.builder(
                itemCount: AppTexts.eventsData.length,
                itemBuilder: (context, index) {
                  final event = AppTexts.eventsData[index];
                  return TimeLineEvent(
                    eventTitle: event['title']!,
                    eventDescription: event['description']!,
                    eventTime: event['date']!,
                    eventIcon: Icons.circle,
                    eventVideoUrl: event['videoUrl']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
