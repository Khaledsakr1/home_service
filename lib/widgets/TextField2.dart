import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfield2 extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyboardType;

  const Textfield2({
    Key? key,
    required this.hint,
    this.controller,
    this.errorText,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: keyboardType == TextInputType.number
              ? [FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
                width: 1.2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade400,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
