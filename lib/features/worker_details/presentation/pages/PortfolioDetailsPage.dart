
import 'package:flutter/material.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';

class PortfolioDetailsPage extends StatelessWidget {
  final PortfolioItem portfolio;
  const PortfolioDetailsPage({Key? key, required this.portfolio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(portfolio.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(portfolio.description),
          const SizedBox(height: 16),
          if (portfolio.imageUrls != null && portfolio.imageUrls!.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: portfolio.imageUrls.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(url, height: 100, width: 100, fit: BoxFit.cover),
                );
              }).toList(),
            )
          else
            const Text("No images in this portfolio", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
