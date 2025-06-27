// lib/features/worker_settings/domain/usecases/fetch_worker_profile.dart
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import '../repositories/worker_settings_repository.dart';

class FetchWorkerProfile {
  final WorkerSettingsRepository repository;

  FetchWorkerProfile(this.repository);

  Future<WorkerProfileUpdateModel> call() {
    return repository.fetchWorkerProfile();
  }
}
