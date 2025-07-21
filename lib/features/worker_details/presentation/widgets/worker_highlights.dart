import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/widgets/section_divider.dart';
import 'package:home_service/features/worker_details/presentation/widgets/section_title.dart';


class WorkerHighlights extends StatelessWidget {
  final Worker worker;

  const WorkerHighlights({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle("Highlights"),
        Row(
          children: [
            const Icon(Icons.task_alt, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text("${worker.completedRequests} requests completed"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.work_history, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text("${worker.experienceYears} years in business"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text(worker.city),
          ],
        ),
        const SizedBox(height: 20),
        const SectionDivider(),
        const SectionTitle("Company name"),
        Row(
          children: [
            const Icon(Icons.business, color: Colors.green, size: 20),
            const SizedBox(width: 8),
            Text(
              worker.companyName.isNotEmpty
                  ? worker.companyName
                  : "No company",
            ),
          ],
        ),
        const SizedBox(height: 20),
        const SectionDivider(),
        const SectionTitle("Payment methods"),
        const Row(
          children: [
            Icon(Icons.payment, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Text("Credit Card, Cash, Vodafone cash, ..."),
          ],
        ),
        const SizedBox(height: 20),
        const SectionDivider(),
        const SectionTitle("Social media"),
        const SizedBox(height: 8),
        const Row(
          children: [
            FaIcon(FontAwesomeIcons.facebook, size: 20, color: Colors.blue),
            SizedBox(width: 12),
            FaIcon(FontAwesomeIcons.whatsapp, size: 20, color: Colors.green),
          ],
        ),
      ],
    );
  }
}