import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';

class KDropDownField extends StatefulWidget {
  const KDropDownField({
    super.key,
    this.onSelected,
    required this.label,
    this.hintText,
    this.initialSelection,
    required this.list,
    this.enableFilter = true,
    this.controller,
    this.enableValidator = true,
    this.padding,
  });

  final void Function(String?)? onSelected;
  final String label;
  final String? hintText;
  final String? initialSelection;
  final List<String> list;
  final bool enableFilter;
  final TextEditingController? controller;
  final bool enableValidator;
  final double? padding;

  @override
  State<KDropDownField> createState() => _KDropDownFieldState();
}

class _KDropDownFieldState extends State<KDropDownField> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.enableValidator
          ? (val) {
              log('Value: ${widget.controller?.text}');
              if (widget.controller?.text.isEmpty ?? false) {
                return 'Required Field';
              }
              return null;
            }
          : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (fieldState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label.isNotEmpty) ...[Text(widget.label), vSpace8],

            DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              controller: widget.controller,
              enableSearch: false,
              hintText: widget.hintText,
              initialSelection: widget.initialSelection,
              requestFocusOnTap: false,
              enableFilter: widget.enableFilter,
              textStyle: Theme.of(context).textTheme.labelLarge,
              onSelected: widget.onSelected,
              menuStyle: MenuStyle(
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).scaffoldBackgroundColor,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: AppColors.black.withValues(alpha: 0.2),
                    ),
                  ),
                ),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
              ),
              searchCallback: (entries, query) {
                final String searchText =
                    widget.controller?.value.text.toLowerCase() ?? '';
                if (searchText.isEmpty) {
                  return null;
                }
                final int index = entries.indexWhere(
                  (DropdownMenuEntry<String> entry) =>
                      entry.label.toLowerCase().contains(searchText),
                );
                return index != -1 ? index : null;
              },
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: EdgeInsets.all(widget.padding ?? 15),
                constraints: const BoxConstraints(minHeight: 50, maxHeight: 50),
                hintStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.gray),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: AppColors.black.withValues(alpha: 0.2),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: AppColors.black.withValues(alpha: 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: AppColors.red.withValues(alpha: 0.6),
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: AppColors.red),
                ),
              ),
              menuHeight: 160,
              dropdownMenuEntries: widget.list
                  .map(
                    (e) => DropdownMenuEntry(
                      value: e,
                      label: e,
                      labelWidget: Text(
                        e,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.black.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
