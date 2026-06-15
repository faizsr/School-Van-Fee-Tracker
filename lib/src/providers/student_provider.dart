import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/models/payment_model.dart';
import 'package:school_van_fee_tracker/src/models/student_model.dart';
import 'package:school_van_fee_tracker/src/services/student_service.dart';

class StudentProvider extends ChangeNotifier {
  final studentService = StudentService();

  List<StudentModel> students = [];
  StudentModel? student;

  bool isLoading = false;
  bool isBtnLoading = false;

  bool isFiltered = false;

  Map<String, dynamic> studentFilters = {};

  void addFilter({String status = '', String school = ''}) {
    if (school.isEmpty) studentFilters['status'] = status;
    if (status.isEmpty) studentFilters['school'] = school;

    if (school == 'none') studentFilters.remove('school');
    if (status == 'none') studentFilters.remove('status');
    notifyListeners();
  }

  Future<void> addStudent(StudentModel student) async {
    isBtnLoading = true;
    notifyListeners();

    final result = await studentService.addStudent(student);
    if (result != null) students.insert(0, result);

    isBtnLoading = false;
    notifyListeners();
  }

  Future<void> editStudent(StudentModel newStudent) async {
    isBtnLoading = true;
    notifyListeners();

    final result = await studentService.editStudent(newStudent);
    if (result != null) {
      final index = students.indexWhere((s) => s.id == newStudent.id);
      students[index] = result;
      student = newStudent;
    }

    isBtnLoading = false;
    notifyListeners();
  }

  Future<void> deleteStudent(StudentModel std) async {
    isBtnLoading = true;
    notifyListeners();

    students.removeWhere((s) => s.id == std.id);
    await studentService.deleteStudent(std.id);

    isBtnLoading = false;
    notifyListeners();
  }

  Future<void> getStudents({
    bool onInitial = false,
    bool onRefresh = false,
    int page = 1,
    String searchQuery = '',
    Map<String, dynamic> filters = const {},
  }) async {
    isFiltered = false;
    if (onRefresh) studentFilters.clear();
    if (filters.isNotEmpty) isFiltered = true;
    if (onInitial && !onRefresh) {
      isLoading = true;
      notifyListeners();
    }

    final result = await studentService.getStudents(page, searchQuery, filters);
    if (onInitial) {
      students = result;
    } else {
      students.addAll(result);
    }

    log('Students length: ${students.length}');

    isLoading = false;
    notifyListeners();
  }

  Future<void> getStudent(String id) async {
    isLoading = true;
    notifyListeners();

    student = await studentService.getStudent(id);

    isLoading = false;
    notifyListeners();
  }

  Future<void> updatePayment(String studentId, PaymentModel payment) async {
    final studentIndex = students.indexWhere((s) => s.id == studentId);
    final paymentIndex1 = students[studentIndex].payments.indexWhere(
      (p) => p.academicYear == payment.academicYear && p.month == payment.month,
    );
    students[studentIndex].payments[paymentIndex1] = payment;

    final paymentIndex2 = student!.paymentsByYear[payment.academicYear]!
        .indexWhere((p) => p.month == payment.month);
    student!.paymentsByYear[payment.academicYear]![paymentIndex2] = payment;
    notifyListeners();

    await studentService.updatePayment(studentId, payment);
  }
}
