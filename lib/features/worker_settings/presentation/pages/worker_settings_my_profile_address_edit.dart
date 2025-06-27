import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/features/worker_settings/data/model/worker_update.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_cubit.dart';
import 'package:home_service/features/worker_settings/presentation/manager/worker_settings_state.dart';
import 'package:home_service/widgets/Dropdown.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/Button.dart';

class City {
  final int id;
  final String name;
  City({required this.id, required this.name});
}

class WorkerSettingsmyprofileAddressedit extends StatefulWidget {
  const WorkerSettingsmyprofileAddressedit({super.key});

  @override
  State<WorkerSettingsmyprofileAddressedit> createState() =>
      _WorkerSettingsmyprofileAddresseditState();
}

class _WorkerSettingsmyprofileAddresseditState
    extends State<WorkerSettingsmyprofileAddressedit> {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  City? selectedCity;
  String? errorText;

  final List<City> cities = [
    City(id: 1, name: 'Cairo'),
    City(id: 2, name: 'Alexandria'),
    City(id: 3, name: 'Giza'),
    City(id: 4, name: 'Ismailia'),
    City(id: 5, name: 'Aswan'),
    City(id: 6, name: 'Mansoura'),
    City(id: 7, name: 'Tanta'),
    City(id: 8, name: 'Port Said'),
    City(id: 9, name: 'Suez'),
    City(id: 10, name: 'Sharm El Sheikh'),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch profile from backend using Cubit/Bloc
    context.read<WorkerSettingsCubit>().fetchProfile();
  }

  @override
  void dispose() {
    cityController.dispose();
    streetController.dispose();
    buildingController.dispose();
    super.dispose();
  }

  // Populate controllers and selected city when profile is loaded
void _populateFieldsFromProfile(WorkerProfileUpdateModel profile) {
  // Parse address as before
  final address = profile.address ?? '';
  final parts = address.split(',');
  cityController.text = parts.isNotEmpty ? parts[0].trim() : '';
  streetController.text = parts.length > 1 ? parts[1].trim() : '';
  buildingController.text = profile.buildingNumber ?? '';

  // Match cityName from API with local cities list
  if (profile.cityName != null && profile.cityName!.isNotEmpty) {
    try {
      selectedCity = cities.firstWhere(
        (c) => c.name.toLowerCase() == profile.cityName!.toLowerCase(),
      );
    } catch (e) {
      selectedCity = null;
    }
  }
  setState(() {});
}



  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        errorText = 'Please fill all fields correctly.';
      });
      return;
    }
    errorText = null;
    // Update address via Cubit (and backend)
    context.read<WorkerSettingsCubit>().updateProfile(
      WorkerProfileUpdateModel(
        cityId: selectedCity?.id,
        address: '${cityController.text.trim()}, ${streetController.text.trim()}',
        buildingNumber: buildingController.text.trim(),
      ),
    );
    // Optionally, you can pop or show a message when update succeeds (handle in Cubit listener).
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
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Address Preferences',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocConsumer<WorkerSettingsCubit, WorkerSettingsState>(
        listener: (context, state) {
          if (state is WorkerSettingsLoaded) {
            _populateFieldsFromProfile(state.workerProfile);
          }
          if (state is WorkerSettingsUpdateSuccess) {
            showCustomOverlayMessage(context, message: 'Success', subMessage: 'Your address has been updated successfully.');
            // Optionally pop after update:
            // Navigator.pop(context);
          }
          if (state is WorkerSettingsError) {
            setState(() {
              errorText = state.message;
            });
          }
        },
        builder: (context, state) {
          if (state is WorkerSettingsLoading) {
            return const Center(child: CircularProgressIndicator(color: kPrimaryColor));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const Text(
                    'Your address',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your address is used to send you job opportunities nearest to you.',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  CustomDropdown<City>(
                  items: cities,
                  selectedItem: selectedCity,
                  onChanged: (value) => setState(() => selectedCity = value),
                  getName: (city) => city.name,
                  label: 'Select your Governoment',
                  title: 'Governoment',
                ),
                  const SizedBox(height: 20),
                  Textfield(
                    title: 'City',
                    headtextfield: 'Enter your city name',
                    controller: cityController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 20),
                  Textfield(
                    title: 'Street name',
                    headtextfield: 'Enter your street name',
                    controller: streetController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 20),
                  Textfield(
                    title: 'Building number',
                    headtextfield: 'Enter your building number',
                    controller: buildingController,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  if (errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        errorText!,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ),
                  const SizedBox(height: 40),
                  Button(
                    title: 'Save',
                    ontap: _saveAddress,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
