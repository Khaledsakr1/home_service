import 'package:flutter/material.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/widgets/review_card.dart';
import 'package:home_service/features/worker_details/presentation/widgets/section_title.dart';


class WorkerReviewsSection extends StatelessWidget {
  final Worker worker;

  const WorkerReviewsSection({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle("Reviews"),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFDFF6E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "Your trust is our top concern, so businesses can't pay to alter or remove their reviews. Learn more.",
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              worker.rating.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => const Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.orange,
                    ),
                  ),
                ),
                Text(
                  "${worker.reviews.length} reviews",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(
          children: List.generate(5, (index) {
            int star = 5 - index;
            int count = worker.reviews.where((r) => r.rating.floor() == star).length;
            double percent = worker.reviews.isEmpty ? 0 : (count / worker.reviews.length);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Text("$star", style: const TextStyle(fontSize: 12)),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, size: 14, color: Colors.orange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: percent,
                        backgroundColor: Colors.grey[200],
                        color: Colors.green[400],
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "${(percent * 100).toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        if (worker.reviews.isNotEmpty)
          ...worker.reviews.map((review) => ReviewCard(review: review)).toList()
        else
          const Text(
            'No reviews yet.',
            style: TextStyle(color: Colors.grey),
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}