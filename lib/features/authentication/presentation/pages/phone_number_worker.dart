import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/authentication/data/models/worker_model.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:home_service/features/authentication/presentation/pages/address_worker_page.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class WorkerPhoneNumberPage extends StatefulWidget {
  const WorkerPhoneNumberPage({super.key});
  static String id = 'phoneNumberWorkerPage';

  @override
  State<WorkerPhoneNumberPage> createState() => _WorkerPhoneNumberPageState();
}

class _WorkerPhoneNumberPageState extends State<WorkerPhoneNumberPage> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String countryCode = "+20";

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
          elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              ksignup,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter your phone number',
                style: TextStyle(
                  fontSize: 25,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                        confirmPassword: worker.confirmPassword, // add this
                        fullName: worker.fullName,
                        phoneNumber: phoneController.text,
                        address: worker.address,
                        buildingNumber: worker
                            .buildingNumber, // provide default if nullable
                        cityId: worker.cityId, // provide default if nullable
                        serviceId: worker.serviceId,
                        description: worker.description,
                        experienceYears: worker.experienceYears,
                        profilePictureUrl: worker.profilePictureUrl,
                        companyName: worker.companyName, // if exists
                      );
                      Navigator.pushNamed(context, AddressWorkerPage.id,
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
    );
  }
}
