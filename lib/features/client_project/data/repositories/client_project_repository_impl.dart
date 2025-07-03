import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../domain/entities/client_project.dart';
import '../../domain/repositories/client_project_repository.dart';
import '../datasources/client_project_remote_data_source.dart';
import '../../../../core/error/failures.dart';

class ClientProjectRepositoryImpl implements ClientProjectRepository {
  final ClientProjectRemoteDataSource remote;

  ClientProjectRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, List<ClientProject>>> getProjects() async {
    try {
      final result = await remote.getProjects();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientProject>> getProject(int id) async {
    try {
      final result = await remote.getProject(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientProject>> addProject(Map<String, dynamic> data, List<File> images) async {
    try {
      final result = await remote.addProject(data: data, images: images);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ClientProject>> updateProject(int id, Map<String, dynamic> data) async {
    try {
      final result = await remote.updateProject(id: id, data: data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(int id) async {
    try {
      await remote.deleteProject(id);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addProjectImages(int id, List<File> images) async {
    try {
      await remote.addProjectImages(id, images);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProjectImage(int projectId, int imageId) async {
    try {
      await remote.deleteProjectImage(projectId, imageId);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
