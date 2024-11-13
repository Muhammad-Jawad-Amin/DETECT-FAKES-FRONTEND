import 'package:detect_fakes/models/image_model.dart';
import 'package:detect_fakes/screens/others/imageviewer_screen.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class ImageResultScreen extends StatefulWidget {
  final ImageModel imageData;
  final File? detectedImage;
  final String? imageUrl;

  const ImageResultScreen({
    super.key,
    required this.imageData,
    this.detectedImage,
    this.imageUrl,
  });

  @override
  State<ImageResultScreen> createState() => _ImageResultScreenState();
}

class _ImageResultScreenState extends State<ImageResultScreen> {
  static const Color themeColor = AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              CupertinoIcons.clear,
              size: AppSizes.iconXg,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Text(
                'Image Detection Result',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              GestureDetector(
                onTap: () {
                  if (widget.detectedImage != null) {
                    Get.to(
                      () => ImageViewerScreen(
                        imageFile: widget.detectedImage,
                      ),
                    );
                  } else if (widget.imageUrl != null) {
                    Get.to(
                      () => ImageViewerScreen(
                        imageUrl: widget.imageUrl,
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: themeColor,
                      width: 2.0,
                    ),
                  ),
                  child: widget.detectedImage != null
                      ? Image.file(widget.detectedImage!)
                      : Image.network(widget.imageUrl!),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Confidence Levels',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: AppSizes.md),
                      buildProgressBar(
                        label: 'Real',
                        value: widget.imageData.confidenceReal,
                        color: Colors.green,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      buildProgressBar(
                        label: 'Fake',
                        value: widget.imageData.confidenceFake,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.defaultSpace),
                  child: Column(
                    children: [
                      Text('Detection Details',
                          style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: AppSizes.md),
                      buildDetailRow(
                        'Processing Time',
                        '${widget.imageData.processingTime} sec',
                      ),
                      buildDetailRow(
                        'Image Size',
                        '${widget.imageData.imageSize} MB',
                      ),
                      buildDetailRow(
                        'Detection Date',
                        widget.imageData.detectionDateTime,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.sm,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.imageData.predictedLabel == 'REAL'
                        ? Colors.green
                        : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.sm),
                ),
                child: Text(
                  widget.imageData.predictedLabel,
                  style: TextStyle(
                    fontSize: 22,
                    color: widget.imageData.predictedLabel == 'REAL'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgressBar({
    required String label,
    required double value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        LinearProgressIndicator(
          value: value / 100,
          color: color,
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(height: AppSizes.xs),
        Center(
          child: Text(
            '$value %',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
