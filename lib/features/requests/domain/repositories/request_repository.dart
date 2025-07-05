import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/request.dart';

abstract class RequestRepository {
  Future<Either<Failure, Request>> sendRequest(int workerId, int projectId);
  Future<Either<Failure, Request>> cancelRequest(int requestId);
  Future<Either<Failure, List<Request>>> getCustomerRequests({int? status});
  Future<Either<Failure, Request>> completeRequest(int requestId);
}
