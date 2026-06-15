import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_colors.dart';
import 'package:school_van_fee_tracker/src/core/constants/app_constants.dart';
import 'package:school_van_fee_tracker/src/models/payment_model.dart';
import 'package:school_van_fee_tracker/src/models/student_model.dart';
import 'package:school_van_fee_tracker/src/providers/student_provider.dart';

class PaymentHistoryTable extends StatefulWidget {
  const PaymentHistoryTable({super.key, required this.student});

  final StudentModel student;

  @override
  State<PaymentHistoryTable> createState() => _PaymentHistoryTableState();
}

class _PaymentHistoryTableState extends State<PaymentHistoryTable> {
  late String selectedYear;
  late List<String> years;
  late List<PaymentModel> payments;

  @override
  void initState() {
    years = widget.student.paymentsByYear.keys.toList();
    selectedYear = years.first;
    payments = widget.student.paymentsByYear[selectedYear] ?? [];
    super.initState();
  }

  String getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  void onYearChange(String year) {
    selectedYear = year;
    payments = widget.student.paymentsByYear[selectedYear] ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: years.map((y) {
                    bool isSelected = selectedYear == y;
                    return GestureDetector(
                      onTap: () => onYearChange(y),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : AppColors.black.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          y,
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            hSpace8,
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightWhite,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.add, size: 20),
              ),
            ),
          ],
        ),
        vSpace16,

        buildTableHeading(),
        ListView.separated(
          itemCount: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => separator,
          itemBuilder: (context, index) => buildTableRow(payments[index]),
        ),
      ],
    );
  }

  Padding buildTableRow(PaymentModel payment) {
    bool isPaid = payment.status == 'paid';
    bool isDue = payment.status == 'due';
    String paidOn = '-';
    if (isPaid) paidOn = DateFormat('dd/MM/yyyy').format(payment.paidOn!);

    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(child: Center(child: Text(getMonthName(payment.month)))),
          Expanded(child: Center(child: Text(paidOn))),
          Expanded(
            child: Center(child: Text(isPaid ? '₹${payment.amount}' : '-')),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
              decoration: BoxDecoration(
                color: isPaid
                    ? AppColors.yellow
                    : isDue
                    ? AppColors.red
                    : AppColors.lightWhite,
                borderRadius: BorderRadius.circular(100),
              ),
              child: isPaid
                  ? Center(child: Text('Paid'))
                  : isDue
                  ? buildDropDownBtn(
                      value: 'Due',
                      items: ['Paid', 'Due', 'None'],
                      fgColor: AppColors.white,
                      payment: payment,
                    )
                  : buildDropDownBtn(
                      value: 'None',
                      items: ['Paid', 'Due', 'None'],
                      payment: payment,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropDownBtn({
    required String value,
    required List<String> items,
    Color? fgColor,
    required PaymentModel payment,
  }) {
    return DropdownButton2<String>(
      isDense: true,
      isExpanded: true,
      underline: SizedBox(),
      customButton: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: TextStyle(color: fgColor)),
            Icon(Icons.arrow_drop_down, color: fgColor),
          ],
        ),
      ),
      valueListenable: ValueNotifier(value),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: fgColor),
      items: items
          .map(
            (e) => DropdownItem<String>(
              value: e,
              child: Text(e, style: TextStyle(color: AppColors.black)),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == 'Paid') {
          StudentProvider studentProvider = context.read<StudentProvider>();
          final newPayment = payment.copyWith(
            academicYear: selectedYear,
            amount: widget.student.monthlyFee,
            paidOn: DateTime.now(),
            status: 'paid',
          );
          studentProvider.updatePayment(widget.student.id, newPayment);
        }
        if (value == 'Due') {
          StudentProvider studentProvider = context.read<StudentProvider>();
          final newPayment = payment.copyWith(
            academicYear: selectedYear,
            paidOn: DateTime.now(),
            status: 'due',
          );
          studentProvider.updatePayment(widget.student.id, newPayment);
        }
        if (value == 'None') {
          StudentProvider studentProvider = context.read<StudentProvider>();
          final newPayment = payment.copyWith(
            academicYear: selectedYear,
            paidOn: DateTime.now(),
            status: 'none',
          );
          studentProvider.updatePayment(widget.student.id, newPayment);
        }
      },
      dropdownStyleData: DropdownStyleData(
        elevation: 0,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.black.withValues(alpha: 0.2)),
        ),
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
