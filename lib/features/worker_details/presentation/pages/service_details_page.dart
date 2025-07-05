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
            return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
          }
          if (state is ServicesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is ServicesLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // For each worker, show their data as a card
                    ...widget.service.workers.map(
                      (worker) => JobsDetailsCard(
                        title: worker.name,
                        image: worker.profilePicture ?? widget.service.imageUrl,
                        city: worker.city,
                        rating: worker.rating,
                        description: worker.description,
                        experienceYears: worker.experienceYears,
                        address: worker.address,
                        showAcceptButton: false,
                        ViewdetailsPage:
                            Serviceviewdetails(workerId: worker.id,requestStatus: 'request',),
                      ),
                    ),
                  ],
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
