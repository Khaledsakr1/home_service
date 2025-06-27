import 'package:flutter/material.dart';

class Repairandinstallationlist extends StatelessWidget {
  final String title;
  final String imageUrl;

  const Repairandinstallationlist(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              height: 150,
              width: 190,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}