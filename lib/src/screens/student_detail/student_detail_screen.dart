import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';
import 'package:school_van_fee_tracker/src/screens/student_detail/widgets/payment_history_table.dart';
import 'package:school_van_fee_tracker/src/widgets/k_icon_button.dart';

class StudentDetailScreen extends StatelessWidget {
  const StudentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppbar(context),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              children: [
                buildStudentCard(context),
                vSpace16,

                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.lightWhite,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      buildFeesCard(context, 'Montly Fees', '₹1200'),
                      buildFeesCard(context, 'Advance Fees', '2000'),
                    ],
                  ),
                ),
                vSpace20,

                Text(
                  'Payment History',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                vSpace8,
                PaymentHistoryTable(),
              ],
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

  Widget buildStudentCard(BuildContext context) {
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
                  'Johny S George',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  'School: St Julianas Public School',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.black.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
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
                  '9845153265',
                  style: TextStyle(
                    color: AppColors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blue,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [Iconify(Ci.location), hSpace2, Text('Kochi, Kerala')],
            ),
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
            onPressed: () {},
            bgColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
