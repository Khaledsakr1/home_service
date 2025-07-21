import 'dart:io';

import '../entities/similar_image.dart';
import '../repositories/similarity_search_repository.dart';

class FindSimilarImages {
  final SimilaritySearchRepository repository;

  FindSimilarImages(this.repository);

  Future<List<SimilarImage>> call(File imageFile, int topK) {
    return repository.findSimilarImages(imageFile, topK);
  }
}
