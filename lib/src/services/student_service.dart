import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:school_van_fee_tracker/src/models/student_model.dart';
import 'package:school_van_fee_tracker/src/services/api_service.dart';

class StudentService {
  final dio = Dio();

  Future<StudentModel?> addStudent(StudentModel student) async {
    final url = '${ApiService.baseUrl}/students';
    final body = student.toJson();

    try {
      final response = await dio.post(url, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('New student added successfully');
        final data = response.data['data'];
        return StudentModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(
        'Dio exception in adding student: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in adding student: $e');
    }

    return null;
  }

  Future<StudentModel?> editStudent(StudentModel student) async {
    log('Id: ${student.id}');
    final url = '${ApiService.baseUrl}/students/${student.id}';
    final body = student.toJson();

    try {
      final response = await dio.put(url, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Student updated successfully: ${response.statusCode}');
        final data = response.data['data'];
        return StudentModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(
        'Dio exception in updating student: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in updating student: $e');
    }

    return null;
  }

  Future<void> deleteStudent(String id) async {
    final url = '${ApiService.baseUrl}/students/$id';

    try {
      final response = await dio.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('School deleted successfully: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log(
        'Dio exception in deleting school: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in deleting school: $e');
    }
  }

  Future<List<StudentModel>> getStudents() async {
    final url = '${ApiService.baseUrl}/students';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Students fetched successfully');
        final data = response.data['data']['students'] as List;
        final students = data.map((e) => StudentModel.fromJson(e)).toList();
        return students;
      }
    } on DioException catch (e) {
      log(
        'Dio exception in fetching students: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in fetching students: $e');
    }

    return [];
  }

  Future<StudentModel?> getStudent(String id) async {
    final url = '${ApiService.baseUrl}/students/$id';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Student fetched successfully');
        final data = response.data['data'];
        final students = StudentModel.fromJson(data);
        return students;
      }
    } on DioException catch (e) {
      log(
        'Dio exception in fetching student: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in fetching student: $e');
    }

    return null;
  }
}
