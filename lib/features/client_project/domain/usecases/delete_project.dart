import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/client_project_repository.dart';

class DeleteProject implements UseCase<void, int> {
  final ClientProjectRepository repository;
  DeleteProject(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) {
    return repository.deleteProject(id);
  }
}
