import 'dart:typed_data';
import '../../domain/entities/furniture_image.dart';

class FurnitureImageModel extends FurnitureImage {
  const FurnitureImageModel({
    required Uint8List imageBytes,
    required String prompt,
    required DateTime generatedAt,
  }) : super(
    imageBytes: imageBytes,
    prompt: prompt,
    generatedAt: generatedAt,
  );

  factory FurnitureImageModel.fromResponse(Uint8List bytes, String prompt) {
    return FurnitureImageModel(
      imageBytes: bytes,
      prompt: prompt,
      generatedAt: DateTime.now(),
    );
  }
}