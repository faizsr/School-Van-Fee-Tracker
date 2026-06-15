import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/utils/validators.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';
import 'package:school_van_fee_tracker/src/providers/school_provider.dart';
import 'package:school_van_fee_tracker/src/screens/add_edit_student/widgets/k_text_field.dart';
import 'package:school_van_fee_tracker/src/widgets/k_filled_button.dart';

class AddEditSchoolBtmSheet extends StatefulWidget {
  const AddEditSchoolBtmSheet({super.key, this.school, required this.type});

  final PageType type;
  final SchoolModel? school;

  @override
  State<AddEditSchoolBtmSheet> createState() => _AddEditSchoolBtmSheetState();
}

class _AddEditSchoolBtmSheetState extends State<AddEditSchoolBtmSheet> {
  final schoolNameTextCtlr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late SchoolProvider schoolProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schoolProvider = context.read<SchoolProvider>();
    });

    if (widget.type == PageType.edit) {
      schoolNameTextCtlr.text = widget.school!.name;
    }
    super.initState();
  }

  Future<void> addSchool() async {
    if (formKey.currentState!.validate()) {
      await schoolProvider.addSchool(schoolNameTextCtlr.text);
      schoolNameTextCtlr.clear();
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> editSchool() async {
    if (formKey.currentState!.validate()) {
      await schoolProvider.editSchool(widget.school!, schoolNameTextCtlr.text);
      schoolNameTextCtlr.clear();
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Selector<SchoolProvider, bool>(
              selector: (context, value) => value.isBtnLoading,
              builder: (context, value, child) {
                return KFilledButton(
                  text: 'Done',
                  isLoading: value,
                  onPressed: widget.type == PageType.add
                      ? addSchool
                      : editSchool,
                );
              },
            ),
            vSpace12,
          ],
        ),
      ),
    );
  }
}
