import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/widgets/k_filled_button.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    this.title = '',
    this.subTitle = '',
    this.icon = '',
    this.onPressed,
    this.actionBtnText,
    this.disableCancel = false,
    this.isLoading = false,
    this.onCancelPressed,
  });

  final String title;
  final String subTitle;
  final String icon;
  final bool isLoading;
  final bool disableCancel;
  final String? actionBtnText;
  final void Function()? onPressed;
  final void Function()? onCancelPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.white.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                Container(
                  width: 32,
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.blue),
                  ),
                  child: Text(
                    icon,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: AppColors.blue),
                  ),
                ),
              ],
            ),
            vSpace4,
            Text(
              subTitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.gray),
            ),
            vSpace12,
            Row(
              children: [
                Expanded(
                  child: KFilledButton(
                    text: 'Cancel',
                    fgColor: AppColors.black,
                    bgColor: AppColors.lightWhite,
                    onPressed: () {
                      if (onCancelPressed != null) onCancelPressed!();
                      Navigator.pop(context);
                    },
                  ),
                ),
                hSpace12,
                Expanded(
                  child: KFilledButton(
                    text: 'Confirm',
                    isLoading: isLoading,
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
