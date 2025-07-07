import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/request.dart';

abstract class WorkerRequestRepository {
  Future<Either<Failure, List<Request>>> getReceivedRequests({int? status});
  Future<Either<Failure, Request>> acceptRequest(int requestId, double price);
  Future<Either<Failure, Request>> rejectRequest(int requestId);
}