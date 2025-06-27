// lib/features/worker_settings/data/datasources/worker_settings_remote_data_source.dart

import 'dart:convert';
import 'dart:io';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import 'package:home_service/injection_container.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class WorkerSettingsRemoteDataSource {
  Future<WorkerProfileUpdateModel> fetchWorkerProfile();
  Future<void> updateWorkerProfile(
      WorkerProfileUpdateModel profile);
  Future<void> updateProfilePicture(File image);
  
}

class WorkerSettingsRemoteDataSourceImpl
    implements WorkerSettingsRemoteDataSource {
  static const String baseUrl =
      'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';

  WorkerSettingsRemoteDataSourceImpl();

  @override
  Future<WorkerProfileUpdateModel> fetchWorkerProfile() async {
       final token = sl<TokenService>().token;
      if (token == null) throw Exception('No token found');

    final response = await http.get(
      Uri.parse('$baseUrl/api/Account/me'), // <-- replace if different
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      return WorkerProfileUpdateModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch worker profile');
    }
  }

  @override
  Future<void> updateWorkerProfile(
      WorkerProfileUpdateModel profile) async {
    
    final token = sl<TokenService>().token;
    if (token == null) throw Exception('No token found');

    final response = await http.put(
      Uri.parse('$baseUrl/api/Account/update'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(profile.toJson()), // Use this!
    );
    print('Update response status: ${response.statusCode}');
    print('Update response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

@override
  Future<void> updateProfilePicture(File image) async {
  final token = sl<TokenService>().token;
  if (token == null) throw Exception('No token found');

  var request = http.MultipartRequest(
      'PUT', Uri.parse('$baseUrl/api/Account/update-profile-picture'));
  request.headers['Authorization'] = 'Bearer $token';

  // THIS IS THE KEY: Use the field name "File"
  request.files.add(await http.MultipartFile.fromPath('newProfilePicture', image.path));

  final response = await request.send();

  // Debug: Read response body for error message if it fails
  final responseBody = await response.stream.bytesToString();
  print('Profile image upload status: ${response.statusCode}');
  print('Profile image upload body: $responseBody');

  if (response.statusCode != 200) {
    throw Exception('Failed to update profile picture');
  }
}


}
