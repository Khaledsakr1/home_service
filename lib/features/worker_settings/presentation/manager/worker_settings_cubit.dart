// lib/features/worker_settings/presentation/manager/worker_settings_cubit.dart
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import 'package:home_service/features/worker_settings/domain/usecases/change_worker_password.dart';
import 'package:home_service/features/worker_settings/domain/usecases/deactivate_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/delete_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile_with_image.dart';
import '../../domain/usecases/fetch_worker_profile.dart';
import '../../domain/usecases/update_worker_profile.dart';
import 'worker_settings_state.dart';

class WorkerSettingsCubit extends Cubit<WorkerSettingsState> {
  final FetchWorkerProfile fetchWorkerProfileUseCase;
  final UpdateWorkerProfile updateWorkerProfileUseCase;
  final UpdateWorkerProfileWithImage updateProfilePictureUseCase;
  final ChangePassword changePasswordUseCase;
  final DeleteAccount deleteAccountUseCase;
  final DeactivateAccount deactivateAccountUseCase;


  WorkerSettingsCubit({
    required this.fetchWorkerProfileUseCase,
    required this.updateWorkerProfileUseCase,
    required this.updateProfilePictureUseCase,
    required this.changePasswordUseCase,
    required this.deleteAccountUseCase,
    required this.deactivateAccountUseCase,
  }) : super(WorkerSettingsInitial());

  Future<void> fetchProfile() async {
    if (isClosed) return;
    emit(WorkerSettingsLoading());
    try {
      final profile = await fetchWorkerProfileUseCase();
      if (isClosed) return;
      emit(WorkerSettingsLoaded(profile));
    } catch (e) {
     if (!isClosed) emit(WorkerSettingsError(e.toString()));
    }
  }

Future<void> updateProfile(WorkerProfileUpdateModel profile) async {
  if (isClosed) return;
  
  emit(WorkerSettingsLoading());
  
  try {
    await updateWorkerProfileUseCase(profile);
    if (isClosed) return;
    
    emit(WorkerSettingsUpdateSuccess());
    if (isClosed) return;
    
    emit(WorkerSettingsLoaded(profile));
    fetchProfile(); // This will have its own isClosed checks
  } catch (e) {
    if (!isClosed) emit(WorkerSettingsError(e.toString()));
  }
}

Future<void> updateProfilePicture(File image) async {
  if (isClosed) return;
  
  emit(WorkerSettingsLoading());
  
  try {
    await updateProfilePictureUseCase(image);
    if (isClosed) return;
    
    emit(WorkerSettingsUpdateSuccess());
    
    // Optionally, refresh the profile
    await fetchProfile(); // This will have its own isClosed checks
  } catch (e) {
    if (!isClosed) emit(WorkerSettingsError(e.toString()));
  }
}

 Future<void> changePassword({
  required String currentPassword,
  required String newPassword,
  required String confirmPassword,
}) async {
  if (isClosed) return;
  
  emit(WorkerSettingsLoading());
  
  try {
    await changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    if (isClosed) return;
    
    emit(WorkerSettingsPasswordChangeSuccess());
  } catch (e) {
    if (!isClosed) emit(WorkerSettingsError(e.toString()));
  }
}

Future<void> deleteAccount() async {
  if (isClosed) return;
  
  emit(WorkerSettingsLoading());
  
  try {
    await deleteAccountUseCase();
    if (isClosed) return;
    
    emit(WorkerSettingsDeleteSuccess());
  } catch (e) {
    if (!isClosed) emit(WorkerSettingsError(e.toString()));
  }
}

Future<void> deactivateAccount() async {
  if (isClosed) return;
  
  emit(WorkerSettingsLoading());
  
  try {
    await deactivateAccountUseCase();
    if (isClosed) return;
    
    emit(WorkerSettingsDeactivateSuccess());
  } catch (e) {
    if (!isClosed) emit(WorkerSettingsError(e.toString()));
  }
}
}
