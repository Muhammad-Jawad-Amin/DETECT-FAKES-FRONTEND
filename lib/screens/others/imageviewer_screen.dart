import 'dart:io';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';

class ImageViewerScreen extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final String? assetImage;

  const ImageViewerScreen({
    super.key,
    this.imageFile,
    this.imageUrl,
    this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              CupertinoIcons.clear,
              size: AppSizes.iconXg,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      body: Container(
        child: buildImage(),
      ),
    );
  }

  Widget buildImage() {
    if (imageFile != null) {
      return PhotoView(
        imageProvider: FileImage(imageFile!),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
      );
    } else if (imageUrl != null) {
      return PhotoView(
        imageProvider: NetworkImage(imageUrl!),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        loadingBuilder: (context, event) => Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
            value: event == null
                ? null
                : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Center(
          child: Text(
            'Failed to load image',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    } else if (assetImage != null) {
      return PhotoView(
        imageProvider: AssetImage(assetImage!),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2.0,
      );
    } else {
      return const Center(child: Text('No image to display.'));
    }
  }
}
