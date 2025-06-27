import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_state.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/Button.dart';

class WorkerSettingsmyprofileMobilenumber extends StatefulWidget {
  const WorkerSettingsmyprofileMobilenumber({super.key});

  @override
  State<WorkerSettingsmyprofileMobilenumber> createState() =>
      _WorkerSettingsmyprofileMobilenumberState();
}

class _WorkerSettingsmyprofileMobilenumberState
    extends State<WorkerSettingsmyprofileMobilenumber> {
  final TextEditingController phoneController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String countryCode = "+20";

  @override
  void initState() {
    super.initState();
    context.read<WorkerSettingsCubit>().fetchProfile();
  }

void _populateFieldsFromProfile(WorkerProfileUpdateModel profile) {
  phoneController.text = stripCountryCode(profile.phoneNumber ?? '');
}


  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

Future<void> _savePhone() async {
    if (!_formKey.currentState!.validate()) {
    // Invalid! Do NOT save
    return;
  }

  final phoneWithCountry = '+20${phoneController.text.trim()}';
  final updateModel = WorkerProfileUpdateModel(
    phoneNumber: phoneWithCountry,
    // ...other unchanged fields if necessary
  );
  context.read<WorkerSettingsCubit>().updateProfile(updateModel);
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
          'Mobile phone number',
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
            showCustomOverlayMessage(context, message: 'Phone number updated successfully');
          } else if (state is WorkerSettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
          if (state is WorkerSettingsLoaded) {
            _populateFieldsFromProfile(state.workerProfile);
          }
        },
        builder: (context, state) {
          if (state is WorkerSettingsLoading) {
            return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
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
              const Text(
                'Your phone number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your number is only displayed to customers you respond to and to the logo. '
                'If you want to change it, we\'ll send you a text message to verify it.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 24),
      Form(
              key: _formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Styled +20 Container
                  Container(
                    height: 58,
                    margin: const EdgeInsets.only(top: 0), // adjust if needed
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Text(
                          '+20',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Textfield(
                      controller: phoneController,
                      title: 'Phone Number',
                      headtextfield: 'Enter your phone number',
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                        if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
              const SizedBox(height: 380),
              Button(
                title: 'Save',
                ontap: _savePhone,
              ),
            ],
          );
        },
      ),
    );
  }
}


String stripCountryCode(String phone) {
  if (phone.startsWith('+20')) {
    return phone.substring(3);
  } else if (phone.startsWith('0020')) {
    return phone.substring(4);
  }
  return phone;
}
