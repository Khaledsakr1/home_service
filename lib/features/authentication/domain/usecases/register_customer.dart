import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/authentication/domain/entities/customer.dart';
import 'package:home_service/features/authentication/domain/repositories/authentication_repository.dart';

class RegisterCustomer implements UseCase<String, Customer> {
  final AuthenticationRepository repository;

  RegisterCustomer(this.repository);

  @override
  Future<Either<Failure, String>> call(Customer customer) async {
    return await repository.registerCustomer(customer);
  }
}