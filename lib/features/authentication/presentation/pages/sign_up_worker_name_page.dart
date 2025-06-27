import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/authentication/data/models/worker_model.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:home_service/features/authentication/presentation/pages/phone_number_worker.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class SignUpWorkerPage extends StatefulWidget {
  const SignUpWorkerPage({super.key});
  static String id = 'workerNameSignupage';

  @override
  State<SignUpWorkerPage> createState() => _SignUpWorkerPageState();
}

class _SignUpWorkerPageState extends State<SignUpWorkerPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Worker? worker =
        ModalRoute.of(context)!.settings.arguments as Worker?;
    if (worker == null)
      return const Scaffold(body: Center(child: Text("Missing data")));

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                ksignup,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter your name',
                  style: TextStyle(
                    fontSize: 25,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Textfield(
                title: "First Name",
                headtextfield: "Enter your first name",
                controller: firstNameController,
              ),
              const SizedBox(height: 15),
              Textfield(
                title: "Last Name",
                headtextfield: "Enter your Last Name",
                controller: lastNameController,
              ),
              const SizedBox(height: 20),
              Textfield(
                title: "Company Name (Optional)",
                headtextfield: "Enter your Company Name",
                controller: companyNameController,
                validator: (_) => null,
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 5),
                alignment: Alignment.topLeft,
                child: Text(
                  "Please enter your company name if exists.",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Button(
                    title: "Continue",
                    ontap: () {
                      if (_formKey.currentState!.validate()) {
                        final updatedWorker = WorkerModel(
                          email: worker.email,
                          password: worker.password,
                          confirmPassword: worker
                              .password, // assuming confirmPassword same as password here
                          fullName:
                              '${firstNameController.text} ${lastNameController.text}',

                          phoneNumber: worker.phoneNumber,
                          address: worker.address,
                          profilePictureUrl: worker.profilePictureUrl ?? '',

                          serviceId: worker.serviceId,
                          description: worker.description,
                          companyName: companyNameController.text.isNotEmpty
                              ? companyNameController.text
                              : null,
                          buildingNumber: worker.buildingNumber,
                          cityId: worker.cityId,
                          experienceYears: worker.experienceYears,
                        );
                        Navigator.pushNamed(context, WorkerPhoneNumberPage.id,
                            arguments: updatedWorker);
                      } else {
                        // show errors
                      }
                    }),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
