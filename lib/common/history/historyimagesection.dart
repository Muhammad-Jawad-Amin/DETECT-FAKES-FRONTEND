import 'package:detect_fakes/controllers/history/historyimage_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:detect_fakes/screens/main/imageresult_screen.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryImageSection extends StatelessWidget {
  const HistoryImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryImageController controller =
        Get.find<HistoryImageController>();

    return Obx(
      () {
        if (controller.images.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.2,
                ),
                Text(
                  'No images in the history yet.',
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
          itemCount: controller.images.length,
          itemBuilder: (context, index) {
            final image = controller.images[index];

            return GestureDetector(
              onTap: () {
                Get.to(
                  () => ImageResultScreen(
                    imageData: image,
                    imageUrl: image.imageUrl,
                  ),
                );
              },
              child: Card(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        image.imageUrl,
                        fit: BoxFit.contain,
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
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
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
                              await controller.downloadImage(image.imageUrl);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: AppSizes.iconMd,
                            ),
                            onPressed: () =>
                                controller.deleteImage(image.imageId),
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
