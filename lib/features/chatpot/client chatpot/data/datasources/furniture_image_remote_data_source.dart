import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../models/furniture_image_model.dart';

abstract class FurnitureImageRemoteDataSource {
  Future<FurnitureImageModel> generateImage(String prompt);
}

class FurnitureImageRemoteDataSourceImpl implements FurnitureImageRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://b1dce5eeee2c.ngrok-free.app';

  FurnitureImageRemoteDataSourceImpl({required this.client});

  @override
  Future<FurnitureImageModel> generateImage(String prompt) async {
    print("generateImage called with prompt: $prompt");
    
    final url = Uri.parse('$baseUrl/generate-furniture-design');
    print('Sending HTTP POST...');
    
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );
    
    print("Received response: ${response.statusCode}");
    print("Body bytes length: ${response.bodyBytes.length}");
    
    if (response.statusCode == 200) {
      print("Received response: ${response.statusCode}");
      print(response.bodyBytes.sublist(0, 16));
      
      return FurnitureImageModel.fromResponse(response.bodyBytes, prompt);
    } else {
      throw Exception('Failed to generate image: ${response.statusCode} ${response.body}');
    }
  }
}