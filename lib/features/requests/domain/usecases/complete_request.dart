import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/request.dart';
import '../repositories/request_repository.dart';

class CompleteRequest implements UseCase<Request, CompleteRequestParams> {
  final RequestRepository repository;

  CompleteRequest(this.repository);

  @override
  Future<Either<Failure, Request>> call(CompleteRequestParams params) {
    return repository.completeRequest(params.requestId);
  }
}

class CompleteRequestParams {
  final int requestId;
  CompleteRequestParams({required this.requestId});
}