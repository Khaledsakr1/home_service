import 'dart:io';

import '../entities/similar_image.dart';

abstract class SimilaritySearchRepository {
  Future<List<SimilarImage>> findSimilarImages(File imageFile, int topK);
}
