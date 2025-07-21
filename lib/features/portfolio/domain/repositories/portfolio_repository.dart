
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/portfolio/domain/entities/project.dart';
import 'dart:io';

abstract class PortfolioRepository {
  Future<Either<Failure, String>> addPortfolio({required String name, required String description, required List<File> images});
  Future<Either<Failure, bool>> updatePortfolio(int id, String name, String description);
  Future<Either<Failure, bool>> addPortfolioImages(int id, List<File> images);
  Future<Either<Failure, List<Project>>> getPortfolios();
  Future<Either<Failure, bool>> deletePortfolio(int id);
  Future<Either<Failure, bool>> deletePortfolioImage(int portfolioId, int imageId);
}


