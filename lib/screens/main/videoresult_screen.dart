import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:detect_fakes/models/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class VideoResultScreen extends StatefulWidget {
  final VideoModel videoData;
  final File? detectedVideo;
  final String? videoUrl;

  const VideoResultScreen({
    super.key,
    required this.videoData,
    this.detectedVideo,
    this.videoUrl,
  });

  @override
  State<VideoResultScreen> createState() => _VideoResultScreenState();
}

class _VideoResultScreenState extends State<VideoResultScreen> {
  bool isMuted = false;
  bool isPlaying = false;
  VideoPlayerController? videoController;
  static const Color themeColor = AppColors.primary;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  void initializeVideoPlayer() {
    if (widget.detectedVideo != null) {
      videoController = VideoPlayerController.file(
        widget.detectedVideo!,
      )..initialize().then((_) {
          setState(() {
            videoController!.play();
            isPlaying = true;
          });
        });
    } else if (widget.videoUrl != null) {
      videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl!),
      )..initialize().then((_) {
          setState(() {
            videoController!.play();
            isPlaying = true;
          });
        }).catchError((error) {
          debugPrint('Error initializing video: $error');
        });
    }
  }

  void togglePlayPause() {
    if (videoController != null) {
      if (isPlaying) {
        videoController!.pause();
      } else {
        videoController!.play();
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    }
  }

  void toggleMute() {
    if (videoController != null) {
      if (isMuted) {
        videoController!.setVolume(1.0);
      } else {
        videoController!.setVolume(0.0);
      }
      setState(() {
        isMuted = !isMuted;
      });
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

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
                'Video Detection Result',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              videoController != null && videoController!.value.isInitialized
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeColor,
                          width: 2.0,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: videoController!.value.aspectRatio,
                        child: VideoPlayer(videoController!),
                      ),
                    )
                  : const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              buildPlayPauseMuteButtons(),
              const SizedBox(height: AppSizes.spaceBtwSections),
              buildDetailsCard(context),
              const SizedBox(height: AppSizes.lg),
              buildConfidenceSection(context),
              const SizedBox(height: AppSizes.lg),
              buildPredictionLabel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDetailsCard(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detection Details',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.md),
            buildDetailRow(
                'Processing Time', '${widget.videoData.processingTime} sec'),
            buildDetailRow('Video Size', '${widget.videoData.videoSize} MB'),
            buildDetailRow(
                'Processed Frames', '${widget.videoData.processedFrames}'),
            buildDetailRow('Total Frames', '${widget.videoData.totalFrames}'),
            buildDetailRow(
                'Video Duration', '${widget.videoData.videoDuration} sec'),
            buildDetailRow(
                'Detection Date', widget.videoData.detectionDateTime),
          ],
        ),
      ),
    );
  }

  Widget buildConfidenceSection(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confidence Levels',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.md),
            buildProgressBar(
              label: 'Real',
              value: widget.videoData.confidenceReal,
              color: Colors.green,
            ),
            const SizedBox(height: 10),
            buildProgressBar(
              label: 'Fake',
              value: widget.videoData.confidenceFake,
              color: Colors.red,
            ),
          ],
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
        Text(
          '$value %',
          style: Theme.of(context).textTheme.bodyLarge,
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

  Widget buildPredictionLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.videoData.predictedLabel == 'REAL'
              ? Colors.green
              : Colors.red,
        ),
        borderRadius: BorderRadius.circular(AppSizes.sm),
      ),
      child: Text(
        widget.videoData.predictedLabel,
        style: TextStyle(
          fontSize: 22,
          color: widget.videoData.predictedLabel == 'REAL'
              ? Colors.green
              : Colors.red,
        ),
      ),
    );
  }
}
