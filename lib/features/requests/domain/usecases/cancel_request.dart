import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/request.dart';
import '../repositories/request_repository.dart';

class CancelRequest implements UseCase<Request, CancelRequestParams> {
  final RequestRepository repository;

  CancelRequest(this.repository);

  @override
  Future<Either<Failure, Request>> call(CancelRequestParams params) {
    return repository.cancelRequest(params.requestId);
  }
}

class CancelRequestParams {
  final int requestId;
  CancelRequestParams({required this.requestId});
}
