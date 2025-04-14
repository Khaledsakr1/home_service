import 'package:flutter/material.dart';
import 'package:home_service/constants/constants.dart';

// ignore: must_be_immutable
class Textfield extends StatelessWidget {
  Textfield({this.onchanged, this.headtextfield, this.obscuretext = false});
  String? headtextfield;
  Function(String)? onchanged;

  TextEditingController controller = TextEditingController();
  bool? obscuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext!,
      controller: controller,
      style: const TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      ),
      // ignore: body_might_complete_normally_nullable
      validator: (data) {
        if (data!.isEmpty) {
          return 'Required Field';
        }
        controller.clear();
      },
      onChanged: onchanged,
      decoration: InputDecoration(
        labelText: headtextfield,
        labelStyle: const TextStyle(
          color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            height: 1.5
        ),
        focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        border: const OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
        ),
      ),
    );
  }
}