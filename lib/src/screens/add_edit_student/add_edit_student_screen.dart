import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/core/utils/validators.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';
import 'package:school_van_fee_tracker/src/models/student_model.dart';
import 'package:school_van_fee_tracker/src/providers/school_provider.dart';
import 'package:school_van_fee_tracker/src/providers/student_provider.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_drop_down_field.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_text_field.dart';
import 'package:school_van_fee_tracker/src/widgets/k_filled_button.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class AddEditStudentScreen extends StatefulWidget {
  const AddEditStudentScreen({super.key, required this.type, this.student});

  final PageType type;
  final StudentModel? student;

  @override
  State<AddEditStudentScreen> createState() => _AddEditStudentScreenState();
}

class _AddEditStudentScreenState extends State<AddEditStudentScreen> {
  late StudentProvider studentProvider;
  SchoolModel? school;

  final formKey = GlobalKey<FormState>();
  final nameCtlr = TextEditingController();
  final phoneCtlr = TextEditingController();
  final schoolCtlr = TextEditingController();
  final placeCtlr = TextEditingController();
  final monthlyFeeCtlr = TextEditingController();
  final advanceFeeCtlr = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider = context.read<StudentProvider>();
    });

    if (widget.type == PageType.edit) {
      school = widget.student!.school;
      nameCtlr.text = widget.student!.fullName;
      phoneCtlr.text = widget.student!.phone;
      schoolCtlr.text = widget.student!.school.name;
      placeCtlr.text = widget.student!.place;
      monthlyFeeCtlr.text = widget.student!.monthlyFee.toString();
      advanceFeeCtlr.text = widget.student!.advanceFee.toString();
    }
    super.initState();
  }

  void onAddPressed() async {
    if (formKey.currentState!.validate() && school != null) {
      final student = StudentModel(
        fullName: nameCtlr.text,
        phone: phoneCtlr.text,
        school: school!,
        place: placeCtlr.text,
        monthlyFee: int.tryParse(monthlyFeeCtlr.text) ?? 0,
        advanceFee: int.tryParse(advanceFeeCtlr.text) ?? 0,
      );

      log('Add Student Json: ${student.toJson()}');

      await studentProvider.addStudent(student);
      if (mounted) Navigator.pop(context);
    }
  }

  void onEditPressed() async {
    if (formKey.currentState!.validate() && school != null) {
      final student = widget.student!.copyWith(
        fullName: nameCtlr.text,
        phone: phoneCtlr.text,
        school: school!,
        place: placeCtlr.text,
        monthlyFee: int.tryParse(monthlyFeeCtlr.text) ?? 0,
        advanceFee: int.tryParse(advanceFeeCtlr.text) ?? 0,
      );

      log('Edit Student Json: ${student.toJson()}');

      await studentProvider.editStudent(student);
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Column(
        children: [
          buildAppbar(context),
          Expanded(
            child: Form(
              key: formKey,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  KTextField(
                    label: 'Full Name',
                    hintText: 'Enter here',
                    controller: nameCtlr,
                    validator: Validator.name,
                  ),
                  vSpace16,
                  KTextField(
                    label: 'Phone Number',
                    hintText: 'Eg: 9876543210',
                    controller: phoneCtlr,
                    validator: Validator.phone,
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
                        onSelected: (name) =>
                            school = value.firstWhere((s) => s.name == name),
                      );
                    },
                  ),
                  vSpace16,
                  KTextField(
                    label: 'Place',
                    hintText: 'Eg: Kochi',
                    controller: placeCtlr,
                    validator: Validator.required,
                  ),
                  vSpace16,
                  KTextField(
                    label: 'Monthly Fee',
                    hintText: 'Eg: ₹1200',
                    controller: monthlyFeeCtlr,
                    validator: Validator.required,
                  ),
                  vSpace16,
                  KTextField(
                    label: 'Advance Fee',
                    hintText: 'Eg: ₹2000',
                    controller: advanceFeeCtlr,
                  ),
                  vSpace24,
                  Selector<StudentProvider, bool>(
                    selector: (context, value) => value.isBtnLoading,
                    builder: (context, value, child) {
                      return KFilledButton(
                        text: 'Done',
                        isLoading: value,
                        onPressed: widget.type == PageType.add
                            ? onAddPressed
                            : onEditPressed,
                      );
                    },
                  ),
                ],
              ),
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
          Text(
            widget.type == PageType.add ? 'Add New Student' : 'Edit Student',
          ),
          hSpace40,
        ],
      ),
    );
  }
}
