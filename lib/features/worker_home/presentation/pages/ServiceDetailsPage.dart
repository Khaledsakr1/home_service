import 'package:flutter/material.dart';
import 'package:home_service/features/worker_home/presentation/pages/ServiceViewDetails.dart';
import 'package:home_service/widgets/JobDetailsCard.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String title;
  final String image;

  const ServiceDetailsPage({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.green,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Jobs',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              JobsDetailsCard(
                title: title,
                image: image,
                showAcceptButton: false,
                ViewdetailsPage: Serviceviewdetails(),
              ),
              JobsDetailsCard(
                title: "Fix AC Unit",
                image: image,
                showAcceptButton: false,
                ViewdetailsPage: Serviceviewdetails(),
              ),
              JobsDetailsCard(
                title: "Install Washing Machine",
                image: image,
                showAcceptButton: false,
                ViewdetailsPage: Serviceviewdetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
