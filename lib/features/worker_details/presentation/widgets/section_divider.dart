import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      color: const Color(0xFF6C8090).withOpacity(0.3),
      indent: 40,
      endIndent: 40,
      height: 15,
    );
  }
}