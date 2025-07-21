import '../../domain/entities/similar_image.dart';

class SimilarImageModel extends SimilarImage {
  const SimilarImageModel({
    required String workerId,
    required String imageId,
    required String imageUrl,
    required double similarityScore,
  }) : super(
    workerId: workerId,
    imageId: imageId,
    imageUrl: imageUrl,
    similarityScore: similarityScore,
  );

  factory SimilarImageModel.fromJson(Map<String, dynamic> json) {
    return SimilarImageModel(
      workerId: json['worker_id'] ?? '',
      imageId: json['image_id'] ?? '',
      imageUrl: json['image_url'] ?? '',
      similarityScore: (json['similarity_score'] as num?)?.toDouble() ?? 0,
    );
  }
}
