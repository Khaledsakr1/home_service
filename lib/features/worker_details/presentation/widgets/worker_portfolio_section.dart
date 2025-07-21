import 'package:flutter/material.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/pages/PortfolioDetailsPage.dart';
import 'package:home_service/features/worker_details/presentation/pages/SeeAllPortfolioPage.dart';
import 'package:home_service/features/worker_details/presentation/widgets/section_title.dart';

class WorkerPortfolioSection extends StatelessWidget {
  final Worker worker;

  const WorkerPortfolioSection({
    Key? key,
    required this.worker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle("Portfolios"),
        const SizedBox(height: 8),
        worker.portfolioItems.isNotEmpty
            ? SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: worker.portfolioItems.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index < worker.portfolioItems.length) {
                      final portfolio = worker.portfolioItems[index];
                      final firstImage = portfolio.imageUrls.isNotEmpty
                          ? portfolio.imageUrls.first
                          : null;
                      return firstImage != null
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PortfolioDetailsPage(
                                      portfolio: portfolio,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  firstImage,
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PortfolioDetailsPage(
                                      portfolio: portfolio,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_outlined,
                                        color: Colors.grey.shade400,
                                        size: 20,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        portfolio
                                            .name, // or portfolio.title - use whatever property holds the name
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SeeAllPortfolioPage(
                                pageTitle: 'All Portfolios',
                                portfolios: worker.portfolioItems,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text(
                              "See all",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'No portfolio images found for this worker.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              ),
      ],
    );
  }
}
