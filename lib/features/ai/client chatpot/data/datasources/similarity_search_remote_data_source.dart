import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../models/similar_image_model.dart';

abstract class SimilaritySearchRemoteDataSource {
  Future<List<SimilarImageModel>> findSimilarImages(File imageFile, int topK);
}

class SimilaritySearchRemoteDataSourceImpl implements SimilaritySearchRemoteDataSource {
  static const String baseUrl = 'https://400ceb8b3a67.ngrok-free.app';
  final http.Client client;

  SimilaritySearchRemoteDataSourceImpl({required this.client});

@override
Future<List<SimilarImageModel>> findSimilarImages(File imageFile, int topK) async {
  final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';

  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/find-similar'));
  request.files.add(await http.MultipartFile.fromPath(
    'file',
    imageFile.path,
    contentType: MediaType.parse(mimeType), // <<<<<< add this!
  ));
  request.fields['top_k'] = '$topK';

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List images = data['similar_images'] ?? [];
    return images.map((json) => SimilarImageModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to get similar images: ${response.body}');
  }
}
}
