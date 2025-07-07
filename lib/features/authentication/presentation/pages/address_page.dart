import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/authentication/domain/entities/customer.dart';
import 'package:home_service/features/authentication/presentation/manager/authentication_cubit.dart';
import 'package:home_service/features/client_home/presentation/pages/SuceesScreen.dart'; // Assuming this is the success screen
import 'package:home_service/core/utils/ErrorMessage.dart';
import 'package:home_service/widgets/Dropdown.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class City {
  final int id;
  final String name;

  City({required this.id, required this.name});
}

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});
  static String id = 'addresspage';

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
    final Customer? customer =
        ModalRoute.of(context)!.settings.arguments as Customer?;
    if (customer == null)
      return const Scaffold(body: Center(child: Text("Missing data")));

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoading) {
          // Handle loading state if needed
        } else if (state is AuthenticationSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SuccessScreen.id,
            (route) => false,
          );
        } else if (state is AuthenticationError) {
          showErrorOverlayMessage(
            context,
            errorMessage: state.message,
            subMessage: 'Check your internet connection or try again later.',
          );
        }
      },
      builder: (context, state) {
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
                    const SizedBox(height: 20),
                    CustomDropdown<City>(
                      items: cities,
                      selectedItem: selectedCity,
                      onChanged: (value) =>
                          setState(() => selectedCity = value),
                      getName: (city) => city.name,
                      label: 'Select Governoment',
                      title: 'Governoment',
                    ),
                    const SizedBox(height: 10),
                    Textfield(
                        title: 'City',
                        headtextfield: 'Enter your city name',
                        controller: cityController),
                    const SizedBox(height: 10),
                    Textfield(
                        title: 'Street Name',
                        headtextfield: 'Enter your street name',
                        controller: streetController),
                    const SizedBox(height: 10),
                    Textfield(
                        title: 'Building Number',
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
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                          child: Text(
                            errorText!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    SizedBox(
                        width: double.infinity,
                        child: Button(
                          title: 'Continue',
                          ontap: () async {
                            setState(() {
                              errorText = null;
                            });

                            if (_formKey.currentState!.validate() && agreed) {
                              final updatedCustomer = Customer(
                                email: customer.email,
                                password: customer.password,
                                fullName: customer.fullName,
                                phoneNumber: customer.phoneNumber,
                                address:
                                    '${cityController.text}, ${streetController.text}, ${buildingController.text}',
                              );
                              context
                                  .read<AuthenticationCubit>()
                                  .registerCustomer(updatedCustomer);
                            } else if (!agreed) {
                              setState(() {
                                errorText =
                                    'You must agree to the terms & policy';
                              });
                            } else {
                              setState(() {
                                errorText = 'Please fill all fields correctly';
                              });
                            }
                          },
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
