import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';
import 'package:school_van_fee_tracker/src/providers/school_provider.dart';
import 'package:school_van_fee_tracker/src/screens/settings/widgets/add_edit_school_btm_sheet.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SchoolProvider schoolProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schoolProvider = context.read<SchoolProvider>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Column(
        children: [
          buildAppbar(context),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'School List',
                  style: Theme.of(context).textTheme.titleSmall,
                ),

                GestureDetector(
                  onTap: () => buildAddEditSchoolBtmSheet(PageType.add),
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
                  itemCount: value.schools.length,
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
      padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
      child: Dismissible(
        key: ValueKey(school.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(color: AppColors.red),
          child: Text(
            'Slide to delete',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        onDismissed: (_) => schoolProvider.deleteSchool(school),
        child: Row(
          children: [
            SizedBox(width: 40, child: Center(child: Text('${index + 1}.'))),
            Expanded(child: Text(school.name)),
            IconButton(
              onPressed: () {
                buildAddEditSchoolBtmSheet(PageType.edit, school);
              },
              icon: Iconify(AppIcons.edit, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> buildAddEditSchoolBtmSheet(
    PageType type, [
    SchoolModel? school,
  ]) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: AddEditSchoolBtmSheet(type: type, school: school),
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
