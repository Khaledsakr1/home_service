import 'dart:convert';
import 'dart:io';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/portfolio/data/models/project_model.dart';
import 'package:home_service/injection_container.dart';
import 'package:http/http.dart' as http;

abstract class PortfolioRemoteDataSource {
  Future<String> addPortfolio({required String name, required String description, required List<File> images});
  Future<bool> updatePortfolio(int id, String name, String description);
  Future<bool> addPortfolioImages(int id, List<File> images);
  Future<List<ProjectModel>> getPortfolios();
  Future<bool> deletePortfolio(int id);
  Future<bool> deletePortfolioImage(int portfolioId, int imageId);
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final http.Client client;
  static const String baseUrl =
      'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';
  static String? authToken; // This should ideally be managed by an auth service

  PortfolioRemoteDataSourceImpl({required this.client});

  @override
  Future<String> addPortfolio({
    required String name,
    required String description,
    required List<File> images,
  }) async {
    final uri = Uri.parse('$baseUrl/api/Portfolio');

      final token = sl<TokenService>().token ?? '';
      if (token.isEmpty) throw Exception('No token found');

    print("Token used: ${authToken}");
    final request = http.MultipartRequest('POST', uri);

    request.fields['Name'] = name;
    request.fields['Description'] = description;

    // Only add images if the list is not empty
    if (images.isNotEmpty) {
      for (var image in images) {
        request.files.add(await http.MultipartFile.fromPath('ImageFiles', image.path));
      }
    }

    request.headers['Authorization'] = 'Bearer ${authToken ?? token}';

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    print("Status: ${response.statusCode}");
print("Body: $responseBody");


    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Failed to add portfolio: ${response.statusCode} $responseBody');
    }
  }

  @override
  Future<bool> updatePortfolio(int id, String name, String description) async {
      final token = sl<TokenService>().token ?? '';
  if (token.isEmpty) throw Exception('No token found');

    final response = await client.put(
      Uri.parse('$baseUrl/api/Portfolio/$id'),
      headers: {
        'Authorization': 'Bearer ${authToken ?? token}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': name, 'description': description}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update portfolio: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<bool> addPortfolioImages(int id, List<File> images) async {
      final token = sl<TokenService>().token ?? '';
  if (token.isEmpty) throw Exception('No token found');

    // Check if images list is empty
    if (images.isEmpty) {
      return true; // Return success if no images to add
    }

    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/api/Portfolio/$id/images'));
    for (var image in images) {
      request.files.add(await http.MultipartFile.fromPath('ImageFiles', image.path));
    }
    
    request.headers['Authorization'] = 'Bearer ${authToken ?? token}';
    
    final response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add portfolio images: ${response.statusCode} ${await response.stream.bytesToString()}');
    }
  }

@override
Future<List<ProjectModel>> getPortfolios() async {
  final token = sl<TokenService>().token ?? '';
  if (token.isEmpty) throw Exception('No token found');

  final uri = Uri.parse('$baseUrl/api/Portfolio');
  final response = await client.get(uri,
    headers: {
      'Authorization': 'Bearer ${authToken ?? token}',
      'Content-Type': 'application/json',
    },
  );
  print('Using token: ${authToken ?? token}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    if (response.body.trim().isEmpty) return [];
    final body = response.body.trim();
    final decoded = jsonDecode(body);

    if (decoded is List) {
      return decoded.map<ProjectModel>((json) => ProjectModel.fromJson(json)).toList();
    } else if (decoded is Map) {
      final msg = decoded['message'] ?? decoded.toString();
      throw Exception('Server returned error: $msg');
    } else {
      throw Exception('Unexpected response type from server.');
    }
  } else if (response.statusCode == 204) {
    return [];
  } else {
    throw Exception('Failed to get portfolios: ${response.statusCode} ${response.body}');
  }
}


  @override
  Future<bool> deletePortfolio(int id) async {
      final token = sl<TokenService>().token ?? '';
  if (token.isEmpty) throw Exception('No token found');

    final uri = Uri.parse('$baseUrl/api/Portfolio/$id');
    final response = await client.delete(
      uri,
      headers: {
        'Authorization': 'Bearer ${authToken ?? token}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete portfolio: ${response.statusCode} ${response.body}');
    }
  }

  @override
Future<bool> deletePortfolioImage(int portfolioId, int imageId) async {
  final token = sl<TokenService>().token ?? '';
  if (token.isEmpty) throw Exception('No token found');

  final uri = Uri.parse('$baseUrl/api/Portfolio/$portfolioId/images/$imageId');
  final response = await client.delete(
    uri,
    headers: {
      'Authorization': 'Bearer ${authToken ?? token}',
      'Content-Type': 'application/json',
    },
  );
  print('Delete image status: ${response.statusCode}, body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 204) {
    return true;
  } else {
    throw Exception('Failed to delete image: ${response.statusCode} ${response.body}');
  }
}
}