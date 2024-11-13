import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';

class AboutContactUs extends StatelessWidget {
  const AboutContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSizes.xl),
        buildContactUs(context),
        const SizedBox(height: AppSizes.xl),
        buildCopyright(),
      ],
    );
  }

  Widget buildContactUs(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: AppSizes.lg,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        buildContactItem(
          context,
          Iconsax.sms,
          'mianjawad938@gmail.com',
          'mailto:mianjawad938@gmail.com',
        ),
        const SizedBox(height: 8),
        buildContactItem(
          context,
          Iconsax.call,
          'Phone: 0303 2688998',
          'tel:+923032688998',
        ),
      ],
    );
  }

  Widget buildContactItem(
    BuildContext context,
    IconData icon,
    String label,
    String urlString,
  ) {
    final Uri url = Uri.parse(urlString);
    return InkWell(
      onTap: () => launchUrlCallback(context, url),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppSizes.fontSizeMd,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCopyright() {
    return const Text(
      '© 2024 Detect Fakes. All rights reserved.',
      style: TextStyle(
        color: AppColors.primary,
        fontSize: AppSizes.fontSizeSm,
      ),
      textAlign: TextAlign.center,
    );
  }

  Future<void> launchUrlCallback(BuildContext context, Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
          enableDomStorage: true,
        ),
      );
    } else {
      Get.snackbar("Error", "Could not launch URL.");
    }
  }
}
