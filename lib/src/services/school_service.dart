import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:school_van_fee_tracker/src/models/school_model.dart';
import 'package:school_van_fee_tracker/src/services/api_services.dart';

class SchoolService {
  final dio = Dio();

  Future<SchoolModel?> addSchool(String name) async {
    final url = '${ApiServices.baseUrl}/schools';
    final body = {'name': name};

    try {
      final response = await dio.post(url, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('New school added successfully: ${response.data}');
        final data = response.data['data'];
        return SchoolModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(
        'Dio exception in adding school: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in adding school: $e');
    }

    return null;
  }

  Future<SchoolModel?> editSchool(String id, String name) async {
    final url = '${ApiServices.baseUrl}/schools/$id';
    final body = {'name': name};

    try {
      final response = await dio.put(url, data: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('School updated successfully: ${response.data}');
        final data = response.data['data'];
        return SchoolModel.fromJson(data);
      }
    } on DioException catch (e) {
      log(
        'Dio exception in updating school: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in updating school: $e');
    }

    return null;
  }

  Future<void> deleteSchool(String id) async {
    final url = '${ApiServices.baseUrl}/schools/$id';

    try {
      final response = await dio.delete(url);

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('School deleted successfully: $id');
      }
    } on DioException catch (e) {
      log(
        'Dio exception in deleting school: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in deleting school: $e');
    }
  }

  Future<List<SchoolModel>> getSchools() async {
    final url = '${ApiServices.baseUrl}/schools';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('Schools fetched successfully: ${response.data}');
        final data = response.data['data'] as List;
        final schools = data.map((e) => SchoolModel.fromJson(e)).toList();
        return schools;
      }
    } on DioException catch (e) {
      log(
        'Dio exception in fetching school: ${e.response?.statusCode} ${e.response?.data}',
      );
    } catch (e) {
      log('Exception in fetching schools: $e');
    }

    return [];
  }
}
