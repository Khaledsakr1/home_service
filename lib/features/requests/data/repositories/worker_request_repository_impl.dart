import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/request.dart';
import '../../domain/repositories/worker_request_repository.dart';
import '../datasources/worker_request_remote_data_source.dart';

class WorkerRequestRepositoryImpl implements WorkerRequestRepository {
  final WorkerRequestRemoteDataSource remote;

  WorkerRequestRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<Request>>> getReceivedRequests({int? status}) async {
    try {
      final result = await remote.getReceivedRequests(status: status);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Request>> acceptRequest(int requestId, double price) async {
    try {
      final result = await remote.acceptRequest(requestId, price);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Request>> rejectRequest(int requestId) async {
    try {
      final result = await remote.rejectRequest(requestId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
