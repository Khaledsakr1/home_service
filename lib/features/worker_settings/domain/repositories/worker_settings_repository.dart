// lib/features/worker_settings/domain/repositories/worker_settings_repository.dart
import 'dart:io';

import 'package:home_service/features/worker_settings/data/model/worker_update.dart';

abstract class WorkerSettingsRepository {
  Future<WorkerProfileUpdateModel> fetchWorkerProfile();
  Future<void> updateWorkerProfile(WorkerProfileUpdateModel profile);
  Future<void> updateProfilePicture(File image);

}
