import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/core/router/app_routes.dart';
import 'package:school_van_fee_tracker/src/models/student_model.dart';
import 'package:school_van_fee_tracker/src/providers/student_provider.dart';
import 'package:school_van_fee_tracker/src/screens/student_detail/widgets/payment_history_table.dart';
import 'package:school_van_fee_tracker/src/widgets/k_confirm_dialog.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class StudentDetailScreen extends StatefulWidget {
  final StudentModel student;
  const StudentDetailScreen({super.key, required this.student});

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  late StudentProvider studentProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      studentProvider = context.read<StudentProvider>();
      studentProvider.getStudent(widget.student.id);
    });
    super.initState();
  }

  void onEditPressed(StudentModel student) {
    Navigator.pushNamed(
      context,
      AppRoutes.editStudent,
      arguments: {'type': PageType.edit, 'student': student},
    );
  }

  void onDeletePressed() {
    showDialog(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.6),
      builder: (context) {
        return Selector<StudentProvider, bool>(
          selector: (context, value) => value.isBtnLoading,
          builder: (context, value, child) {
            return ConfirmDialog(
              icon: '?',
              isLoading: value,
              disableCancel: true,
              title: 'Delete Student',
              subTitle:
                  'This will permanently delete the student and all associated payment records. This action cannot be undone.',
              onPressed: () async {
                await studentProvider.deleteStudent(widget.student);
                if (context.mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppbar(context),
          Expanded(
            child: Consumer<StudentProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: AppColors.gray,
                    ),
                  );
                }

                if (value.student == null) {
                  return Center(child: Text('Error to load data'));
                }

                return ListView(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  children: [
                    buildStudentCard(value.student!),
                    vSpace16,

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightWhite,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          buildFeesCard(
                            context,
                            'Montly Fees',
                            '₹${value.student!.monthlyFee}',
                          ),
                          buildFeesCard(
                            context,
                            'Advance Fees',
                            '₹${value.student!.advanceFee}',
                          ),
                        ],
                      ),
                    ),
                    vSpace20,

                    Text(
                      'Payment History',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    vSpace8,
                    PaymentHistoryTable(
                      paymentsByYear: value.student!.paymentsByYear,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Expanded buildFeesCard(BuildContext context, String title, String amount) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors.black.withValues(alpha: 0.4)),
          ),
          vSpace4,
          Text(amount, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget buildStudentCard(StudentModel student) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.gray,
              child: Iconify(AppIcons.user, color: AppColors.white),
            ),
            hSpace12,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.fullName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'School: ${student.school.name}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () => onEditPressed(student),
              icon: Iconify(AppIcons.edit, size: 28),
            ),
          ],
        ),
        vSpace16,
        Row(
          children: [
            Row(
              children: [
                Iconify(Ci.phone, color: AppColors.blue),
                hSpace4,
                Text(
                  student.phone,
                  style: TextStyle(
                    color: AppColors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blue,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(children: [Iconify(Ci.location), hSpace2, Text(student.place)]),
            hSpace8,
          ],
        ),
      ],
    );
  }

  Container buildAppbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 8, 12),
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
          Text('Student Info'),
          KIconButton(
            iconSize: 24,
            icon: AppIcons.delete,
            onPressed: onDeletePressed,
            bgColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
