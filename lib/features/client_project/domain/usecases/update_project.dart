import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/client_project.dart';
import '../repositories/client_project_repository.dart';

class UpdateProject implements UseCase<ClientProject, UpdateProjectParams> {
  final ClientProjectRepository repository;
  UpdateProject(this.repository);

  @override
  Future<Either<Failure, ClientProject>> call(UpdateProjectParams params) {
    return repository.updateProject(params.id, params.data);
  }
}

class UpdateProjectParams extends Equatable {
  final int id;
  final Map<String, dynamic> data;
  const UpdateProjectParams({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}
