// features/worker/data/datasources/worker_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/worker_model.dart';

abstract class WorkerRemoteDataSource {
  Future<WorkerModel> getWorkerById(int id);
}

class WorkerRemoteDataSourceImpl implements WorkerRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';

  WorkerRemoteDataSourceImpl({required this.client});

  @override
  Future<WorkerModel> getWorkerById(int id) async {
    final uri = Uri.parse('$baseUrl/api/Profile/workers/$id');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      print('Worker fetched successfully: ${response.body}');
      final body = jsonDecode(response.body);
      return WorkerModel.fromJson(body); // adjust if "data" key
    } else {
      throw Exception('Failed to fetch worker: ${response.statusCode} ${response.body}');
    }
  }
}
