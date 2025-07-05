import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabSelected;

  const TabSelector({
    Key? key,
    required this.selectedTab,
    required this.onTabSelected,
  }) : super(key: key);

  Widget _buildTab(String title, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab("About", 0),
        const SizedBox(width: 10),
        _buildTab("Photos", 1),
        const SizedBox(width: 10),
        _buildTab("Reviews", 2),
      ],
    );
  }
}