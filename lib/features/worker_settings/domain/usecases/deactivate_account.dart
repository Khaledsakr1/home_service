import 'package:home_service/features/worker_settings/domain/repositories/worker_settings_repository.dart';

class DeactivateAccount {
  final WorkerSettingsRepository repository;
  DeactivateAccount(this.repository);
  Future<void> call() => repository.deactivateAccount();
}