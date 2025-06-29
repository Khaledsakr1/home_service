import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Serviceviewdetails extends StatefulWidget {
  const Serviceviewdetails({super.key});

  @override
  State<Serviceviewdetails> createState() => _ServiceviewdetailsState();
}

class _ServiceviewdetailsState extends State<Serviceviewdetails> {
  final scrollController = ScrollController();
  final aboutKey = GlobalKey();
  final photosKey = GlobalKey();
  final reviewsKey = GlobalKey();

  int selectedTab = 0;

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
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
                  Image.asset('assets/images/apple.png', height: 60),
                  const SizedBox(height: 8),
                  const Text(
                    "Dr.Flow Heating &Cooling Inc",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      Icon(Icons.star, size: 14, color: Colors.orange),
                      SizedBox(width: 4),
                      Text("5.0 (3 reviews)", style: TextStyle(fontSize: 12))
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
            const Text(
              "Dr.Flow Heating & Cooling Inc is founded on pride, quality and customer satisfaction! Competitive pricing for all your HVAC needs! We offer sales, service and installation! We also offer contracts for all heating and cooling equipment! Call the doc !",
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 20),

            const SectionDivider(),
            const SectionTitle("Highlights"),
            const Text("• Hired 6 times"),
            const Text("• 10 employees"),
            const Text("• 11 years in business"),
            const Text("• Banjh, asaleja"),
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
                FaIcon(FontAwesomeIcons.facebook, size: 20, color: Colors.blue),
                SizedBox(width: 12),
                FaIcon(FontAwesomeIcons.whatsapp, size: 20, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20),

            const SectionDivider(),
            SectionTitle("Photos", key: photosKey),
            const SizedBox(height: 8),
            Row(
              children: [
                for (var img in [
                  'assets/images/1..png',
                  'assets/images/2..png',
                  'assets/images/3..png'
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(img,
                          height: 70, width: 70, fit: BoxFit.cover),
                    ),
                  ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("See all", style: TextStyle(color: Colors.green)),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            const SectionDivider(),
            SectionTitle("Reviews", key: reviewsKey),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 6),
                      Text("5.0", style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("March 2025",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("Khaled Sakr", style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                    "Great experience with Dr.Flow! Fast service, friendly team, and reasonable prices. Highly recommended.",
                    style: TextStyle(height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
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