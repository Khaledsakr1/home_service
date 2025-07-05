import 'dart:convert';
import 'package:home_service/features/requests/data/model/request_model.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:http/http.dart' as http;
import '../../../../../core/services/token_service.dart';
import '../../../../../injection_container.dart';

abstract class RequestRemoteDataSource {
  Future<Map<String, dynamic>> sendRequest(int workerId, int projectId);
  Future<Map<String, dynamic>> cancelRequest(int requestId);
  Future<List<RequestModel>> getCustomerRequests({int? status});
}

class RequestRemoteDataSourceImpl implements RequestRemoteDataSource {
  final http.Client client;
  static const String baseUrl =
      'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';

  RequestRemoteDataSourceImpl({required this.client});

  @override
  Future<Map<String, dynamic>> sendRequest(int workerId, int projectId) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Requests');
    final body = jsonEncode({
      "workerId": workerId,
      "projectId": projectId,
    });
    final response = await client.post(uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send request: ${response.body}');
    }
  }

  @override
  Future<Map<String, dynamic>> cancelRequest(int requestId) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Requests/customer-cancel/$requestId');
    final response = await client.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print('request deleted');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to cancel request: ${response.body}');
    }
  }

@override
Future<List<RequestModel>> getCustomerRequests({int? status}) async {
  final token = di.sl<TokenService>().token ?? '';
  Uri uri = Uri.parse('$baseUrl/api/Requests/customer-requests');

  // Add the status as query param if provided
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
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => RequestModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load requests');
  }
}

}
