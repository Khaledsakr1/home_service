import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import '../entities/furniture_image.dart';
import '../repositories/furniture_image_repository.dart';

class GenerateFurnitureImage implements UseCase<FurnitureImage, GenerateImageParams> {
  final FurnitureImageRepository repository;

  GenerateFurnitureImage(this.repository);

  @override
  Future<Either<Failure, FurnitureImage>> call(GenerateImageParams params) async {
    return await repository.generateImage(params.prompt);
  }
}

class GenerateImageParams {
  final String prompt;

  GenerateImageParams({required this.prompt});
}