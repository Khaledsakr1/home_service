import 'dart:io';

import '../../domain/entities/similar_image.dart';
import '../../domain/repositories/similarity_search_repository.dart';
import '../datasources/similarity_search_remote_data_source.dart';

class SimilaritySearchRepositoryImpl implements SimilaritySearchRepository {
  final SimilaritySearchRemoteDataSource remoteDataSource;
  SimilaritySearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SimilarImage>> findSimilarImages(File imageFile, int topK) {
    return remoteDataSource.findSimilarImages(imageFile, topK);
  }
}
