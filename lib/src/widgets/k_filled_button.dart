import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';

class KFilledButton extends StatelessWidget {
  const KFilledButton({
    super.key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  final String text;
  final bool isLoading;
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
          ),
          backgroundColor: AppColors.blue,
        ),
        child: isLoading
            ? CircularProgressIndicator(strokeWidth: 1.5)
            : Text(text),
      ),
    );
  }
}
