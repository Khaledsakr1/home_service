import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/worker_settings/data/datasources/worker_settings_remote_data_source.dart';
import 'package:home_service/features/worker_settings/data/repositories/worker_settings_repository_impl.dart';
import 'package:home_service/features/worker_settings/domain/usecases/change_worker_password.dart';
import 'package:home_service/features/worker_settings/domain/usecases/deactivate_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/delete_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/fetch_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile_with_image.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_data_and_privacy_deactivate_acc.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_data_and_privacy_delete_acc.dart';
import 'package:home_service/widgets/Optiontile.dart';

class WorkerSettingsdataandprivacy extends StatelessWidget {
  const WorkerSettingsdataandprivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Data and privacy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              OptionTile(
                title: 'Deactivate my account',
                subtitle:
                    'Temporarily deactivate your profile without losing your data. You can reactivate at any time.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      final repo = WorkerSettingsRepositoryImpl(
                        remoteDataSource: WorkerSettingsRemoteDataSourceImpl(),
                      );
                      return BlocProvider(
                        create: (_) => WorkerSettingsCubit(
                          fetchWorkerProfileUseCase: FetchWorkerProfile(repo),
                          updateWorkerProfileUseCase: UpdateWorkerProfile(repo),
                          updateProfilePictureUseCase:
                              UpdateWorkerProfileWithImage(repo),
                          changePasswordUseCase: ChangePassword(repo),
                          deleteAccountUseCase: DeleteAccount(repo),
                          deactivateAccountUseCase: DeactivateAccount(repo),
                        ),
                        child:
                            const WorkerSettingsDataAndPrivacyDeactivateAcc(),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 12),
              OptionTile(
                title: 'Delete my account',
                subtitle: 'Permanently delete all your data.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      final repo = WorkerSettingsRepositoryImpl(
                        remoteDataSource: WorkerSettingsRemoteDataSourceImpl(),
                      );
                      return BlocProvider(
                        create: (_) => WorkerSettingsCubit(
                          fetchWorkerProfileUseCase: FetchWorkerProfile(repo),
                          updateWorkerProfileUseCase: UpdateWorkerProfile(repo),
                          updateProfilePictureUseCase:
                              UpdateWorkerProfileWithImage(repo),
                          changePasswordUseCase: ChangePassword(repo),
                          deleteAccountUseCase: DeleteAccount(repo),
                          deactivateAccountUseCase: DeactivateAccount(repo),
                        ),
                        child: const WorkerSettingsDataAndPrivacyDeleteAcc(),
                      );
                    }),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
