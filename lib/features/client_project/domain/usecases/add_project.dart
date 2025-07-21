import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/client_project.dart';
import '../repositories/client_project_repository.dart';
import 'package:equatable/equatable.dart';

class AddProject implements UseCase<ClientProject, AddProjectParams> {
  final ClientProjectRepository repository;

  AddProject(this.repository);

  @override
  Future<Either<Failure, ClientProject>> call(AddProjectParams params) {
    return repository.addProject(params.data, params.images);
  }
}

class AddProjectParams extends Equatable {
  final Map<String, dynamic> data;
  final List<File> images;

  const AddProjectParams({required this.data, required this.images});

  @override
  List<Object?> get props => [data, images];
}
