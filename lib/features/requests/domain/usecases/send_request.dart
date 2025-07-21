import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/request.dart';
import '../repositories/request_repository.dart';

class SendRequest implements UseCase<Request, SendRequestParams> {
  final RequestRepository repository;

  SendRequest(this.repository);

  @override
  Future<Either<Failure, Request>> call(SendRequestParams params) {
    return repository.sendRequest(params.workerId, params.projectId);
  }
}

class SendRequestParams {
  final int workerId;
  final int projectId;
  SendRequestParams({required this.workerId, required this.projectId});
}
