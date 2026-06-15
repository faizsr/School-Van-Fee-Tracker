import 'package:school_van_fee_tracker/src/models/payment_model.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';

class StudentModel {
  final String id;
  final String fullName;
  final String phone;
  final SchoolModel school;
  final String place;
  final int monthlyFee;
  final int advanceFee;
  final List<PaymentModel> payments;
  final Map<String, List<PaymentModel>> paymentsByYear;
  final int count;

  StudentModel({
    this.id = '',
    required this.fullName,
    required this.phone,
    required this.school,
    required this.place,
    required this.monthlyFee,
    required this.advanceFee,
    this.payments = const [],
    this.paymentsByYear = const {},
    this.count = 0,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json, [int count = 0]) {
    final schoolData = json['school'];
    final school = schoolData is Map<String, dynamic>
        ? SchoolModel.fromJson(schoolData)
        : SchoolModel(id: schoolData.toString(), name: '');

    final paymentsList = json['payments'] as List? ?? [];
    final payments = paymentsList
        .map((p) => PaymentModel.fromJson(p as Map<String, dynamic>))
        .toList();

    // parse paymentsByYear if provided; expected shape: { "2026-27": [ {..}, ... ] }
    final paymentsByYearRaw =
        json['paymentsByYear'] as Map<String, dynamic>? ?? {};
    final paymentsByYear = paymentsByYearRaw.map((year, list) {
      final parsed = (list as List)
          .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return MapEntry(year, parsed);
    });

    // if top-level payments array is empty, flatten paymentsByYear into payments list
    final combinedPayments = payments.isNotEmpty
        ? payments
        : paymentsByYear.values.expand((e) => e).toList();

    return StudentModel(
      id: json['_id'],
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
      payments: combinedPayments,
      paymentsByYear: paymentsByYear,
      count: count,
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
    String? id,
    String? fullName,
    String? phone,
    SchoolModel? school,
    String? place,
    int? monthlyFee,
    int? advanceFee,
    List<PaymentModel>? payments,
    Map<String, List<PaymentModel>>? paymentsByYear,
  }) {
    return StudentModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      school: school ?? this.school,
      place: place ?? this.place,
      monthlyFee: monthlyFee ?? this.monthlyFee,
      advanceFee: advanceFee ?? this.advanceFee,
      payments: payments ?? this.payments,
      paymentsByYear: paymentsByYear ?? this.paymentsByYear,
    );
  }
}
