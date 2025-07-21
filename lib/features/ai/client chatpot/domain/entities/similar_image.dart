import 'package:equatable/equatable.dart';

class SimilarImage extends Equatable {
  final String workerId;
  final String imageId;
  final String imageUrl;
  final double similarityScore;

  const SimilarImage({
    required this.workerId,
    required this.imageId,
    required this.imageUrl,
    required this.similarityScore,
  });

  @override
  List<Object> get props => [workerId, imageId, imageUrl, similarityScore];
}
