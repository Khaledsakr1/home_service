import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/client_project_model.dart';
import '../../../../core/services/token_service.dart';
import '../../../../injection_container.dart';

abstract class ClientProjectRemoteDataSource {
  Future<List<ClientProjectModel>> getProjects();
  Future<ClientProjectModel> getProject(int id);
  Future<ClientProjectModel> addProject({
    required Map<String, dynamic> data,
    required List<File> images,
  });
  Future<ClientProjectModel> updateProject({
    required int id,
    required Map<String, dynamic> data,
  });
  Future<void> deleteProject(int id);
  Future<void> addProjectImages(int id, List<File> images);
  Future<void> deleteProjectImage(int projectId, int imageId);
}

class ClientProjectRemoteDataSourceImpl
    implements ClientProjectRemoteDataSource {
  final http.Client client;
  static const String baseUrl =
      'https://projectapi-ekhpcndsdgbahqhm.canadacentral-01.azurewebsites.net';

  ClientProjectRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ClientProjectModel>> getProjects() async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Projects');
    final response = await client.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return (decoded as List)
          .map((e) => ClientProjectModel.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to get projects');
    }
  }

  @override
  Future<ClientProjectModel> getProject(int id) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Projects/$id');
    final response = await client.get(uri, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return ClientProjectModel.fromJson(decoded);
    } else {
      throw Exception('Failed to get project');
    }
  }

  @override
  Future<ClientProjectModel> addProject({
    required Map<String, dynamic> data,
    required List<File> images,
  }) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Projects');
    final request = http.MultipartRequest('POST', uri);

    data.forEach((key, value) {
      if (value != null) request.fields[key] = value.toString();
    });

    if (images.isNotEmpty) {
      for (final img in images) {
        request.files
            .add(await http.MultipartFile.fromPath('ImageFiles', img.path));
      }
    }
    request.headers['Authorization'] = 'Bearer $token';
    final streamed = await request.send();
    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode == 200) {
      return ClientProjectModel.fromJson(jsonDecode(body));
    } else {
      throw Exception('Failed to add project: $body');
    }
  }

  @override
  Future<ClientProjectModel> updateProject({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Projects/$id');
    final response = await client.put(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return ClientProjectModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update project: ${response.body}');
    }
  }

  @override
  Future<void> deleteProject(int id) async {
    final token = sl<TokenService>().token ?? '';
    print('image is about to delete with $id');
    final uri = Uri.parse('$baseUrl/api/Projects/$id');
    final response = await client.delete(uri, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
   if (response.statusCode != 200 && response.statusCode != 204) {
  print('${response.statusCode}');
  throw Exception('Failed to delete project');
}

  }

  @override
  Future<void> addProjectImages(int id, List<File> images) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Projects/$id/images');
    final request = http.MultipartRequest('POST', uri);
    for (final img in images) {
      request.files.add(await http.MultipartFile.fromPath('files', img.path));
    }
    request.headers['Authorization'] = 'Bearer $token';
    final streamed = await request.send();
    if (streamed.statusCode != 200) {
      throw Exception('Failed to add images');
    }
  }

  @override
  Future<void> deleteProjectImage(int projectId, int imageId) async {
    final token = sl<TokenService>().token ?? '';
    final uri = Uri.parse('$baseUrl/api/Projects/$projectId/images/$imageId');
    final response = await client.delete(uri, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    });
    if (response.statusCode != 200) {
      throw Exception('Failed to delete image');
    }
  }
}
