import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/authentication/data/models/worker_model.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:home_service/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:home_service/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/features/worker_home/presentation/pages/SuceesScreenAsWorker.dart';
import 'package:home_service/widgets/Dropdown.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WorkerDetailsPage extends StatefulWidget {
  const WorkerDetailsPage({super.key});
  static String id = 'workerDetailsPage';

  @override
  State<WorkerDetailsPage> createState() => _WorkerDetailsPageState();
}

class _WorkerDetailsPageState extends State<WorkerDetailsPage> {
  final TextEditingController jobTypeController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Service? selectedService;
  List<Service> services = [];
  bool isLoading = false;

  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    context.read<ServicesCubit>().fetchServices();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Worker? worker =
        ModalRoute.of(context)!.settings.arguments as Worker?;
    if (worker == null)
      return const Scaffold(body: Center(child: Text("Missing data")));

    return MultiBlocListener(
      listeners: [
        BlocListener<ServicesCubit, ServicesState>(
          listener: (context, state) {
            if (state is ServicesLoaded) {
              setState(() {
                services = state.services;
              });
            } else if (state is ServicesError) {
              showErrorOverlayMessage(context, errorMessage: state.message);
            }
          },
        ),
        BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is AuthenticationSuccess) {
              final token =
                  state.message; // Assuming the token is in the message

              setState(() {
                isLoading = false;
              });
              // Assuming the token is returned in the message for now
              // In a real app, you'd parse the token and store it securely
              PortfolioRemoteDataSourceImpl.authToken = token;
              // This line needs to be handled by a proper auth manager
              Navigator.pushNamedAndRemoveUntil(
                  context, SuceesscreenasWorker.id, (route) => false);
            } else if (state is AuthenticationError) {
              setState(() {
                isLoading = false;
              });
              showErrorOverlayMessage(context, errorMessage: state.message);
            }
          },
        ),
      ],
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.green,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _pickedImage != null
                                ? FileImage(_pickedImage!)
                                : const AssetImage(
                                        'assets/images/profile_default.png')
                                    as ImageProvider,
                          ),
                          const CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.camera_alt,
                                size: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'details',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                    const SizedBox(height: 20),
                    services.isEmpty
                        ? const CircularProgressIndicator()
                        : CustomDropdown<Service>(
                            items: services,
                            selectedItem: selectedService,
                            onChanged: (value) =>
                                setState(() => selectedService = value),
                            getName: (service) => service.name,
                            label: 'Select Job Type',
                            title: 'Job Type',
                          ),
                    const SizedBox(height: 20),
                    Textfield(
                      title: 'Experience years',
                      headtextfield: 'Enter your years of experience',
                      controller: experienceController,
                      inputType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Field';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Textfield(
                      title: 'About you',
                      headtextfield: 'Tell us about yourself',
                      controller: aboutController,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Button(
                          title: 'submit',
                          ontap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (selectedService == null) {
                                showErrorOverlayMessage(context,
                                    errorMessage: 'Please select a job type');
                                return;
                              }
                              final updatedWorker = WorkerModel(
                                email: worker.email,
                                password: worker.password,
                                confirmPassword: worker
                                    .confirmPassword, // add this if required
                                fullName: worker.fullName,
                                phoneNumber: worker.phoneNumber,
                                address: worker.address,
                                buildingNumber: worker.buildingNumber,
                                cityId: worker.cityId,
                                experienceYears:
                                    int.tryParse(experienceController.text)!,
                                description: aboutController.text,
                                serviceId: selectedService!.id,
                                profilePictureUrl: _pickedImage?.path,
                                companyName: worker.companyName,
                              );

                              context
                                  .read<AuthenticationCubit>()
                                  .registerWorker(
                                      updatedWorker, _pickedImage?.path);
                            }
                          }),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
