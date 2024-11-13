import 'package:detect_fakes/screens/others/imageviewer_screen.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AboutSupervisor extends StatelessWidget {
  const AboutSupervisor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      child: Column(
        children: [
          const Text(
            'PROJECT CORDINATOR',
            style: TextStyle(
              fontSize: AppSizes.lg,
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.md),
          buildSupervisor(),
        ],
      ),
    );
  }

  Widget buildSupervisor() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.to(
            const ImageViewerScreen(
              assetImage: "assets/aboutusimages/sir_ali_raza.jpg",
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
                'assets/aboutusimages/sir_ali_raza.jpg',
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Dr. Syed Ali Raza',
          style: TextStyle(
            fontSize: AppSizes.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'Project Supervisor',
          style: TextStyle(
            fontSize: AppSizes.fontSizeMd,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
