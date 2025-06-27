import 'package:home_service/features/worker_settings/domain/repositories/worker_settings_repository.dart';

class DeleteAccount {
  final WorkerSettingsRepository repository;
  DeleteAccount(this.repository);

  Future<void> call() {
    return repository.deleteAccount();
  }
}
