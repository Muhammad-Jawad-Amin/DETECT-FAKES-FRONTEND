import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final Icon screenIcon;
  final String screenTitle;
  final VoidCallback callBack;

  const DrawerTile({
    super.key,
    required this.screenIcon,
    required this.screenTitle,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 0),
      ),
      onPressed: callBack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          screenIcon,
          const SizedBox(
            width: AppSizes.sm,
          ),
          Text(
            screenTitle,
          ),
        ],
      ),
    );
  }
}
