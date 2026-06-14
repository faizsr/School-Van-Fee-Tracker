import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_drop_down_field.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_text_field.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class AddEditStudentScreen extends StatelessWidget {
  const AddEditStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Column(
        children: [
          buildAppbar(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                KTextField(label: 'Full Name', hintText: 'Enter here'),
                vSpace16,
                KTextField(label: 'Phone Number', hintText: 'Eg: 9876543210'),
                vSpace16,
                KDropDownField(
                  label: 'School Name',
                  hintText: 'Select School',
                  list: ['St Julianas', 'St Peters', 'St Sebastian'],
                ),
                vSpace16,
                KTextField(label: 'Place', hintText: 'Eg: Kochi'),
                vSpace16,
                KTextField(label: 'Monthly Fee', hintText: 'Eg: ₹1200'),
                vSpace16,
                KTextField(label: 'Advance Fee', hintText: 'Eg: ₹2000'),
                vSpace24,
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.blue,
                    ),
                    child: Text('Done'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildAppbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.black.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KIconButton(
            iconSize: 20,
            icon: AppIcons.back,
            onPressed: () => Navigator.pop(context),
          ),
          Text('Add New Student'),
          hSpace40,
        ],
      ),
    );
  }
}
