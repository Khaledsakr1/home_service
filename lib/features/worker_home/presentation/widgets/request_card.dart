import 'package:flutter/material.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';

class WorkerRequestCard extends StatelessWidget {
  final Request request;
  final Map<int, String> statusCodeToName;
  final VoidCallback onTap;

  const WorkerRequestCard({
    Key? key,
    required this.request,
    required this.statusCodeToName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusName = statusCodeToName[request.statusCode] ?? 'unknown';

    Color statusColor;
    IconData statusIcon;
    switch (statusName) {
      case 'pending':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case 'accepted':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusIcon = Icons.block;
        break;
      case 'cancelled':
        statusColor = Colors.grey;
        statusIcon = Icons.cancel_outlined;
        break;
      case 'completed':
        statusColor = Colors.blue;
        statusIcon = Icons.done_all;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(request.projectName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 2),
            Text(request.service, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text("Request made ${request.date}", style: const TextStyle(fontSize: 13)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(child: Text(request.location, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Request #${request.id}', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 18),
                    const SizedBox(width: 5),
                    Text(
                      statusName[0].toUpperCase() + statusName.substring(1),
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
