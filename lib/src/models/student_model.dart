import 'package:school_van_fee_tracker/src/models/payment_model.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';

class StudentModel {
  final String fullName;
  final String phone;
  final SchoolModel school;
  final String place;
  final int monthlyFee;
  final int advanceFee;
  final List<PaymentModel> payments;

  StudentModel({
    required this.fullName,
    required this.phone,
    required this.school,
    required this.place,
    required this.monthlyFee,
    required this.advanceFee,
    this.payments = const [],
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final schoolData = json['school'];
    final school = schoolData is Map<String, dynamic>
        ? SchoolModel.fromJson(schoolData)
        : SchoolModel(id: schoolData.toString(), name: '');

    final paymentsList = json['payments'] as List? ?? [];
    final payments = paymentsList
        .map((p) => PaymentModel.fromJson(p as Map<String, dynamic>))
        .toList();

    return StudentModel(
      fullName: json['fullName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      school: school,
      place: json['place'] as String? ?? '',
      monthlyFee: json['monthlyFee'] is int
          ? json['monthlyFee'] as int
          : int.tryParse(json['monthlyFee']?.toString() ?? '') ?? 0,
      advanceFee: json['advanceFee'] is int
          ? json['advanceFee'] as int
          : int.tryParse(json['advanceFee']?.toString() ?? '') ?? 0,
      payments: payments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phone': phone,
      'school': school.id,
      'place': place,
      'monthlyFee': monthlyFee,
      'advanceFee': advanceFee,
    };
  }

  StudentModel copyWith({
    String? fullName,
    String? phone,
    SchoolModel? school,
    String? place,
    int? monthlyFee,
    int? advanceFee,
    List<PaymentModel>? payments,
  }) {
    return StudentModel(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      school: school ?? this.school,
      place: place ?? this.place,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      advanceFee: advanceFee ?? this.advanceFee,
      payments: payments ?? this.payments,
    );
  }
}
