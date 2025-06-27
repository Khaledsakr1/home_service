// lib/features/worker_settings/presentation/manager/worker_settings_state.dart
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';

abstract class WorkerSettingsState {}

class WorkerSettingsInitial extends WorkerSettingsState {}

class WorkerSettingsLoading extends WorkerSettingsState {}

class WorkerSettingsLoaded extends WorkerSettingsState {
  final WorkerProfileUpdateModel workerProfile;
  WorkerSettingsLoaded(this.workerProfile);
}

class WorkerSettingsUpdateSuccess extends WorkerSettingsState {}

class WorkerSettingsError extends WorkerSettingsState {
  final String message;
  WorkerSettingsError(this.message);
}
