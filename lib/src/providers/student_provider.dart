import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/models/student_model.dart';
import 'package:school_van_fee_tracker/src/services/student_service.dart';

class StudentProvider extends ChangeNotifier {
  final studentService = StudentService();

  List<StudentModel> students = [];

  bool isLoading = false;
  bool isBtnLoading = false;

  Future<void> addStudent(StudentModel student) async {
    isBtnLoading = true;
    notifyListeners();

    final result = await studentService.addStudent(student);
    if (result != null) students.add(result);

    isBtnLoading = false;
    notifyListeners();
  }

  // Future<void> editSchool(SchoolModel school, String newName) async {
  //   isBtnLoading = true;
  //   notifyListeners();

  //   final result = await studentService.editSchool(school.id, newName);
  //   if (result != null) {
  //     final index = schools.indexWhere((s) => s.id == school.id);
  //     schools[index] = school.copyWith(name: newName);
  //   }

  //   isBtnLoading = false;
  //   notifyListeners();
  // }

  // Future<void> deleteSchool(SchoolModel school) async {
  //   isBtnLoading = true;
  //   notifyListeners();

  //   schools.removeWhere((s) => s.id == school.id);
  //   await studentService.deleteSchool(school.id);

  //   isBtnLoading = false;
  //   notifyListeners();
  // }

  Future<void> getStudents() async {
    isLoading = true;
    notifyListeners();

    final result = await studentService.getStudents();
    students = result;

    isLoading = false;
    notifyListeners();
  }
}
