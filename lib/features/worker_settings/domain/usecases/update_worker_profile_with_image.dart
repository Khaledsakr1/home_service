// domain/usecases/update_worker_profile_with_image.dart
import 'dart:io';
import '../repositories/worker_settings_repository.dart';

class UpdateWorkerProfileWithImage {
  final WorkerSettingsRepository repository;

  UpdateWorkerProfileWithImage(this.repository);

  Future<void> call(File image) {
    return repository.updateProfilePicture(image);
  }
}
