import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';
import 'package:home_service/features/requests/domain/repositories/worker_request_repository.dart';
import '../../../../core/usecases/usecase.dart';

class AcceptRequestParams {
  final int requestId;
  final double price;
  
  AcceptRequestParams({required this.requestId, required this.price});
}

class AcceptRequest implements UseCase<Request, AcceptRequestParams> {
  final WorkerRequestRepository repository;

  AcceptRequest(this.repository);

  @override
  Future<Either<Failure, Request>> call(AcceptRequestParams params) {
    return repository.acceptRequest(params.requestId, params.price);
  }
}
