import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';

class KFilledButton extends StatelessWidget {
  const KFilledButton({
    super.key,
    this.onPressed,
    required this.text,
    this.bgColor = AppColors.blue,
    this.fgColor = AppColors.white,
    this.border = false,
    this.isLoading = false,
  });

  final String text;
  final bool isLoading;
  final Color bgColor;
  final Color fgColor;
  final bool border;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: border
                ? BorderSide(color: AppColors.black.withValues(alpha: 0.2))
                : BorderSide.none,
          ),
          backgroundColor: bgColor,
        ),
        child: isLoading
            ? SizedBox(
                width: 48 / 3,
                height: 48 / 3,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.white,
                ),
              )
            : Text(text, style: TextStyle(color: fgColor)),
      ),
    );
  }
}
