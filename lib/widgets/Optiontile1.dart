import 'package:flutter/material.dart';
import 'package:home_service/widgets/button.dart';

class Optiontile1 extends StatefulWidget {
  final String title;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const Optiontile1({
    Key? key,
    required this.title,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<Optiontile1> createState() => _Optiontile1State();
}

class _Optiontile1State extends State<Optiontile1> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(widget.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selectedOption,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.green),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
            hint: Text("Select ${widget.title.toLowerCase()}"),
            items: widget.options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              setState(() => selectedOption = value);
            },
            style: TextStyle(
                color: Colors.black), // اللون النص داخل القائمة المنبثقة
            iconEnabledColor: Colors.green, // لون السهم
            isExpanded: true,
          ),
          const SizedBox(height: 16),
          Button(title: 'ok')
        ],
      ),
    );
  }
}