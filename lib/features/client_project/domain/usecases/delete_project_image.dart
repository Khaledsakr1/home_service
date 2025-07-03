import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/client_project_repository.dart';

class DeleteProjectImage implements UseCase<void, DeleteProjectImageParams> {
  final ClientProjectRepository repository;
  DeleteProjectImage(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteProjectImageParams params) {
    return repository.deleteProjectImage(params.projectId, params.imageId);
  }
}

class DeleteProjectImageParams extends Equatable {
  final int projectId;
  final int imageId;
  const DeleteProjectImageParams({required this.projectId, required this.imageId});

  @override
  List<Object?> get props => [projectId, imageId];
}
