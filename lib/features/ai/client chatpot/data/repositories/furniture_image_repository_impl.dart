import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import '../../domain/entities/furniture_image.dart';
import '../../domain/repositories/furniture_image_repository.dart';
import '../datasources/furniture_image_remote_data_source.dart';

class FurnitureImageRepositoryImpl implements FurnitureImageRepository {
  final FurnitureImageRemoteDataSource remoteDataSource;

  FurnitureImageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FurnitureImage>> generateImage(String prompt) async {
    try {
      final result = await remoteDataSource.generateImage(prompt);
      return Right(result);
    } catch (e) {
      print('FurnitureImageRepositoryImpl.generateImage error: $e');
      return Left(ServerFailure());
    }
  }
}