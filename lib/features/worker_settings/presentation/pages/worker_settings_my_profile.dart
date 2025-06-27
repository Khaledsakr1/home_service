import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/worker_settings/data/datasources/worker_settings_remote_data_source.dart';
import 'package:home_service/features/worker_settings/data/repositories/worker_settings_repository_impl.dart';
import 'package:home_service/features/worker_settings/domain/usecases/change_worker_password.dart';
import 'package:home_service/features/worker_settings/domain/usecases/fetch_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile_with_image.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_my_profile_address.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_my_profile_information.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_my_profile_mobile_number.dart';
import 'package:home_service/widgets/Optiontile.dart';

class WorkerSettingsmyprofile extends StatelessWidget {
  const WorkerSettingsmyprofile({super.key});

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
          'My Profile',
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
                title: 'Profile information',
                subtitle:
                    'Edit your profile picture, name, surname, and email.',
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
                          updateProfilePictureUseCase: UpdateWorkerProfileWithImage(repo),
                           changePasswordUseCase: ChangePassword(repo)
                        ),
                        child: const WorkerSettingsmyprofileInformation(),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 12),
              OptionTile(
                title: 'Mobile phone number',
                subtitle: 'Modify your mobile phone number',
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
                          updateProfilePictureUseCase: UpdateWorkerProfileWithImage(repo),
                           changePasswordUseCase: ChangePassword(repo)
                        ),
                        child: const WorkerSettingsmyprofileMobilenumber(),
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 12),
              OptionTile(
                title: 'Address Preferences',
                subtitle: 'Edit your address preference',
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
                          updateProfilePictureUseCase: UpdateWorkerProfileWithImage(repo),
                           changePasswordUseCase: ChangePassword(repo)
                        ),
                        child: const WorkerSettingsmyprofileAddresses(),
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
