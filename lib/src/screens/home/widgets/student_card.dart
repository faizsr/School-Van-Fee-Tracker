import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ci.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_icons.dart';

class StudentCard extends StatelessWidget {
  const StudentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      color: AppColors.yellow,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text('Paid'),
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
                    '9845153265',
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
                  Text('Kochi, Kerala'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
