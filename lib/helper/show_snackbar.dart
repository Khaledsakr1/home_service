import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String Message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        Message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white, // Text color
          fontSize: 18, // Font size
          fontWeight: FontWeight.bold, // Bold text
          fontStyle: FontStyle.italic, // Italic text
          shadows: [
            Shadow(
              color: Colors.black45,
              blurRadius: 4,
              offset: Offset(2, 2), // Text shadow offset
            ),
          ],
        ),
      ),

      backgroundColor: Colors.blueGrey, // Background color of the SnackBar
      behavior: SnackBarBehavior.floating, // Floating effect
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10), // Margin for floating
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded edges
      ),
      duration: const Duration(seconds: 3), // Duration of SnackBar visibility
    ),
  );
}