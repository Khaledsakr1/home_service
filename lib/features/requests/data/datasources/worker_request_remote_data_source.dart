import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/services/token_service.dart';
import '../../../../../injection_container.dart';
import '../model/request_model.dart';

abstract class WorkerRequestRemoteDataSource {
  Future<List<RequestModel>> getReceivedRequests({int? status});
  Future<RequestModel> acceptRequest(int requestId, double price);
  Future<RequestModel> rejectRequest(int requestId);
}

class WorkerRequestRemoteDataSourceImpl implements WorkerRequestRemoteDataSource {
  final http.Client client;
  static const String baseUrl =
      'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';

  WorkerRequestRemoteDataSourceImpl({required this.client});

  @override
  Future<List<RequestModel>> getReceivedRequests({int? status}) async {
    final token = sl<TokenService>().token ?? '';
    Uri uri = Uri.parse('$baseUrl/api/Requests/received-requests');
    if (status != null) {
      uri = uri.replace(queryParameters: {'Status': status.toString()});
    }
    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => RequestModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load received requests');
    }
  }

  @override
  Future<RequestModel> acceptRequest(int requestId, double price) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Requests/worker-accept/$requestId');
    final response = await client.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: price.toString() // This sends just 250.6

    );
    if (response.statusCode == 200) {
      return RequestModel.fromJson(jsonDecode(response.body));
    } else {
      print('Accept request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to accept request');
    }
  }

  @override
  Future<RequestModel> rejectRequest(int requestId) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Requests/worker-reject/$requestId');
    final response = await client.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return RequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to reject request');
    }
  }
}