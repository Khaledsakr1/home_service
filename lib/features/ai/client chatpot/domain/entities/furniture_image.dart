import 'package:equatable/equatable.dart';
import 'dart:typed_data';

class FurnitureImage extends Equatable {
  final Uint8List imageBytes;
  final String prompt;
  final DateTime generatedAt;

  const FurnitureImage({
    required this.imageBytes,
    required this.prompt,
    required this.generatedAt,
  });

  @override
  List<Object?> get props => [imageBytes, prompt, generatedAt];
}