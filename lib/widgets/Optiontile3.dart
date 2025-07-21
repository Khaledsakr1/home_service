import 'package:flutter/material.dart';
import 'package:home_service/widgets/button.dart';

class Optiontile3 extends StatefulWidget {
  final void Function(String)? onSelected;
  const Optiontile3({Key? key,this.onSelected}) : super(key: key);

  @override
  State<Optiontile3> createState() => _Optiontile3State();
}

class _Optiontile3State extends State<Optiontile3> {
  final TextEditingController countryController = TextEditingController(text: "Cairo");
  final TextEditingController governorateController = TextEditingController(text: "Cairo");
  final TextEditingController streetNameController = TextEditingController(text: "Al-Azhar");
  final TextEditingController buildingNumberController = TextEditingController(text: "56");

  bool isEditable = false;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Location",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Country Field
          buildField("Country", countryController),
          const SizedBox(height: 12),

          // Governorate Field
          buildField("Governorate", governorateController),
          const SizedBox(height: 12),

          // Street Name Field
          buildField("Street name", streetNameController),
          const SizedBox(height: 12),

          // Building Number Field
          buildField("Building number", buildingNumberController),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  isEditable = !isEditable;
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.green,
                backgroundColor: Colors.grey.shade200,
              ),
              child: Text(isEditable ? "Done" : "Edit"),
            ),
          ),
          const SizedBox(height: 12),

          Button(
  title: "ok",
  ontap: () {
    final loc = "${countryController.text}, "
      "${governorateController.text}, "
      "${streetNameController.text}, "
      "${buildingNumberController.text}";
    if (widget.onSelected != null) {
      widget.onSelected!(loc);
    }
    // Optionally close or show a message
  },
),

        ],
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          enabled: isEditable,
          decoration: InputDecoration(
            hintText: label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
        ),
      ],
    );
  }
}
