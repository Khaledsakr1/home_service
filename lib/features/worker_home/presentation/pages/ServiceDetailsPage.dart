import 'package:flutter/material.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/worker_home/presentation/pages/ServiceViewDetails.dart';
import 'package:home_service/widgets/JobDetailsCard.dart';

class ServiceDetailsPage extends StatelessWidget {
  final Service service;

  const ServiceDetailsPage({super.key, required this.service});

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
        title:Text(
          service.name,
          style: const TextStyle(
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
              // For each worker, show their data as a card
              ...service.workers.map(
                (worker) => JobsDetailsCard(
  title: worker.name,
  image: worker.profilePicture ?? service.imageUrl,
  city: worker.city,
  rating: worker.rating,
  description: worker.description,
  experienceYears: worker.experienceYears,
  address: worker.address,
  showAcceptButton: false,
  ViewdetailsPage: Serviceviewdetails(),
),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
