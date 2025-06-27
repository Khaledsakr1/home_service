import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/authentication/domain/repositories/authentication_repository.dart';

class CheckEmailExists implements UseCase<bool, String> {
  final AuthenticationRepository repository;

  CheckEmailExists(this.repository);

  @override
  Future<Either<Failure, bool>> call(String email) async {
    return await repository.checkEmailExists(email);
  }
}


