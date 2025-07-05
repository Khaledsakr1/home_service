import 'package:flutter/material.dart';

class RequestCardWidget extends StatelessWidget {
  final String name;
  final String service;
  final String date;
  final bool isUrgent;
  final List<String> tags;
  final String location;
  final VoidCallback? onTap;

  const RequestCardWidget({
    super.key,
    required this.name,
    required this.service,
    required this.date,
    required this.isUrgent,
    required this.tags,
    required this.location,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Service title
            Text(
              service,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            // Customer details line
            Text(
              'Customer details.................................................',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 12),
            // Tags row
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                if (isUrgent) 
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.red[200]!),
                    ),
                    child: const Text(
                      'urgent',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const Icon(
                  Icons.phone,
                  size: 16,
                  color: Colors.grey,
                ),
                ...tags.map((tag) => Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ],
            ),
            const SizedBox(height: 8),
            // Location
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}