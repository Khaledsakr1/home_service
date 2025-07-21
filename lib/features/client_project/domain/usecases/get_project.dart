import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/client_project.dart';
import '../repositories/client_project_repository.dart';

class GetProject implements UseCase<ClientProject, int> {
  final ClientProjectRepository repository;
  GetProject(this.repository);

  @override
  Future<Either<Failure, ClientProject>> call(int id) {
    return repository.getProject(id);
  }
}
