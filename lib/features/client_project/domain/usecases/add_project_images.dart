import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/client_project_repository.dart';

class AddProjectImages implements UseCase<void, AddProjectImagesParams> {
  final ClientProjectRepository repository;
  AddProjectImages(this.repository);

  @override
  Future<Either<Failure, void>> call(AddProjectImagesParams params) {
    return repository.addProjectImages(params.id, params.images);
  }
}

class AddProjectImagesParams extends Equatable {
  final int id;
  final List<File> images;
  const AddProjectImagesParams({required this.id, required this.images});

  @override
  List<Object?> get props => [id, images];
}
