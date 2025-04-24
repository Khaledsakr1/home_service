import 'package:flutter/material.dart';

class DetailsInput extends StatelessWidget {
  final TextEditingController? controller;

  const DetailsInput({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: "Specify the details of what you want.",
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.all(12),
      ),
    );
  }
}
