import 'package:home_service/features/worker_settings/domain/repositories/worker_settings_repository.dart';

class ChangePassword {
  final WorkerSettingsRepository repository;
  ChangePassword(this.repository);

  Future<void> call({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    return repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
