import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/worker_settings/data/datasources/worker_settings_remote_data_source.dart';
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import 'package:home_service/features/worker_settings/data/repositories/worker_settings_repository_impl.dart';
import 'package:home_service/features/worker_settings/domain/usecases/change_worker_password.dart';
import 'package:home_service/features/worker_settings/domain/usecases/deactivate_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/delete_account.dart';
import 'package:home_service/features/worker_settings/domain/usecases/fetch_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile.dart';
import 'package:home_service/features/worker_settings/domain/usecases/update_worker_profile_with_image.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_state.dart';
import 'package:home_service/features/worker_settings/presentation/pages/worker_settings_my_profile_address_edit.dart';

class WorkerSettingsmyprofileAddresses extends StatefulWidget {
  const WorkerSettingsmyprofileAddresses({super.key});

  @override
  State<WorkerSettingsmyprofileAddresses> createState() =>
      _WorkerSettingsmyprofileAddressesState();
}

class _WorkerSettingsmyprofileAddressesState
    extends State<WorkerSettingsmyprofileAddresses> {
  @override
  void initState() {
    super.initState();
    context.read<WorkerSettingsCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Addresses',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<WorkerSettingsCubit, WorkerSettingsState>(
        builder: (context, state) {
          if (state is WorkerSettingsLoading) {
            return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
          }
          if (state is WorkerSettingsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is WorkerSettingsLoaded) {
            final WorkerProfileUpdateModel profile = state.workerProfile;
            // Example parsing. Adjust to your backend data:
            // Assume address: "Nasr City, 15 El Teseen St, 90 St"
            String area= '' ;
            String street = '';
            String subStreet = '';
            if (profile.address != null) {
              // Split by comma and assign
              final parts = profile.address!.split(',');
              area = parts.isNotEmpty ? parts[0].trim() : '';
              street = parts.length > 1 ? parts[1].trim() : '';
              subStreet = profile.buildingNumber ?? '';
            }
            final city = profile.cityName ?? ''; // Replace with actual city if needed

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300, width: 1.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.apartment,
                              size: 20, color: Colors.black87),
                          const SizedBox(width: 8),
                          Text(
                            street,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      if (subStreet.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 28),
                          child: Text(
                            subStreet,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 20, color: Colors.black87),
                          const SizedBox(width: 8),
                          Text(
                            area,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_city,
                              size: 20, color: Colors.black87),
                          const SizedBox(width: 8),
                          Text(
                            city,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton.icon(
                          onPressed: () {
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
                                    changePasswordUseCase: ChangePassword(repo),
                                    deleteAccountUseCase: DeleteAccount(repo),
                                    deactivateAccountUseCase: DeactivateAccount(repo),
                                  ),
                                  child: const WorkerSettingsmyprofileAddressedit(),
                                );
                              }),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(Icons.edit, size: 16, color: Colors.white),
                          label: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
