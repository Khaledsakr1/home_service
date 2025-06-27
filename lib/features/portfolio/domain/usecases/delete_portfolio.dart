
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';

class DeletePortfolio implements UseCase<bool, int> {
  final PortfolioRepository repository;

  DeletePortfolio(this.repository);

  @override
  Future<Either<Failure, bool>> call(int id) async {
    return await repository.deletePortfolio(id);
  }
}


