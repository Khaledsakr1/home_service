import 'package:flutter/material.dart';
import 'package:home_service/constants/constants.dart';

class Button extends StatelessWidget {
  final VoidCallback? ontap;
  final String title;
  final IconData? icon; // صارت nullable
  const Button({
    Key? key,
    this.ontap,
    required this.title,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 300,
        height: 60,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 50,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
