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

  Future<void> getSchools() async {
    isLoading = true;
    notifyListeners();

    final result = await schoolService.getSchools();
    schools = result;

    isLoading = false;
    notifyListeners();
  }
}
