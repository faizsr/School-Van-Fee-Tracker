class PaymentModel {
  final String academicYear;
  final int month;
  final int amount;
  final DateTime paidOn;
  final String status;

  PaymentModel({
    required this.academicYear,
    required this.month,
    required this.amount,
    required this.paidOn,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      academicYear: json['academicYear'] as String? ?? '',
      month: json['month'] is int
          ? json['month'] as int
          : int.tryParse(json['month']?.toString() ?? '') ?? 0,
      amount: json['amount'] is int
          ? json['amount'] as int
          : int.tryParse(json['amount']?.toString() ?? '') ?? 0,
      paidOn: json['paidOn'] is DateTime
          ? json['paidOn'] as DateTime
          : DateTime.tryParse(json['paidOn']?.toString() ?? '') ??
                DateTime.now(),
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'academicYear': academicYear,
      'month': month,
      'amount': amount,
      'paidOn': paidOn.toIso8601String(),
      'status': status,
    };
  }

  PaymentModel copyWith({
    String? academicYear,
    int? month,
    int? amount,
    DateTime? paidOn,
    String? status,
  }) {
    return PaymentModel(
      academicYear: academicYear ?? this.academicYear,
      month: month ?? this.month,
      amount: amount ?? this.amount,
      paidOn: paidOn ?? this.paidOn,
      status: status ?? this.status,
    );
  }
}
