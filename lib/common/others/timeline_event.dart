import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TimeLineEvent extends StatelessWidget {
  final String eventTitle;
  final String eventDescription;
  final String eventTime;
  final String eventVideoUrl;
  final IconData eventIcon;

  const TimeLineEvent({
    super.key,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventTime,
    required this.eventIcon,
    required this.eventVideoUrl,
  });

  @override
  Widget build(BuildContext context) {
    const themeColor = AppColors.primary;
    const whiteColor = AppColors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: AppSizes.md),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eventTime,
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeLg,
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                Text(
                  eventTitle,
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeLg,
                    color: themeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                Text(
                  eventDescription,
                  style: const TextStyle(
                    fontSize: AppSizes.fontSizeMd,
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                if (eventVideoUrl.isNotEmpty)
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: AppSizes.md,
                        ),
                      ),
                      onPressed: () async {
                        final videoUrl = Uri.parse(eventVideoUrl);
                        if (await canLaunchUrl(videoUrl)) {
                          await launchUrl(
                            videoUrl,
                            mode: LaunchMode.externalApplication,
                            webViewConfiguration: const WebViewConfiguration(
                              enableJavaScript: true,
                              enableDomStorage: true,
                            ),
                          );
                        } else {
                          throw 'Could not launch $eventVideoUrl';
                        }
                      },
                      child: const Text('Watch Video On Youtube'),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              width: 2,
              height: 20,
              color: themeColor,
            ),
            Container(
              padding: const EdgeInsets.all(AppSizes.sm),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: themeColor,
              ),
              child: Icon(
                eventIcon,
                color: whiteColor,
                size: AppSizes.iconMd,
              ),
            ),
            Container(
              width: 2,
              height: 20,
              color: themeColor,
            ),
          ],
        ),
      ],
    );
  }
}
