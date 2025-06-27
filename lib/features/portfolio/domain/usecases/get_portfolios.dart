
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/portfolio/domain/entities/project.dart';
import 'package:home_service/features/portfolio/domain/repositories/portfolio_repository.dart';

class GetPortfolios implements UseCase<List<Project>, NoParams> {
  final PortfolioRepository repository;

  GetPortfolios(this.repository);

  @override
  Future<Either<Failure, List<Project>>> call(NoParams params) async {
    return await repository.getPortfolios();
  }
}


