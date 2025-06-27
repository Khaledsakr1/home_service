
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/core/usecases/usecase.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/domain/repositories/service_repository.dart';

class GetServices implements UseCase<List<Service>, NoParams> {
  final ServiceRepository repository;

  GetServices(this.repository);

  @override
  Future<Either<Failure, List<Service>>> call(NoParams params) async {
    return await repository.getServices();
  }
}


