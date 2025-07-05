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
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
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
                          : const SizedBox(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Text(
                                  "No image",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
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