import 'dart:io';
import 'package:dartz/dartz.dart';
import '../entities/client_project.dart';
import '../../../../core/error/failures.dart';

abstract class ClientProjectRepository {
  Future<Either<Failure, List<ClientProject>>> getProjects();
  Future<Either<Failure, ClientProject>> getProject(int id);
  Future<Either<Failure, ClientProject>> addProject(Map<String, dynamic> data, List<File> images);
  Future<Either<Failure, ClientProject>> updateProject(int id, Map<String, dynamic> data);
  Future<Either<Failure, void>> deleteProject(int id);
  Future<Either<Failure, void>> addProjectImages(int id, List<File> images);
  Future<Either<Failure, void>> deleteProjectImage(int projectId, int imageId);
}
