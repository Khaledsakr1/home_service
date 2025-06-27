import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/authentication/domain/entities/customer.dart';
import 'package:home_service/features/authentication/presentation/pages/address_page.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});
  static String id = 'phonenumberpage';

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String countryCode = "+20";

  @override
  Widget build(BuildContext context) {
    final Customer? customer = ModalRoute.of(context)!.settings.arguments as Customer?;
    if (customer == null) return const Scaffold(body: Center(child: Text("Missing data")));

    return Scaffold(
      appBar: AppBar(leading: const BackButton(color: Colors.green,), elevation: 0),
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
                      final updatedCustomer = Customer(
                        email: customer.email,
                        password: customer.password,
                        fullName: customer.fullName,
                        phoneNumber: phoneController.text,
                        address: customer.address,
                      );
                      Navigator.pushNamed(context, AddressPage.id, arguments: updatedCustomer);
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


