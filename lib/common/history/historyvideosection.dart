import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:detect_fakes/controllers/history/historyvideo_controller.dart';
import 'package:detect_fakes/screens/main/videoresult_screen.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryVideoSection extends StatelessWidget {
  const HistoryVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryVideoController controller =
        Get.find<HistoryVideoController>();

    return Obx(
      () {
        if (controller.videos.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.2,
                ),
                Text(
                  'No videos in the history yet.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return MasonryGridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: controller.videos.length,
          itemBuilder: (context, index) {
            final video = controller.videos[index];
            return GestureDetector(
              onTap: () {
                Get.to(
                  () => VideoResultScreen(
                    videoData: video,
                    videoUrl: video.videoUrl,
                  ),
                );
              },
              child: Card(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        video.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            height: Get.height * 0.2,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.download,
                              color: AppColors.primary,
                              size: AppSizes.iconMd,
                            ),
                            onPressed: () async {
                              await controller.downloadVideo(video.videoUrl);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: AppSizes.iconMd,
                            ),
                            onPressed: () =>
                                controller.deleteVideo(video.videoId),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
