import 'package:detect_fakes/screens/others/imageviewer_screen.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AboutOurTeam extends StatelessWidget {
  const AboutOurTeam({super.key});

  @override
  Widget build(BuildContext context) {
    const themeColor = AppColors.primary;

    return Container(
      width: Get.height,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        border: Border.all(color: themeColor),
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      child: Column(
        children: [
          const Text(
            'OUR TEAM',
            style: TextStyle(
              fontSize: AppSizes.lg,
              color: themeColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.md),
          buildTeamMembers(context),
        ],
      ),
    );
  }

  Widget buildTeamMembers(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            buildTeamMember(
              'Muhammad Jawad Amin',
              'AI Developer',
              'assets/aboutusimages/jawad_bhai.jpg',
            ),
            const SizedBox(height: AppSizes.lg),
            buildTeamMember(
              'Huzaifa Bin Yousaf',
              'UI/UX Designer',
              'assets/aboutusimages/huzaifa_bhai.jpg',
            ),
            const SizedBox(height: AppSizes.lg),
            buildTeamMember(
              'Muhammad Ibrahim',
              'Backend Developer',
              'assets/aboutusimages/ibrahim_bhai.jpg',
            ),
          ],
        );
      },
    );
  }

  Widget buildTeamMember(String name, String role, String imagePath) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            ImageViewerScreen(
              assetImage: imagePath,
            ),
          ),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: AppColors.primary,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontSize: AppSizes.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          role,
          style: const TextStyle(
            fontSize: AppSizes.fontSizeMd,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
