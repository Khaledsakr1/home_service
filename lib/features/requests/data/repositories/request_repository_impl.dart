import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/request.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/request_repository.dart';
import '../datasources/request_remote_data_source.dart';
import '../model/request_model.dart';
import '../model/review_model.dart';

class RequestRepositoryImpl implements RequestRepository {
  final RequestRemoteDataSource remote;

  RequestRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Request>> sendRequest(int workerId, int projectId) async {
    try {
      final result = await remote.sendRequest(workerId, projectId);
      return Right(RequestModel.fromJson(result));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Request>> cancelRequest(int requestId) async {
    try {
      final result = await remote.cancelRequest(requestId);
      return Right(RequestModel.fromJson(result));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
@override
Future<Either<Failure, List<Request>>> getCustomerRequests({int? status}) async {
  try {
    final result = await remote.getCustomerRequests(status: status);
    return Right(result);
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}

 @override
  Future<Either<Failure, Request>> completeRequest(int requestId) async {
    try {
      final result = await remote.completeRequest(requestId);
      return Right(RequestModel.fromJson(result));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

   @override
  Future<Either<Failure, Review>> addReview(int workerId, String comment, int rating) async {
    try {
      final result = await remote.addReview(workerId, comment, rating);
      return Right(ReviewModel.fromJson(result));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

}
