import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_cubit.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_state.dart';
import 'package:home_service/features/worker_details/presentation/pages/PortfolioDetailsPage.dart';

class Serviceviewdetails extends StatefulWidget {
  static const routeName = '/serviceviewdetails';
  final int? workerId;
  const Serviceviewdetails({Key? key, this.workerId}) : super(key: key);

  @override
  State<Serviceviewdetails> createState() => _ServiceviewdetailsState();
}

class _ServiceviewdetailsState extends State<Serviceviewdetails> {
  final scrollController = ScrollController();
  final aboutKey = GlobalKey();
  final photosKey = GlobalKey();
  final reviewsKey = GlobalKey();

  int selectedTab = 0;
  bool _fetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fetched && widget.workerId != null) {
      context.read<WorkerCubit>().fetchWorker(widget.workerId!);
      _fetched = true;
    }
  }

  void scrollTo(GlobalKey key, int tabIndex) {
    setState(() {
      selectedTab = tabIndex;
    });
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget buildTab(String title, int index, VoidCallback onTap) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : const Color(0xFFEFEFEF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provide the cubit from your DI
    return BlocBuilder<WorkerCubit, WorkerState>(
      builder: (context, state) {
        if (state is WorkerLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is WorkerLoaded) {
          final Worker worker = state.worker;
          // Use worker data in your UI instead of static values
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                color: Colors.green,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Details',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo & Info
                  Center(
                    child: Column(
                      children: [
                        // Use worker.profilePictureUrl if exists, else asset
                        worker.profilePictureUrl != null &&
                                worker.profilePictureUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(worker.profilePictureUrl,
                                    height: 60, width: 60, fit: BoxFit.cover),
                              )
                            : Image.asset('assets/images/apple.png',
                                height: 60),
                        const SizedBox(height: 8),
                        Text(
                          worker.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < worker.rating.floor(); i++)
                              const Icon(Icons.star,
                                  size: 14, color: Colors.orange),
                            if (worker.rating - worker.rating.floor() >= 0.5)
                              const Icon(Icons.star_half,
                                  size: 14, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                                "${worker.rating.toStringAsFixed(1)} (${worker.reviews.length} reviews)",
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTab("About", 0, () => scrollTo(aboutKey, 0)),
                      const SizedBox(width: 10),
                      buildTab("Photos", 1, () => scrollTo(photosKey, 1)),
                      const SizedBox(width: 10),
                      buildTab("Reviews", 2, () => scrollTo(reviewsKey, 2)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const SectionDivider(),
                  SectionTitle("About", key: aboutKey),
                  Text(
                    worker.description.isNotEmpty
                        ? worker.description
                        : 'No description available.',
                    style: const TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 20),

                  const SectionDivider(),
                  const SectionTitle("Highlights"),
                  Text("• ${worker.completedRequests} requests completed"),
                  Text(
                      "• ${worker.companyName.isNotEmpty ? worker.companyName : "No company"}"),
                  Text("• ${worker.experienceYears} years in business"),
                  Text("• ${worker.city}"),
                  const SizedBox(height: 20),

                  const SectionDivider(),
                  const SectionTitle("Payment methods"),
                  const Text("Credit Card, Cash, Vodafone cash, ..."),
                  const SizedBox(height: 20),

                  const SectionDivider(),
                  const SectionTitle("Social media"),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      FaIcon(FontAwesomeIcons.facebook,
                          size: 20, color: Colors.blue),
                      SizedBox(width: 12),
                      FaIcon(FontAwesomeIcons.whatsapp,
                          size: 20, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const SectionDivider(),
                  SectionTitle("Photos", key: photosKey),
                  const SizedBox(height: 8),

                  if (worker.portfolioItems.isNotEmpty)
                    Row(
                      children: [
                        ...worker.portfolioItems.take(3).map(
                          (portfolio) {
                            // Pick the first image from the portfolio
                            final firstImage = (portfolio.imageUrls != null &&
                                    portfolio.imageUrls.isNotEmpty)
                                ? portfolio.imageUrls.first
                                : null;

                            if (firstImage != null) {
                              return GestureDetector(
                                onTap: () {
                                  // Navigate to PortfolioDetailsPage (you create this page)
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PortfolioDetailsPage(
                                          portfolio: portfolio),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      firstImage,
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              // If portfolio has no images
                              return const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Center(
                                    child: Text(
                                      "No image",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        // "See all" button
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Text("See all",
                                style: TextStyle(color: Colors.green)),
                          ),
                        )
                      ],
                    )
                  else
                    const Padding(
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

                  const SizedBox(height: 20),

                  const SectionDivider(),
                  SectionTitle("Reviews", key: reviewsKey),
                  const SizedBox(height: 12),
                  if (worker.reviews.isNotEmpty)
                    ...worker.reviews.map((review) => Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ...List.generate(
                                      review.rating.floor(),
                                      (index) => const Icon(Icons.star,
                                          color: Colors.orange, size: 16)),
                                  if (review.rating - review.rating.floor() >=
                                      0.5)
                                    const Icon(Icons.star_half,
                                        color: Colors.orange, size: 16),
                                  const SizedBox(width: 6),
                                  Text(review.rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const Spacer(),
                                  // You may have review.date if available
                                  // Text("March 2025", style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(review.customerName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                review.comment,
                                style: const TextStyle(height: 1.4),
                              ),
                            ],
                          ),
                        )),
                  if (worker.reviews.isEmpty)
                    const Text('No reviews yet.',
                        style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        }
        if (state is WorkerError) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text(state.message)),
          );
        }
        // Initial or unknown state
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text('No worker data available.'),
          ),
        );
      },
    );
  }
}

// Divider reusable
class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 2,
      color: Color(0xFF6C8090),
      indent: 40,
      endIndent: 40,
      height: 15,
    );
  }
}

// Section title with unified style
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
