
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

class AddPortfolioImages implements UseCase<bool, AddPortfolioImagesParams> {
  final PortfolioRepository repository;

  AddPortfolioImages(this.repository);

  @override
  Future<Either<Failure, bool>> call(AddPortfolioImagesParams params) async {
    return await repository.addPortfolioImages(params.id, params.images);
  }
}

class AddPortfolioImagesParams extends Equatable {
  final int id;
  final List<File> images;

  const AddPortfolioImagesParams({
    required this.id,
    required this.images,
  });

  @override
  List<Object?> get props => [id, images];
}


