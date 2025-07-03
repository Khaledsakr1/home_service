import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/client_project.dart';
import '../repositories/client_project_repository.dart';

class GetProjects implements UseCase<List<ClientProject>, NoParams> {
  final ClientProjectRepository repository;
  GetProjects(this.repository);

  @override
  Future<Either<Failure, List<ClientProject>>> call(NoParams params) {
    return repository.getProjects();
  }
}
