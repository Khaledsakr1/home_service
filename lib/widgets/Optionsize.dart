import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // لاستيراد FilteringTextInputFormatter

class Optionsize extends StatelessWidget {
  const Optionsize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number, // لضمان إدخال أرقام فقط على لوحة المفاتيح
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // يسمح فقط بإدخال الأرقام
      ],
      decoration: InputDecoration(
        hintText: 'Select option size',  // النص الذي يظهر في الـ hint
        hintStyle: TextStyle(
          color: Colors.black, // نفس اللون المستخدم في الـ DropdownButton
          fontSize: 14,         // نفس الحجم أو يمكن تعديله
          fontWeight: FontWeight.normal, // نفس الوزن
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
