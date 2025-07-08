import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/constants/constants.dart';
import 'package:home_service/features/services/domain/entities/service.dart';
import 'package:home_service/features/services/presentation/manager/services_cubit.dart';
import 'package:home_service/features/worker_details/presentation/pages/service_view_details.dart.dart';
import 'package:home_service/widgets/JobDetailsCard.dart';

class ServiceDetailsPage extends StatefulWidget {
  final Service service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // You can perform any initial setup here if needed
    context.read<ServicesCubit>().fetchServices();
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
        title: Text(
          widget.service.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, state) {
          if (state is ServicesLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor,
            ));
          }
          if (state is ServicesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is ServicesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (widget.service.workers.isEmpty)
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.grey[50]!, Colors.grey[100]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey[300]!, width: 1.5),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.person_search_outlined,
                                size: 64,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No Workers Available',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'There are currently no workers available for ${widget.service.name}.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.green.withOpacity(0.3)),
                                ),
                                child: Text(
                                  'Check back later for new workers',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        ...widget.service.workers.map(
                          (worker) => JobsDetailsCard(
                            title: worker.name,
                            image: worker.profilePicture ??
                                widget.service.imageUrl,
                            city: worker.city,
                            rating: worker.rating,
                            description: worker.description,
                            experienceYears: worker.experienceYears,
                            address: worker.address,
                            showAcceptButton: false,
                            ViewdetailsPage: Serviceviewdetails(
                                workerId: worker.id, requestStatus: 'request'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
          // Default return if none of the above conditions are met
          return const Center(
            child: Text('No services available'),
          );
        },
      ),
    );
  }
}
