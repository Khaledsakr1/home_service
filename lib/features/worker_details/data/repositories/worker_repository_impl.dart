// features/worker/data/repositories/worker_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import '../../domain/entities/worker.dart';
import '../../domain/repositories/worker_repository.dart';
import '../datasources/worker_remote_data_source.dart';

class WorkerRepositoryImpl implements WorkerRepository {
  final WorkerRemoteDataSource remoteDataSource;
  WorkerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Worker>> getWorkerById(int id) async {
    try {
      final worker = await remoteDataSource.getWorkerById(id);
      return Right(worker);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
