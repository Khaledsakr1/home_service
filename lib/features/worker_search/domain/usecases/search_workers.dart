// features/worker_search/domain/usecases/search_workers.dart
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import '../repositories/worker_search_repository.dart';

class SearchWorkers implements UseCase<List<int>, SearchWorkersParams> {
  final WorkerSearchRepository repository;
  SearchWorkers(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(SearchWorkersParams params) {
    return repository.getRecommendedWorkerIds(
      params.query,
      topK: params.topK,
      preferredCity: params.preferredCity,
    );
  }
}

class SearchWorkersParams {
  final String query;
  final int topK;
  final String? preferredCity;

  SearchWorkersParams({
    required this.query,
    this.topK = 5,
    this.preferredCity,
  });
}
