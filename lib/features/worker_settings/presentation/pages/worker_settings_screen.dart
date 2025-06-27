import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/utils/clear_token.dart';
import 'package:home_service/features/authentication/presentation/pages/login_as_worker_page.dart';
import 'package:home_service/features/worker_settings/data/datasources/worker_settings_remote_data_source.dart';
import 'package:home_service/features/worker_settings/data/repositories/worker_settings_repository_impl.dart';
import 'package:home_service/features/worker_settings/domain/usecases/change_worker_password.dart';
import 'package:home_service/features/worker_settings/domain/usecases/deactivate_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/delete_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/fetch_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile_with_image.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_change_password.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_data_and_privacy.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_my_profile.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_notification.dart';
import 'package:home_service/widgets/Optiontile.dart';

class WorkerSettingsscreen extends StatelessWidget {
  const WorkerSettingsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile_default.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Khaled Sakr',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          OptionTile(
            leadingIcon: Icons.person,
            title: 'My Profile',
            subtitle:
                'Edit your profile picture, name, email, phone number and Location',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WorkerSettingsmyprofile()),
              );
            },
          ),
          const SizedBox(height: 12),
          OptionTile(
            leadingIcon: Icons.lock_reset,
            title: 'Change Password',
            subtitle: 'Update and manage your password.',
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
                    child: const WorkerSettingschangepassword(),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 12),
          OptionTile(
            leadingIcon: Icons.notifications,
            title: 'Notification',
            subtitle:
                'Choose notification preferences and how you want to be contacted.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WorkerSettingsnotification()),
              );
            },
          ),
          const SizedBox(height: 12),
          OptionTile(
            leadingIcon: Icons.privacy_tip,
            title: 'Data and Privacy',
            subtitle: 'Protect and delete your account.',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WorkerSettingsdataandprivacy()),
              );
            },
          ),
          const SizedBox(height: 12),
          OptionTile(
            leadingIcon: Icons.logout,
            title: 'Logout',
            subtitle: 'Logout from your account.',
            onTap: () async {
              await clearTokenOnLogout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginAsWorker.id,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
