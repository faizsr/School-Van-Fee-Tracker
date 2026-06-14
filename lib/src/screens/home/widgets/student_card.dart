import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/core/router/app_routes.dart';
import 'package:school_van_fee_tracker/src/models/student_model.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});

  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateTime.now().month;
    final matchingPayments = student.payments
        .where((payment) => payment.month == currentMonth)
        .toList();
    final currentPayment = matchingPayments.isNotEmpty
        ? matchingPayments.first
        : null;
    final isPaid =
        currentPayment != null && currentPayment.status.toLowerCase() == 'paid';
    final statusLabel = isPaid ? 'Paid' : 'Due';
    final statusColor = isPaid ? AppColors.yellow : AppColors.red;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.studentDetail,
        arguments: student,
      ),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(16),
        child: Column(
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
                Column(
                  children: [
                    Text(
                      'Status',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.gray),
                    ),
                    vSpace4,
                    Container(
                      padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        statusLabel,
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            vSpace12,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Row(
                  children: [
                    Iconify(Ci.location),
                    hSpace2,
                    Text(student.place),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
