import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/core/utils/validators.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';
import 'package:school_van_fee_tracker/src/providers/school_provider.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_text_field.dart';
import 'package:school_van_fee_tracker/src/widgets/k_filled_button.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final schoolNameTextCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late SchoolProvider schoolProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schoolProvider = context.read<SchoolProvider>();
      schoolProvider.getSchools();
    });
    super.initState();
  }

  void addSchools() {
    if (formKey.currentState!.validate()) {
      schoolProvider.addSchool(schoolNameTextCtlr.text);
      schoolNameTextCtlr.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Column(
        children: [
          buildAppbar(context),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
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
                    child: Icon(Icons.add, size: 20, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),

          Consumer<SchoolProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.gray,
                      strokeWidth: 1.5,
                    ),
                  ),
                );
              }

              if (value.schools.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No schools found',
                      style: TextStyle(color: AppColors.gray),
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: value.schools.length,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => separator,
                  itemBuilder: (context, index) {
                    final school = value.schools[index];
                    return buildSchoolCard(index, school);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Padding buildSchoolCard(int index, SchoolModel school) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
      child: Row(
        children: [
          SizedBox(width: 40, child: Center(child: Text('${index + 1}.'))),
          Expanded(child: Text(school.name)),
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                KTextField(
                  label: 'Add New School',
                  hintText: 'Enter school name',
                  controller: schoolNameTextCtlr,
                  validator: Validator.required,
                ),
                vSpace20,
                KFilledButton(text: 'Done', onPressed: addSchools),
                vSpace12,
              ],
            ),
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
