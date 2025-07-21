// features/worker/domain/repositories/worker_repository.dart
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import '../entities/worker.dart';

abstract class WorkerRepository {
  Future<Either<Failure, Worker>> getWorkerById(int id);
}
