
import 'package:flutter/material.dart';

class FilterTabs extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;
  final int approveCount;
  final bool isWorkerView;

  const FilterTabs({
    Key? key,
    required this.selectedTab,
    required this.onTabChanged,
    this.approveCount = 0,
    this.isWorkerView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Pending', 'Accepted', 'Rejected', 'Cancelled', 'Completed', 'Approve'];
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
                  if (((tab == "Approve" && !isWorkerView) || (tab == "Pending" && isWorkerView)) && approveCount > 0)
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
                          '$approveCount',
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