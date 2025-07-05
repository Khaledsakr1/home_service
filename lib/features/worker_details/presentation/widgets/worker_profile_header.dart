import 'package:flutter/material.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';

class WorkerProfileHeader extends StatelessWidget {
  final Worker worker;

  const WorkerProfileHeader({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          worker.profilePictureUrl != null && worker.profilePictureUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    worker.profilePictureUrl,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset('assets/images/profile_default.png', height: 60),
          const SizedBox(height: 8),
          Text(
            worker.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < worker.rating.floor(); i++)
                const Icon(Icons.star, size: 14, color: Colors.orange),
              if (worker.rating - worker.rating.floor() >= 0.5)
                const Icon(Icons.star_half, size: 14, color: Colors.orange),
              const SizedBox(width: 4),
              Text(
                "${worker.rating.toStringAsFixed(1)} (${worker.reviews.length} reviews)",
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
