import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/authentication/domain/entities/customer.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, String>> registerCustomer(Customer customer);
  Future<Either<Failure, bool>> checkEmailExists(String email);
  Future<Either<Failure, Map<String, dynamic>>> loginUser(String email, String password);
  Future<Either<Failure, String>> registerWorker(Worker worker, String? profilePicturePath);
}


