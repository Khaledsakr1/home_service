// lib/features/worker_settings/data/repositories/worker_settings_repository_impl.dart

import 'dart:io';

import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import '../../domain/repositories/worker_settings_repository.dart';
import '../datasources/worker_settings_remote_data_source.dart';

class WorkerSettingsRepositoryImpl implements WorkerSettingsRepository {
  final WorkerSettingsRemoteDataSource remoteDataSource;

  WorkerSettingsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WorkerProfileUpdateModel> fetchWorkerProfile() {
    return remoteDataSource.fetchWorkerProfile();
  }

  @override
  Future<void> updateWorkerProfile(WorkerProfileUpdateModel profile) {
    return remoteDataSource.updateWorkerProfile(profile);
  }

  @override
Future<void> updateProfilePicture(File image) {
  return remoteDataSource.updateProfilePicture(image);
}

@override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
