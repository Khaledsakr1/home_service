// lib/features/requests/domain/usecases/accept_request.dart
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';
import 'package:home_service/features/requests/domain/repositories/worker_request_repository.dart';

import '../../../../core/usecases/usecase.dart';

class AcceptRequest implements UseCase<Request, int> {
  final WorkerRequestRepository repository;

  AcceptRequest(this.repository);

  @override
  Future<Either<Failure, Request>> call(int requestId) {
    return repository.acceptRequest(requestId);
  }
}