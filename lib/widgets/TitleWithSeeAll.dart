import 'package:flutter/material.dart';

class TitleWithSeeAll extends StatelessWidget {
  final String title;
  final VoidCallback? ontap;
  const TitleWithSeeAll({required this.title, this.ontap,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: ontap,
            child: const Text(
              'See all >',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}