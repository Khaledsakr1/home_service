import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_state.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/Button.dart';
import 'package:image_picker/image_picker.dart';

class WorkerSettingsmyprofileInformation extends StatefulWidget {
  const WorkerSettingsmyprofileInformation({super.key});

  @override
  State<WorkerSettingsmyprofileInformation> createState() =>
      _WorkerSettingsmyprofileInformationState();
}

class _WorkerSettingsmyprofileInformationState
    extends State<WorkerSettingsmyprofileInformation> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    context.read<WorkerSettingsCubit>().fetchProfile();
  }

  void _populateFieldsFromProfile(WorkerProfileUpdateModel profile) {
    _firstNameController.text = profile.name?.split(' ').first ?? '';
    _lastNameController.text = profile.name?.split(' ').skip(1).join(' ') ?? '';
    _companyNameController.text = profile.companyName ?? '';
    _emailController.text = profile.email ?? '';
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _companyNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final updateModel = WorkerProfileUpdateModel(
      name:
          '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
      companyName: _companyNameController.text.trim().isEmpty
          ? null
          : _companyNameController.text.trim(),
      email: _emailController.text,
      // Add more fields if needed
    );
    print('Update JSON: ${updateModel.toJson()}'); // <-- Only this line changed
    context.read<WorkerSettingsCubit>().updateProfile(updateModel);
    if (_pickedImage != null) {
      await context
          .read<WorkerSettingsCubit>()
          .updateProfilePicture(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Profile Information',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocConsumer<WorkerSettingsCubit, WorkerSettingsState>(
        listener: (context, state) {
          if (state is WorkerSettingsUpdateSuccess) {
            showCustomOverlayMessage(
              context,
              message: 'Profile updated successfully',
              subMessage: 'Your profile information has been saved.',
            );
          } else if (state is WorkerSettingsError) {
            showErrorOverlayMessage(
              context,
              errorMessage: 'Error updating profile',
              subMessage: state.message,
            );
          }
          if (state is WorkerSettingsLoaded) {
            _populateFieldsFromProfile(state.workerProfile);
          }
        },
        builder: (context, state) {
          if (state is WorkerSettingsLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          } else if (state is WorkerSettingsError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(height: 16),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.grey.shade200,
                      child: ClipOval(
                        child: _pickedImage != null
                            ? Image.file(
                                _pickedImage!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : (state is WorkerSettingsLoaded &&
                                    state.workerProfile.profilePictureUrl !=
                                        null)
                                ? Image.network(
                                    state.workerProfile.profilePictureUrl!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/images/Image.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/images/Image.png',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: kPrimaryColor,
                        child: Icon(Icons.camera_alt,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Textfield(
                title: 'First name',
                headtextfield: 'Enter your first name',
                controller: _firstNameController,
              ),
              const SizedBox(height: 7),
              Textfield(
                title: 'Last name',
                headtextfield: 'Enter your last name',
                controller: _lastNameController,
              ),
              const SizedBox(height: 7),
              Textfield(
                title: 'Company name',
                headtextfield: 'Enter your company name',
                controller: _companyNameController,
              ),
              const SizedBox(height: 4),
              const Text(
                'This is your public profile name.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 7),
              Textfield(
                title: 'Email address',
                headtextfield: 'Enter your email',
                readOnly: true,
                controller: _emailController,
                // enabled: false, // Email is usually read-only
              ),
              const SizedBox(height: 20),
              Button(
                title: 'Save',
                ontap: _saveProfile,
              ),
            ],
          );
        },
      ),
    );
  }
}
