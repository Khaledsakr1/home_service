import 'package:flutter/material.dart';
import 'package:home_service/features/worker_home/presentation/pages/RequestViewDetails.dart';
import 'package:home_service/widgets/JobDetailsCard.dart';

class RequestsscreenWorker extends StatelessWidget {
  const RequestsscreenWorker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   color: Colors.green,
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        title: const Text(
          'Requests',
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
                title: "Water Filter",
                image: "assets/images/water filter.png",
                ViewdetailsPage: Requestviewdetails(title: 'Water Filter', image: ''),
              ),
              JobsDetailsCard(
                title: "Air Condition",
                image: "assets/images/Air condition.jpg",
                status: "pending",
                onDelete: () {
                  // للحذف
                },
              ),
               JobsDetailsCard(
                title: "Install Washing Machine",
                image: "assets/images/house cleaning.png",
                ViewdetailsPage: Requestviewdetails(title: 'Install Washing Machine', image: ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}