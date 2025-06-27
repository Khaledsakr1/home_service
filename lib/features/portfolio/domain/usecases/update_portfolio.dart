
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:equatable/equatable.dart';

class UpdatePortfolio implements UseCase<bool, UpdatePortfolioParams> {
  final PortfolioRepository repository;

  UpdatePortfolio(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdatePortfolioParams params) async {
    return await repository.updatePortfolio(params.id, params.name, params.description);
  }
}

class UpdatePortfolioParams extends Equatable {
  final int id;
  final String name;
  final String description;

  const UpdatePortfolioParams({
    required this.id,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, description];
}


