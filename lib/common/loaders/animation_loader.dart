import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AnimationLoader extends StatelessWidget {
  final String text;
  final String animation;
  final bool showAtion;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const AnimationLoader({
    super.key,
    required this.text,
    required this.animation,
    this.showAtion = false,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              animation,
              width: Get.width * 0.6,
            ),
            const SizedBox(
              height: AppSizes.defaultSpace,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: AppSizes.defaultSpace,
            ),
            showAtion
                ? SizedBox(
                    width: 250,
                    child: OutlinedButton(
                      onPressed: onActionPressed,
                      child: Text(
                        actionText!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
