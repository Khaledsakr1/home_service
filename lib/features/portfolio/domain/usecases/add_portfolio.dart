import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

class AddPortfolio implements UseCase<String, AddPortfolioParams> {
  final PortfolioRepository repository;

  AddPortfolio(this.repository);

  @override
  Future<Either<Failure, String>> call(AddPortfolioParams params) async {
    return await repository.addPortfolio(
        name: params.name,
        description: params.description,
        images: params.images);
  }
}

class AddPortfolioParams extends Equatable {
  final String name;
  final String description;
  final List<File> images;

  const AddPortfolioParams({
    required this.name,
    required this.description,
    required this.images,
  });

  @override
  List<Object?> get props => [name, description, images];
}


