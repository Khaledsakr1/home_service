// features/worker_search/data/datasources/worker_search_remote_data_source.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class WorkerSearchRemoteDataSource {
  Future<List<int>> getRecommendedWorkerIds(String query, {int topK = 5, String? preferredCity});
}

class WorkerSearchRemoteDataSourceImpl implements WorkerSearchRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'http://10.0.2.2:8000';

  WorkerSearchRemoteDataSourceImpl({required this.client});

  @override
  Future<List<int>> getRecommendedWorkerIds(String query, {int topK = 5, String? preferredCity}) async {
    final url = Uri.parse('$baseUrl/recommend');
    final body = {
      'job_description': query,
      'top_k': topK,
      if (preferredCity != null) 'preferred_city': preferredCity,
    };
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<int>.from(data['recommended_ids'].map((e) => int.tryParse(e.toString()) ?? 0));
    } else {
      throw Exception('Recommendation API error: ${response.body}');
    }
  }
}
