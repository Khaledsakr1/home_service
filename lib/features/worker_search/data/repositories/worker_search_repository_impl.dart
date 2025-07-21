// features/worker_search/data/repositories/worker_search_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import '../../domain/repositories/worker_search_repository.dart';
import '../datasources/worker_search_remote_data_source.dart';

class WorkerSearchRepositoryImpl implements WorkerSearchRepository {
  final WorkerSearchRemoteDataSource remoteDataSource;

  WorkerSearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<int>>> getRecommendedWorkerIds(String query, {int topK = 5, String? preferredCity}) async {
    try {
      final ids = await remoteDataSource.getRecommendedWorkerIds(query, topK: topK, preferredCity: preferredCity);
      return Right(ids);
    } catch (_) {
      return Left(ServerFailure());
    }
  }
}
