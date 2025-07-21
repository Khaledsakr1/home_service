import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/similar_image.dart';
import '../../domain/usecases/find_similar_images.dart';

part 'similarity_search_state.dart';

class SimilaritySearchCubit extends Cubit<SimilaritySearchState> {
  final FindSimilarImages findSimilarImages;

  SimilaritySearchCubit({required this.findSimilarImages}) : super(SimilaritySearchInitial());

  Future<void> searchSimilarWorkers(File image, int topK) async {
    emit(SimilaritySearchLoading());
    try {
      final similarImages = await findSimilarImages(image, topK);
      emit(SimilaritySearchLoaded(similarImages));
    } catch (e) {
      emit(SimilaritySearchError(e.toString()));
    }
  }
}
