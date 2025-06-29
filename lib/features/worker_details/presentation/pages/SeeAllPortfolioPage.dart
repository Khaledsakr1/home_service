import 'package:flutter/material.dart';
// Import your PortfolioItem entity/model
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/pages/PortfolioDetailsPage.dart';

class SeeAllPortfolioPage extends StatelessWidget {
  final String pageTitle;
  final List<PortfolioItem> portfolios;

  const SeeAllPortfolioPage({
    Key? key,
    required this.pageTitle,
    required this.portfolios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          pageTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemCount: portfolios.length,
          itemBuilder: (context, index) {
            final portfolio = portfolios[index];
            final firstImage = (portfolio.imageUrls.isNotEmpty)
                ? portfolio.imageUrls.first
                : null;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PortfolioDetailsPage(portfolio: portfolio),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (firstImage != null)
                      Image.network(
                        firstImage,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text('No image'),
                        ),
                      ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        portfolio.name, // Or portfolio.name if your entity uses "name"
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
