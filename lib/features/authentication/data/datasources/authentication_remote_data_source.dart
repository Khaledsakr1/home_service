import 'dart:convert';
import 'dart:io';
import 'package:home_service/features/authentication/data/models/customer_model.dart';
import 'package:home_service/features/authentication/data/models/worker_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

abstract class AuthenticationRemoteDataSource {
  Future<String> registerCustomer(CustomerModel customer);
  Future<bool> checkEmailExists(String email);
  Future<Map<String, dynamic>> loginUser(String email, String password);
  Future<String> registerWorker(WorkerModel worker, String? profilePicturePath);
}

class AuthenticationRemoteDataSourceImpl implements AuthenticationRemoteDataSource {
  final http.Client client;
  static const String baseUrl =
      'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';

  AuthenticationRemoteDataSourceImpl({required this.client});

  @override
  Future<String> registerCustomer(CustomerModel customer) async {
    final uri = Uri.parse('$baseUrl/api/Account/register/customer')
        .replace(queryParameters: customer.toQueryParams());

    final response = await client.post(uri);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to register customer: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<bool> checkEmailExists(String email) async {
    final uri = Uri.parse('$baseUrl/api/Account/emailexists?email=$email');
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return response.body.trim().toLowerCase() == 'true';
    } else {
      throw Exception('Failed to check email: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/Account/login');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<String> registerWorker(WorkerModel worker, String? profilePicturePath) async {
    final uri = Uri.parse('$baseUrl/api/Account/register/worker');

    var request = http.MultipartRequest('POST', uri);

    request.fields.addAll(worker.toFields());

    if (profilePicturePath != null) {
      File profilePicture = File(profilePicturePath);
      final mimeType = lookupMimeType(profilePicture.path) ?? 'image/jpeg';
      request.files.add(
        await http.MultipartFile.fromPath(
          'ProfilePicture',
          profilePicture.path,
          contentType: MediaType.parse(mimeType),
        ),
      );
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    print('RegisterWorker response body: $responseBody');
    if (response.statusCode == 200) {
        final json = jsonDecode(responseBody);
  if (json.containsKey('token')) {
    return json['token'];
  } else {
    throw Exception('Token missing in response');
  }
    } else {
      throw Exception('Failed to register worker: ${response.statusCode} $responseBody');
    }
  }
}


