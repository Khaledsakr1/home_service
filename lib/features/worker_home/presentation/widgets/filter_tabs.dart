
import 'package:flutter/material.dart';

class FilterTabs extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;
  final int approveCount;
  final Map<String, int> tabCounts; 
  final bool isWorkerView;

  const FilterTabs({
    Key? key,
    required this.selectedTab,
    required this.onTabChanged,
    this.tabCounts = const {},
    this.approveCount = 0,
    this.isWorkerView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Pending', 'Approve', 'Accepted', 'Completed', 'Rejected', 'Cancelled'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return GestureDetector(
            onTap: () => onTabChanged(tab),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    tab,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // Show notification on Approve for client view, on Pending for worker view
                  // Show notification badge if this tab has a count > 0
if (tabCounts.containsKey(tab) && tabCounts[tab]! > 0)
  Positioned(
    right: -18,
    top: -8,
    child: Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Text(
        '${tabCounts[tab]}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}