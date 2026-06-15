import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/screens/home/widgets/filter_students_btm_sheet.dart';

class KSearchField extends StatelessWidget {
  const KSearchField({super.key, this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: TextFormField(
        onChanged: onChanged,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(2000),
          ),
          hintText: 'Search by name or phone no.',
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.black.withValues(alpha: 0.3),
          ),
          filled: true,
          fillColor: AppColors.lightWhite,
          prefixIconConstraints: BoxConstraints(),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
            child: Iconify(
              AppIcons.search,
              color: AppColors.black.withValues(alpha: 0.4),
            ),
          ),
          suffixIconConstraints: BoxConstraints(),
          suffixIcon: IconButton(
            icon: Iconify(AppIcons.filter),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (context) => FilterStudentsBtmSheet(),
              );
            },
          ),
        ),
      ),
    );
  }
}
