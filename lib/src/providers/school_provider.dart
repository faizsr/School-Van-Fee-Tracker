import 'package:flutter/material.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';
import 'package:school_van_fee_tracker/src/services/school_service.dart';

class SchoolProvider extends ChangeNotifier {
  final schoolService = SchoolService();

  List<SchoolModel> schools = [];

  bool isLoading = false;
  bool isBtnLoading = false;

  Future<void> addSchool(String name) async {
    isBtnLoading = true;
    notifyListeners();

    final result = await schoolService.addSchool(name);
    if (result != null) schools.add(result);

    isBtnLoading = false;
    notifyListeners();
  }

  Future<void> editSchool(SchoolModel school, String newName) async {
    isBtnLoading = true;
    notifyListeners();

    final result = await schoolService.editSchool(school.id, newName);
    if (result != null) {
      final index = schools.indexWhere((s) => s.id == school.id);
      schools[index] = school.copyWith(name: newName);
    }

    isBtnLoading = false;
    notifyListeners();
  }

  Future<void> deleteSchool(SchoolModel school) async {
    isBtnLoading = true;
    notifyListeners();

    schools.removeWhere((s) => s.id == school.id);
    await schoolService.deleteSchool(school.id);

    isBtnLoading = false;
    notifyListeners();
  }

  Future<void> getSchools() async {
    isLoading = true;
    notifyListeners();

    final result = await schoolService.getSchools();
    schools = result;

    isLoading = false;
    notifyListeners();
  }
}
