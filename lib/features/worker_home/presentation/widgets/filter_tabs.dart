import 'package:flutter/material.dart';

class FilterTabsWidget extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabSelected;
  final List<String> tabs;

  const FilterTabsWidget({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: tabs.map((tab) {
            final isSelected = tab == selectedTab;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () => onTabSelected(tab),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}