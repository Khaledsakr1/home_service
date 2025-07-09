import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:home_service/core/error/failures.dart';
import '../../domain/entities/furniture_image.dart';
import '../../domain/usecases/generate_furniture_image.dart';

part 'furniture_image_state.dart';

class FurnitureImageCubit extends Cubit<FurnitureImageState> {
  final GenerateFurnitureImage generateFurnitureImageUseCase;

  FurnitureImageCubit({required this.generateFurnitureImageUseCase}) 
      : super(FurnitureImageInitial());

  Future<void> generateImage(String prompt) async {
    emit(FurnitureImageLoading());
    final failureOrImage = await generateFurnitureImageUseCase(
      GenerateImageParams(prompt: prompt),
    );
    failureOrImage.fold(
      (failure) => emit(FurnitureImageError(_mapFailureToMessage(failure))),
      (image) => emit(FurnitureImageLoaded(image)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure - Could not generate image';
      case CacheFailure:
        return 'Cache Failure';
      case NetworkFailure:
        return 'Network Failure - Check your connection';
      default:
        return 'Unexpected Error';
    }
  }
}