import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';
import 'package:school_van_fee_tracker/src/providers/school_provider.dart';
import 'package:school_van_fee_tracker/src/providers/student_provider.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_drop_down_field.dart';
import 'package:school_van_fee_tracker/src/widgets/k_filled_button.dart';

class FilterStudentsBtmSheet extends StatefulWidget {
  const FilterStudentsBtmSheet({super.key});

  @override
  State<FilterStudentsBtmSheet> createState() => _FilterStudentsBtmSheetState();
}

class _FilterStudentsBtmSheetState extends State<FilterStudentsBtmSheet> {
  final schoolCtlr = TextEditingController();
  late StudentProvider studentProvider;

  SchoolModel? selectedSchool;
  String status = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider = context.read<StudentProvider>();
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!studentProvider.isFiltered) {
        studentProvider.addFilter(status: 'none', school: 'none');
      }
    });
    super.dispose();
  }

  void onFilterPressed() {
    studentProvider.getStudents(
      onInitial: true,
      filters: studentProvider.studentFilters,
    );
    Navigator.pop(context);
  }

  void onClearAllPressed() {
    if (studentProvider.studentFilters.isNotEmpty &&
        studentProvider.isFiltered) {
      studentProvider.addFilter(status: 'none', school: 'none');
      studentProvider.getStudents(onInitial: true);
      Navigator.pop(context);
    } else {
      studentProvider.addFilter(status: 'none', school: 'none');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Consumer2<StudentProvider, SchoolProvider>(
        builder: (context, value1, value2, child) {
          final school = value1.studentFilters['school'].toString();
          final selectedSchoolIndex = value2.schools.indexWhere(
            (e) => e.id == school,
          );

          if (selectedSchoolIndex != -1) {
            selectedSchool = value2.schools[selectedSchoolIndex];
          } else {
            selectedSchool = null;
          }
          status = value1.studentFilters['status'] ?? '';

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status'),
              vSpace8,
              Row(
                children: [
                  buildStatusBtn('Paid'),
                  hSpace12,
                  buildStatusBtn('Due'),
                ],
              ),
              vSpace16,
              Selector<SchoolProvider, List<SchoolModel>>(
                selector: (context, value) => value.schools,
                builder: (context, value, child) {
                  return KDropDownField(
                    enableSearch: true,
                    label: 'School Name',
                    controller: schoolCtlr,
                    hintText: 'Select School',
                    list: value.map((e) => e.name).toList(),
                    onSelected: (name) {
                      schoolCtlr.clear();
                      final school = value.firstWhere((s) => s.name == name);
                      studentProvider.addFilter(school: school.id);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  );
                },
              ),
              vSpace16,

              if (selectedSchool != null) buildSchoolBtn(selectedSchool!),
              if (selectedSchool != null) vSpace4,
              Row(
                children: [
                  Expanded(
                    child: KFilledButton(
                      text: 'Clear All',
                      onPressed: onClearAllPressed,
                      fgColor: AppColors.black,
                      bgColor: AppColors.lightWhite,
                      border: true,
                    ),
                  ),
                  hSpace12,
                  Selector<SchoolProvider, bool>(
                    selector: (context, value) => value.isBtnLoading,
                    builder: (context, value, child) {
                      return Expanded(
                        child: KFilledButton(
                          text: 'Filter',
                          isLoading: value,
                          onPressed: onFilterPressed,
                        ),
                      );
                    },
                  ),
                ],
              ),
              vSpace12,
            ],
          );
        },
      ),
    );
  }

  GestureDetector buildStatusBtn(String text) {
    return GestureDetector(
      onTap: () {
        if (status == text.toLowerCase()) {
          studentProvider.addFilter(status: 'none');
        } else {
          studentProvider.addFilter(status: text.toLowerCase());
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: status == text.toLowerCase()
              ? AppColors.blue
              : AppColors.black.withValues(alpha: 0.05),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: status == text.toLowerCase() ? AppColors.white : null,
          ),
        ),
      ),
    );
  }

  Container buildSchoolBtn(SchoolModel school) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
      padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(school.name, style: Theme.of(context).textTheme.bodyMedium),
          hSpace8,
          GestureDetector(
            onTap: () => studentProvider.addFilter(school: 'none'),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray,
              ),
              child: Iconify(AppIcons.close, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
