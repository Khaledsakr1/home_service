import 'package:flutter/material.dart';
import 'package:home_service/constants/constants.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({this.ontap, required this.title});
  VoidCallback? ontap;
  String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.white,
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: 300,
        height: 60,
        child: Center(
          child: Text(
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
                  offset: Offset(2, 2), // Text shadow offset
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}