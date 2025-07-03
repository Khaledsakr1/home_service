import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/client_project.dart';
import '../../domain/usecases/add_project.dart';
import '../../domain/usecases/delete_project.dart';
import '../../domain/usecases/get_projects.dart';
import '../../domain/usecases/get_project.dart';
import '../../domain/usecases/update_project.dart';
import '../../domain/usecases/add_project_images.dart';
import '../../domain/usecases/delete_project_image.dart';
import '../../../../core/usecases/usecase.dart';

part 'client_project_state.dart';

class ClientProjectCubit extends Cubit<ClientProjectState> {
  final AddProject addProjectUseCase;
  final UpdateProject updateProjectUseCase;
  final GetProjects getProjectsUseCase;
  final GetProject getProjectUseCase;
  final DeleteProject deleteProjectUseCase;
  final AddProjectImages addProjectImagesUseCase;
  final DeleteProjectImage deleteProjectImageUseCase;

  ClientProjectCubit({
    required this.addProjectUseCase,
    required this.updateProjectUseCase,
    required this.getProjectsUseCase,
    required this.getProjectUseCase,
    required this.deleteProjectUseCase,
    required this.addProjectImagesUseCase,
    required this.deleteProjectImageUseCase,
  }) : super(ClientProjectInitial());

  Future<void> getProjects() async {
    emit(ClientProjectLoading());
    final result = await getProjectsUseCase(NoParams());
    result.fold(
      (failure) => emit(ClientProjectError(failure.message ?? "Error loading projects")),
      (projects) => emit(ClientProjectsLoaded(projects)),
    );
  }

  Future<void> getProject(int id) async {
    emit(ClientProjectLoading());
    final result = await getProjectUseCase(id);
    result.fold(
      (failure) => emit(ClientProjectError(failure.message ?? "Error loading project")),
      (project) => emit(ClientProjectLoaded(project)),
    );
  }

  Future<void> addProject(Map<String, dynamic> data, List<File> images) async {
    emit(ClientProjectLoading());
    final result = await addProjectUseCase(AddProjectParams(data: data, images: images));
    result.fold(
      (failure) => emit(ClientProjectError(failure.message ?? "Error adding project")),
      (project) => emit(ClientProjectActionSuccess('Project added')),
    );
  }

  Future<void> updateProject(int id, Map<String, dynamic> data) async {
    emit(ClientProjectLoading());
    final result = await updateProjectUseCase(UpdateProjectParams(id: id, data: data));
    result.fold(
      (failure) => emit(ClientProjectError(failure.message ?? "Error updating project")),
      (project) => emit(ClientProjectActionSuccess('Project updated')),
    );
  }

  Future<void> deleteProject(int id) async {
    emit(ClientProjectLoading());
    final result = await deleteProjectUseCase(id);
    result.fold(
      (failure) => emit(ClientProjectError(failure.message ?? "Error deleting project")),
      (_) => emit(ClientProjectActionSuccess('Project deleted')),
    );
  }

  Future<void> addProjectImages(int id, List<File> images) async {
    emit(ClientProjectLoading());
    final result = await addProjectImagesUseCase(AddProjectImagesParams(id: id, images: images));
    result.fold(
      (failure) => emit(ClientProjectError(failure.message ?? "Error adding images")),
      (_) => emit(ClientProjectActionSuccess('Images added')),
    );
  }

  Future<void> deleteProjectImage(int projectId, int imageId) async {
    emit(ClientProjectLoading());
    final result = await deleteProjectImageUseCase(DeleteProjectImageParams(projectId: projectId, imageId: imageId));
    result.fold(
      (failure) => emit(ClientProjectError(failure.message ?? "Error deleting image")),
      (_) => emit(ClientProjectActionSuccess('Image deleted')),
    );
  }
}
