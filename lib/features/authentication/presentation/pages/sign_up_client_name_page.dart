import 'package:flutter/material.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/authentication/domain/entities/customer.dart';
import 'package:home_service/features/authentication/presentation/pages/phone_number_page.dart';
import 'package:home_service/widgets/Textfield.dart';
import 'package:home_service/widgets/button.dart';

class SignUpClientPage extends StatefulWidget {
  const SignUpClientPage({super.key});
  static String id = 'clientNameSignupage';

  @override
  State<SignUpClientPage> createState() => _SignUpClientPageState();
}

class _SignUpClientPageState extends State<SignUpClientPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Customer? customer = ModalRoute.of(context)!.settings.arguments as Customer?;
    if (customer == null) return const Scaffold(body: Center(child: Text("Missing data")));
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.green,),
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
              Image.asset(ksignup , width: 200, height: 200,),
          
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
                headtextfield: "Enter your last name",
                controller: lastNameController,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Button(title: "Continue", ontap: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedCustomer = Customer(
                      email: customer.email,
                      password: customer.password,
                      fullName: '${firstNameController.text} ${lastNameController.text}',
                      phoneNumber: customer.phoneNumber,
                      address: customer.address,
                    );
                    Navigator.pushNamed(context, PhoneNumberPage.id, arguments: updatedCustomer);
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


