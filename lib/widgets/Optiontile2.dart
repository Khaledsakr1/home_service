import 'package:flutter/material.dart';
import 'package:home_service/widgets/button.dart';

class Optiontile2 extends StatefulWidget {
  final String title;
  final List<String> options;
  final ValueChanged<String> onSelected;
  final String? subtitle;

  const Optiontile2(
      {Key? key,
      required this.title,
      required this.options,
      required this.onSelected,
      this.subtitle})
      : super(key: key);

  @override
  State<Optiontile2> createState() => _Optiontile2State();
}

class _Optiontile2State extends State<Optiontile2> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          ...widget.options.map((option) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: RadioListTile<String>(
                value: option,
                groupValue: selectedOption,
                title: Text(option),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                  widget.onSelected(value!);
                },
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 20),
          Button(
            title: 'ok',
            ontap: () {
              if (selectedOption != null) {
                widget.onSelected(selectedOption!);
              }
            },
          ),
        ],
      ),
    );
  }
}
