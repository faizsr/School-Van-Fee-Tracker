import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';

class KIconButton extends StatelessWidget {
  const KIconButton({
    super.key,
    required this.icon,
    this.iconSize = 24,
    this.iconColor = AppColors.black,
    this.onPressed,
    this.bgColor = AppColors.lightWhite,
  });

  final String icon;
  final double iconSize;
  final Color iconColor;
  final Color bgColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Iconify(icon, size: iconSize, color: iconColor),
      style: IconButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.all(12),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
