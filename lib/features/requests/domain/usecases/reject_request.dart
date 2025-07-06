import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/request.dart';
import '../repositories/worker_request_repository.dart';

class RejectRequest implements UseCase<Request, int> {
  final WorkerRequestRepository repository;

  RejectRequest(this.repository);

  @override
  Future<Either<Failure, Request>> call(int requestId) {
    return repository.rejectRequest(requestId);
  }
}