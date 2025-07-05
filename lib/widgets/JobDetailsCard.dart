import 'package:flutter/material.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/core/utils/image_helper.dart';
import 'package:home_service/widgets/Button.dart';

class JobsDetailsCard extends StatelessWidget {
  final String title;
  final String image;
  final String status;
  final VoidCallback? onDelete;
  final Widget? ViewdetailsPage;
  final bool showAcceptButton;

  // New fields for worker info:
  final String? city;
  final double? rating;
  final String? description;
  final int? experienceYears;
  final String? address;

  const JobsDetailsCard({
    super.key,
    required this.title,
    required this.image,
    this.status = "normal",
    this.onDelete,
    this.ViewdetailsPage,
    this.showAcceptButton = true,
    this.city,
    this.rating,
    this.description,
    this.experienceYears,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: buildImage(image, width: 90, height: 90),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name/Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (description != null && description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          description!,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54),
                        ),
                      ),
                    if (city != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(city!,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    if (experienceYears != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          children: [
                            const Icon(Icons.engineering,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              '$experienceYears years experience',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    if (rating != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                size: 14, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              rating!.toStringAsFixed(1),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    if (address != null && address!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          children: [
                            const Icon(Icons.home,
                                size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                address!,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          SizedBox(
            height: 45,
            child: Button(
              title: "View details",
              ontap: () {
                if (ViewdetailsPage != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ViewdetailsPage!,
                    ),
                  );
                }
              },
              backgroundColor: Colors.white,
              textColor: Colors.green,
              borderColor: Colors.green,
              icon: Icons.visibility,
            ),
          ),
        ],
      ),
    );
  }
}
