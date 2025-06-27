// domain/usecases/update_worker_profile_with_image.dart
import 'dart:io';
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import '../repositories/worker_settings_repository.dart';

class UpdateWorkerProfileWithImage {
  final WorkerSettingsRepository repository;

  UpdateWorkerProfileWithImage(this.repository);

  Future<void> call(File image) {
    return repository.updateProfilePicture(image);
  }
}
