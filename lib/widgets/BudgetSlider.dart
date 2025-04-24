import 'package:flutter/material.dart';

class BudgetSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const BudgetSlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Budget Range", style: TextStyle(fontWeight: FontWeight.bold)),
          Slider(
           activeColor: Color(0xFF2CB34F),
           thumbColor: Color(0xFF2CB34F),
           inactiveColor: Color(0xffC0E8CA),
            min: 0,
            max: 400000,
            value: value,
            //divisions: 40,
            onChanged: onChanged,
          ),
          Text("Selected: ${value.toInt()} EGP"),
        ],
      ),
    );
  }
}
