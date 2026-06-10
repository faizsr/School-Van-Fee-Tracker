import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_text_field.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'School List',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),

                    GestureDetector(
                      onTap: () => buildAddSchoolBtmSheet(context),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.blue,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                vSpace4,

                ListView.separated(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => separator,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Center(child: Text('${index + 1}.')),
                          ),
                          Expanded(child: Text('St Julianas Public School')),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildAddSchoolBtmSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KTextField(
                label: 'Add New School',
                hintText: 'Enter school name',
              ),
              vSpace20,
              SizedBox(
                height: 48,
                width: double.infinity,
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
              vSpace12,
            ],
          ),
        );
      },
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
          Text('Settings'),
          hSpace40,
        ],
      ),
    );
  }
}
