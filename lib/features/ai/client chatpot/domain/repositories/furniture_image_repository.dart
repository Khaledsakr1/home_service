import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import '../entities/furniture_image.dart';

abstract class FurnitureImageRepository {
  Future<Either<Failure, FurnitureImage>> generateImage(String prompt);
}