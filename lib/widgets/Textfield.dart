import 'package:flutter/material.dart';
import 'package:home_service/constants/constants.dart';

class Textfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? headtextfield;
  final bool obscuretext;
  final Function(String)? onchanged;

  const Textfield({
    Key? key,
    this.controller,
    this.headtextfield,
    this.obscuretext = false,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscuretext,
      style: const TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      validator: (data) {
        if (data == null || data.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        labelText: headtextfield,
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          height: 1.5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }
}
