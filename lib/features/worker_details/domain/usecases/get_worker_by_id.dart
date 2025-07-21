// features/worker/domain/usecases/get_worker_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import '../entities/worker.dart';
import '../repositories/worker_repository.dart';

class GetWorkerById implements UseCase<Worker, int> {
  final WorkerRepository repository;
  GetWorkerById(this.repository);

  @override
  Future<Either<Failure, Worker>> call(int id) async {
    return await repository.getWorkerById(id);
  }
}
