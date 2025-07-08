import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:equatable/equatable.dart';

class DeletePortfolioImage implements UseCase<bool, DeletePortfolioImageParams> {
  final PortfolioRepository repository;

  DeletePortfolioImage(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeletePortfolioImageParams params) async {
    return await repository.deletePortfolioImage(params.portfolioId, params.imageId);
  }
}

class DeletePortfolioImageParams extends Equatable {
  final int portfolioId;
  final int imageId;

  const DeletePortfolioImageParams({
    required this.portfolioId,
    required this.imageId,
  });

  @override
  List<Object?> get props => [portfolioId, imageId];
}