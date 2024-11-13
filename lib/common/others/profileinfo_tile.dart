import 'package:detect_fakes/utils/constants/app_colors.dart';
import 'package:detect_fakes/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final Icon tileIcon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.tileIcon,
  });

  @override
  Widget build(BuildContext context) {
    const Color themeColor = AppColors.primary;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          border: Border.all(color: themeColor),
          borderRadius: BorderRadius.circular(AppSizes.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                tileIcon,
                const SizedBox(
                  width: AppSizes.md,
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
