// lib/features/requests/domain/usecases/get_received_requests.dart
import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/request.dart';
import '../repositories/worker_request_repository.dart';

class GetReceivedRequests implements UseCase<List<Request>, int?> {
  final WorkerRequestRepository repository;

  GetReceivedRequests(this.repository);

  @override
  Future<Either<Failure, List<Request>>> call(int? status) {
    return repository.getReceivedRequests(status: status);
  }
}
