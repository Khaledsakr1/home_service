import 'package:flutter/material.dart';
import 'package:home_service/widgets/Optionsize.dart';
import 'package:home_service/widgets/button.dart';

class Optiontile1 extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(String type, String? size) onSelected; // <-- updated
  final VoidCallback? onOk;
  final bool closeOnSelect;

  const Optiontile1({
    Key? key,
    required this.title,
    required this.options,
    required this.onSelected,
    this.onOk,
    this.closeOnSelect = false, 
  }) : super(key: key);

  @override
  State<Optiontile1> createState() => _Optiontile1State();
}

class _Optiontile1State extends State<Optiontile1> {
  String? selectedOption;
  final TextEditingController sizeController = TextEditingController();

  @override
  void dispose() {
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool needSize = selectedOption == 'Villa' ||
        selectedOption == 'House' ||
        selectedOption == 'Commercial stores' ||
        selectedOption == 'Gym';

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
          Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                borderSide: const BorderSide(color: Colors.green),
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
  setState(() {
    selectedOption = value;
    sizeController.clear();
  });
  // If closeOnSelect is true, call onSelected and onOk right away
  if (widget.closeOnSelect && value != null) {
    widget.onSelected(value, null);
    if (widget.onOk != null) widget.onOk!();
  }
},
            style: const TextStyle(color: Colors.black),
            iconEnabledColor: Colors.green,
            isExpanded: true,
          ),
          const SizedBox(height: 16),

          if (needSize) ...[
            Optionsize(controller: sizeController),
            const SizedBox(height: 16),
          ],

          Button(
            title: 'ok',
            ontap: () {
              if (selectedOption == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please select an option")),
                );
                return;
              }
              if (needSize && sizeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter the size")),
                );
                return;
              }
              widget.onSelected(
                selectedOption!,
                needSize ? sizeController.text : null,
              );
              if (widget.onOk != null) widget.onOk!();
            },
          ),
        ],
      ),
    );
  }
}
