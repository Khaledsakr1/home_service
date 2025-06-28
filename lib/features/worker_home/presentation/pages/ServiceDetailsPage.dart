import 'package:flutter/material.dart';
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
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              JobsDetailsCard(
                title: title,
                image: image,
              ),
              JobsDetailsCard(
                title: "Fix AC Unit",
                image: image,
                status: "pending",
                onDelete: (){
                // للحذف
                },
              ),
              JobsDetailsCard(
                title: "Install Washing Machine",
                image: image,
              ),
            ],
          ),
        ),
      ),
    );
  }
}