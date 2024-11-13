import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';

class AboutParagraphs extends StatelessWidget {
  const AboutParagraphs({super.key});

  @override
  Widget build(BuildContext context) {
    const themeColor = AppColors.primary;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: themeColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const Text(
            'DeepFake Videos & Images Detection App',
            style: TextStyle(
              fontSize: AppSizes.lg,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          buildParagraph(AppTexts.paragraph1, themeColor),
          const SizedBox(height: AppSizes.md),
          buildParagraph(AppTexts.paragraph2, themeColor),
          const SizedBox(height: AppSizes.md),
          buildParagraph(AppTexts.paragraph3, themeColor),
          const SizedBox(height: AppSizes.md),
          buildParagraph(AppTexts.paragraph4, themeColor),
          const SizedBox(height: AppSizes.md),
          buildParagraph(AppTexts.paragraph5, themeColor),
        ],
      ),
    );
  }

  Widget buildParagraph(String paragraphText, Color borderColor) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(AppSizes.md),
        ),
        child: Text(
          paragraphText,
          style: const TextStyle(
            fontSize: AppSizes.fontSizeMd,
          ),
        ),
      ),
    );
  }
}
