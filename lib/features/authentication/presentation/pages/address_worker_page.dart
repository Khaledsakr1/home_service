import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/authentication/data/models/worker_model.dart';
import 'package:home_service/features/authentication/domain/entities/worker.dart';
import 'package:home_service/features/portfolio/presentation/pages/worker_details_page.dart';
import 'package:home_service/widgets/Dropdown.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});
}

class AddressWorkerPage extends StatefulWidget {
  const AddressWorkerPage({super.key});
  static String id = 'addressWorkerPage';

  @override
  State<AddressWorkerPage> createState() => _AddressWorkerPageState();
}

class _AddressWorkerPageState extends State<AddressWorkerPage> {
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool agreed = false;
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

  City? selectedCity;

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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                    'Enter your address',
                    style: TextStyle(
                      fontSize: 25,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 5),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "We will send you job oppertunities from your area and nearby areas",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(height: 20),
                CustomDropdown<City>(
                  items: cities,
                  selectedItem: selectedCity,
                  onChanged: (value) => setState(() => selectedCity = value),
                  getName: (city) => city.name,
                  label: 'Select your Governoment',
                  title: 'Governoment',
                ),
                const SizedBox(height: 10),
                Textfield(
                    title: 'City',
                    headtextfield: 'Enter your city name',
                    controller: cityController),
                const SizedBox(height: 10),
                Textfield(
                    title: 'Street name',
                    headtextfield: 'Enter your street name',
                    controller: streetController),
                const SizedBox(height: 10),
                Textfield(
                    title: 'Commercial Store number',
                    headtextfield: 'Enter your building number',
                    controller: buildingController),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                        value: agreed,
                        onChanged: (val) =>
                            setState(() => agreed = val ?? false)),
                    const Text.rich(TextSpan(
                      children: [
                        TextSpan(text: "I agree to the "),
                        TextSpan(
                          text: "terms & policy",
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    )),
                  ],
                ),
                if (errorText != null) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      errorText!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                ],
                const SizedBox(height: 10),
                SizedBox(
                    width: double.infinity,
                    child: Button(
                      title: 'Continue',
                      ontap: () {
                        setState(() {
                          if (!_formKey.currentState!.validate() || !agreed) {
                            if (!agreed) {
                              errorText = 'Please agree to terms & policy';
                            } else {
                              errorText = null;
                            }
                          } else {
                            errorText = null;
                            final updatedWorker = WorkerModel(
                              email: worker.email,
                              password: worker.password,
                              confirmPassword: worker
                                  .confirmPassword, // pass actual confirmPassword from previous step
                              fullName: worker.fullName,
                              phoneNumber: worker.phoneNumber,
                              address:
                                  '${cityController.text}, ${streetController.text}',
                              description: worker.description,
                              profilePictureUrl: worker.profilePictureUrl,
                              serviceId: worker.serviceId,
                              experienceYears: worker.experienceYears,
                              buildingNumber: buildingController.text,
                              cityId: selectedCity?.id ??
                                  0, // Provide default if null
                              companyName: worker.companyName,
                            );

                            Navigator.pushNamed(context, WorkerDetailsPage.id,
                                arguments: updatedWorker);
                          }
                        });
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
