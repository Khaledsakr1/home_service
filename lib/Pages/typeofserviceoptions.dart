import 'package:flutter/material.dart';
import 'package:home_service/widgets/Optiontile1.dart';

class Typeofserviceoptions extends StatelessWidget {
  const Typeofserviceoptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Type of Service',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const BackButton(
          color: Colors.green,
        ),
      ),
      body: Center(
        child: Optiontile1(
          title: 'Type of service',
          options: [
            'Apartment finishing',
            'Cleaning',
            'Plumber',
            'Electrical',
            'Furniture moving',
            'Air conditioning maintenance',
            'Finishing in installments'
          ],
          onSelected: (value) {
            print("Selected: $value");
          },
        ),
      ),
    );
  }
}
