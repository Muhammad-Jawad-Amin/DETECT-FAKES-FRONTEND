import 'package:detect_fakes/controllers/detection/detectvideo_controller.dart';
import 'package:detect_fakes/services/mediapicker_service.dart';
import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class HomeVideoSection extends StatefulWidget {
  const HomeVideoSection({super.key});

  @override
  State<HomeVideoSection> createState() => _HomeVideoSectionState();
}

class _HomeVideoSectionState extends State<HomeVideoSection> {
  File? selectedVideo;
  bool isMuted = false;
  bool isPlaying = false;
  int selectedFrames = 30;
  VideoPlayerController? videoController;
  List<int> framesOptions = [30, 60, 90, 120, 150];
  static const Color themeColor = AppColors.primary;
  final MediaPickerService videoPicker = MediaPickerService();
  final detectVideoController = Get.put(DetectVideoController());

  Future<void> pickVideo() async {
    final pickedVideo = await videoPicker.pickVideoFromGallery();
    if (pickedVideo != null) {
      videoController = VideoPlayerController.file(pickedVideo)
        ..initialize().then((_) {
          selectedVideo = pickedVideo;
          setState(() {});
        });
    }
  }

  void togglePlayPause() {
    if (videoController != null && selectedVideo != null) {
      if (isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
      isPlaying = !isPlaying;
    }
    setState(() {});
  }

  void toggleMute() {
    if (videoController != null && selectedVideo != null) {
      if (isMuted) {
        videoController!.setVolume(1.0);
      } else {
        videoController!.setVolume(0.0);
      }
      isMuted = !isMuted;
    }
    setState(() {});
  }

  void clearVideo() {
    videoController?.dispose();
    selectedVideo = null;
    isPlaying = false;
    isMuted = false;
    setState(() {});
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedVideo != null ? themeColor : Colors.transparent,
                width: 2.0,
              ),
            ),
            child: selectedVideo != null && videoController != null
                ? AspectRatio(
                    aspectRatio: videoController!.value.aspectRatio,
                    child: VideoPlayer(videoController!),
                  )
                : Container(
                    height: Get.height * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: themeColor),
                      borderRadius: BorderRadius.circular(AppSizes.md),
                    ),
                    child: Center(
                      child: Text(
                        'No Video Selected',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          buildPlayPauseMuteButtons(),
          const SizedBox(height: AppSizes.spaceBtwSections),
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              border: Border.all(color: themeColor),
              borderRadius: BorderRadius.circular(AppSizes.md),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Number Of Frames To Scan",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppSizes.md,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: framesOptions.map((frames) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ChoiceChip(
                          selectedColor: themeColor,
                          label: Text(
                            '$frames',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          selected: selectedFrames == frames,
                          onSelected: (isSelected) {
                            selectedFrames = frames;
                            setState(() {});
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.spaceBtwSections),
          buildButtons(),
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: pickVideo,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo),
                SizedBox(width: AppSizes.sm),
                Text('Pick Video From Gallery'),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.md),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: clearVideo,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.clear,
                  color: themeColor,
                ),
                SizedBox(width: AppSizes.sm),
                Text('Clear Video'),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSizes.md),
        Divider(
          color: Get.isDarkMode ? AppColors.darkGrey : AppColors.grey,
          thickness: 0.5,
        ),
        const SizedBox(height: AppSizes.md),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (selectedVideo != null) {
                detectVideoController.detectVideo(
                  selectedVideo!,
                  selectedFrames,
                );
              } else {
                Get.snackbar(
                  "Video",
                  "Please select a video first for scanning.",
                );
              }
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.change_circle),
                SizedBox(width: AppSizes.sm),
                Text('Start Scanning'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPlayPauseMuteButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: togglePlayPause,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
            ),
          ),
          child: Row(children: [
            Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
            ),
            const SizedBox(width: AppSizes.sm),
            Text(isPlaying ? 'Pause' : 'Play'),
          ]),
        ),
        const SizedBox(width: AppSizes.lg),
        OutlinedButton(
          onPressed: toggleMute,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.md,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isMuted ? Icons.volume_off : Icons.volume_up,
              ),
              const SizedBox(width: AppSizes.sm),
              Text(isMuted ? 'Unmute' : 'Mute'),
            ],
          ),
        ),
      ],
    );
  }
}
