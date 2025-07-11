part of 'similarity_search_cubit.dart';

abstract class SimilaritySearchState {}

class SimilaritySearchInitial extends SimilaritySearchState {}

class SimilaritySearchLoading extends SimilaritySearchState {}

class SimilaritySearchLoaded extends SimilaritySearchState {
  final List<SimilarImage> similarImages;
  SimilaritySearchLoaded(this.similarImages);
}

class SimilaritySearchError extends SimilaritySearchState {
  final String message;
  SimilaritySearchError(this.message);
}
