// features/worker_search/domain/repositories/worker_search_repository.dart
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';

abstract class WorkerSearchRepository {
  Future<Either<Failure, List<int>>> getRecommendedWorkerIds(String query, {int topK, String? preferredCity});
}
