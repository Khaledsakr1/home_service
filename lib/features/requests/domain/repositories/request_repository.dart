import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/request.dart';
import '../entities/review_entity.dart';

abstract class RequestRepository {
  Future<Either<Failure, Request>> sendRequest(int workerId, int projectId);
  Future<Either<Failure, Request>> cancelRequest(int requestId);
  Future<Either<Failure, List<Request>>> getCustomerRequests({int? status});
  Future<Either<Failure, Request>> completeRequest(int requestId);
  Future<Either<Failure, Review>> addReview(int workerId, String comment, int rating); 
}
