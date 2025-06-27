
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:home_service/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class RegisterWorker implements UseCase<String, RegisterWorkerParams> {
  final AuthenticationRepository repository;

  RegisterWorker(this.repository);

  @override
  Future<Either<Failure, String>> call(RegisterWorkerParams params) async {
    return await repository.registerWorker(params.worker, params.profilePicturePath);
  }
}

class RegisterWorkerParams extends Equatable {
  final Worker worker;
  final String? profilePicturePath;

  const RegisterWorkerParams({required this.worker, this.profilePicturePath});

  @override
  List<Object?> get props => [worker, profilePicturePath];
}