import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';

class PaymentHistoryTable extends StatelessWidget {
  const PaymentHistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 8,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                '2026 - 27',
                style: TextStyle(color: AppColors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.black.withValues(alpha: 0.1),
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text('2027 - 28'),
            ),
          ],
        ),
        vSpace16,

        buildTableHeading(),
        ListView.separated(
          itemCount: 12,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => separator,
          itemBuilder: (context, index) => buildTableRow(index),
        ),
      ],
    );
  }

  Padding buildTableRow(int index) {
    bool isDue = index % 2 == 0 && index < 5;
    bool isPaid = index % 2 == 1 && index < 5;

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(child: Center(child: Text('Jun'))),
          Expanded(
            child: Center(child: Text(isPaid || isDue ? '01/06/2026' : '-')),
          ),
          Expanded(child: Center(child: Text(isPaid || isDue ? '₹1200' : '-'))),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
              decoration: BoxDecoration(
                color: isPaid
                    ? AppColors.yellow
                    : isDue
                    ? AppColors.red
                    : AppColors.lightWhite,
                borderRadius: BorderRadius.circular(100),
              ),
              child: isDue
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Due', style: TextStyle(color: AppColors.white)),
                        Icon(Icons.arrow_drop_down, color: AppColors.white),
                      ],
                    )
                  : isPaid
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Paid', style: TextStyle(color: AppColors.white)),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('None'), Icon(Icons.arrow_drop_down)],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildTableHeading() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Center(child: Text('Month'))),
          Expanded(child: Center(child: Text('Paid on'))),
          Expanded(child: Center(child: Text('Amount'))),
          Expanded(child: Center(child: Text('Status'))),
        ],
      ),
    );
  }
}
