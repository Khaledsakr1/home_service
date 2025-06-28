import 'dart:convert';
import 'package:home_service/features/services/data/models/service_model.dart';
import 'package:http/http.dart' as http;

abstract class ServiceRemoteDataSource {
  Future<List<ServiceModel>> getServices();
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource {
  final http.Client client;
  static const String baseUrl =
      'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';

  ServiceRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ServiceModel>> getServices() async {
    final uri = Uri.parse('$baseUrl/api/Categories/services?pagesize=11');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> data = body['data'];
      return data.map((json) => ServiceModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch services: ${response.statusCode} ${response.body}');
    }
  }
}
