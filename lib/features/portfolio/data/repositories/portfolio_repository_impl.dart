import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:home_service/features/portfolio/domain/entities/project.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> addPortfolio({
    required String name,
    required String description,
    required List<File> images,
  }) async {
    try {
      final result = await remoteDataSource.addPortfolio(
          name: name, description: description, images: images);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updatePortfolio(
      int id, String name, String description) async {
    try {
      final result = await remoteDataSource.updatePortfolio(id, name, description);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> addPortfolioImages(
      int id, List<File> images) async {
    try {
      final result = await remoteDataSource.addPortfolioImages(id, images);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Project>>> getPortfolios() async {
    try {
      final result = await remoteDataSource.getPortfolios();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deletePortfolio(int id) async {
    try {
      final result = await remoteDataSource.deletePortfolio(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}


