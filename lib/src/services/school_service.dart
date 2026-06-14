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
