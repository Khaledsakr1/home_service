// lib/features/worker_settings/domain/usecases/update_worker_profile.dart
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';

import '../repositories/worker_settings_repository.dart';

class UpdateWorkerProfile {
  final WorkerSettingsRepository repository;

  UpdateWorkerProfile(this.repository);

  Future<void> call(WorkerProfileUpdateModel profile) {
    return repository.updateWorkerProfile(profile);
  }
}
