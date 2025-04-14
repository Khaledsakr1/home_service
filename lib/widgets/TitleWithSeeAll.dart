import 'package:flutter/material.dart';

class TitleWithSeeAll extends StatelessWidget {
  final String title;

  const TitleWithSeeAll({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'See all >',
            style: TextStyle(color: Colors.green),
          ),
        ],
      ),
    );
  }
}