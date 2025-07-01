import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_cubit.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_state.dart';
import 'package:home_service/features/worker_details/presentation/pages/PortfolioDetailsPage.dart';
import 'package:home_service/features/worker_details/presentation/pages/SeeAllPortfolioPage.dart';
import 'package:home_service/injection_container.dart' as di;
import 'package:home_service/widgets/button.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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

   String? _userType;

  @override
  void initState() {
    super.initState();
    // Decode user type from JWT token
    final token = di.sl<TokenService>().token;
    if (token != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      _userType = decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
    }
  }

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
                  Center(
                    child: Column(
                      children: [
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
                 if (_userType != 'Worker') ...[
  Center(
    child: SizedBox(
      width: 300,
      child: Button(
        title: "Accept Request",
        ontap: () {},
        backgroundColor: Colors.green,
        textColor: Colors.white,
        icon: Icons.check,
      ),
    ),
  ),
  const SizedBox(height: 16),
  Center(
    child: SizedBox(
      width: 300,
      child: Button(
        title: "Message",
        ontap: () {},
        backgroundColor: Colors.white,
        textColor: Colors.green,
        borderColor: Colors.green,
        icon: Icons.message_outlined,
      ),
    ),
  ),
  const SizedBox(height: 30),
],

                  const SectionDivider(),
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
                      const Icon(Icons.work_history,
                          color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Text("${worker.experienceYears} years in business"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.green, size: 20),
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
                      FaIcon(FontAwesomeIcons.facebook,
                          size: 20, color: Colors.blue),
                      SizedBox(width: 12),
                      FaIcon(FontAwesomeIcons.whatsapp,
                          size: 20, color: Colors.green),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SectionDivider(),
                  SectionTitle("Portfolios", key: photosKey),
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
                                final firstImage =
                                    portfolio.imageUrls.isNotEmpty
                                        ? portfolio.imageUrls.first
                                        : null;
                                return firstImage != null
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  PortfolioDetailsPage(
                                                      portfolio: portfolio),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                          child: Text("No image",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12)),
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
                                      child: Text("See all",
                                          style:
                                              TextStyle(color: Colors.green)),
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
                  const SizedBox(height: 20),
                  const SectionDivider(),
                  SectionTitle("Reviews", key: reviewsKey),
                  const SizedBox(height: 12),
                  ..._buildReviewsSection(worker),
                ],
              ),
            ),
          );
        }
        if (state is WorkerError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                color: Colors.green,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Error',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              centerTitle: true,
            ),
            backgroundColor: Colors.white,
            body: Center(child: Text(state.message)),
          );
        }
        return const Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: Text('No worker data available.')),
        );
      },
    );
  }

  List<Widget> _buildReviewsSection(Worker worker) {
    return [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFDFF6E0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          "Your trust is our top concern, so businesses can’t pay to alter or remove their reviews. Learn more.",
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          Text(worker.rating.toStringAsFixed(1),
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  children: List.generate(
                      5,
                      (index) => const Icon(Icons.star,
                          size: 20, color: Colors.orange))),
              Text("${worker.reviews.length} reviews",
                  style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
      const SizedBox(height: 12),
      Column(
        children: List.generate(5, (index) {
          int star = 5 - index;
          int count =
              worker.reviews.where((r) => r.rating.floor() == star).length;
          double percent =
              worker.reviews.isEmpty ? 0 : (count / worker.reviews.length);
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
                Text("${(percent * 100).toStringAsFixed(0)}%",
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        }),
      ),
      const SizedBox(height: 20),
      if (worker.reviews.isNotEmpty)
        ...worker.reviews.map((review) {
          return Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.green[200],
                  child: Text(
                    review.customerName.isNotEmpty
                        ? review.customerName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(review.customerName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Row(
                          children: List.generate(
                              review.rating.floor(),
                              (i) => const Icon(Icons.star,
                                  size: 16, color: Colors.orange))),
                      const SizedBox(height: 8),
                      Text(review.comment,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList()
      else
        const Text('No reviews yet.', style: TextStyle(color: Colors.grey)),
      const SizedBox(height: 16),
     if (_userType != 'Worker')
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Expanded(
        child: Button(
          title: "Cancel",
          ontap: () {},
          backgroundColor: Colors.white,
          textColor: Colors.red,
          borderColor: Colors.red,
          icon: Icons.cancel,
        ),
      ),
      const SizedBox(width: 15),
      Expanded(
        child: Button(
          title: "Finish",
          ontap: () {},
          backgroundColor: Colors.green,
          textColor: Colors.white,
          icon: Icons.check,
        ),
      ),
    ],
  ),
if (_userType != 'Worker')
  const SizedBox(height: 40),

    ];
  }
}

class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      color: const Color(0xFF6C8090).withOpacity(0.3),
      indent: 40,
      endIndent: 40,
      height: 15,
    );
  }
}

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
