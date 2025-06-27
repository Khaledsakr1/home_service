import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:home_service/features/authentication/data/models/customer_model.dart';
import 'package:home_service/features/authentication/data/models/worker_model.dart';
import 'package:home_service/features/authentication/domain/entities/customer.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:home_service/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> registerCustomer(Customer customer) async {
    try {
      final result =
          await remoteDataSource.registerCustomer(customer as CustomerModel);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailExists(String email) async {
    try {
      final result = await remoteDataSource.checkEmailExists(email);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> loginUser(
      String email, String password) async {
    try {
      final result = await remoteDataSource.loginUser(email, password);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> registerWorker(
      Worker worker, String? profilePicturePath) async {
    try {
      final result = await remoteDataSource.registerWorker(
          worker as WorkerModel, profilePicturePath);
      return Right(result);
    } catch (e) {
      print('AuthenticationRepository.registerWorker error: $e');
      // Return more specific error message
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
