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

  Future<void> getStudents() async {
    isLoading = true;
    notifyListeners();

    final result = await studentService.getStudents();
    students = result;

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
