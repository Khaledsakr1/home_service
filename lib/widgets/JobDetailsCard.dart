import 'package:flutter/material.dart';
import 'package:home_service/core/utils/OverlayMessage.dart';
import 'package:home_service/widgets/Button.dart';

class JobsDetailsCard extends StatelessWidget {
  final String? title;
  final String? image;
  final String status;
  final VoidCallback? onDelete;
  final Widget? ViewdetailsPage;
  final bool showAcceptButton;

  const JobsDetailsCard({
    super.key,
    this.title,
    this.image,
    this.status = "normal",
    this.onDelete,
    this.ViewdetailsPage,
    this.showAcceptButton = true,
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
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    image!,
                    height: 90,
                    width: 90,
                    fit: BoxFit.cover,
                  ),
                ),
              if (image != null) const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.grey),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'You can contact this customer.',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Colors.grey),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Ismailia ,el salaam',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Customer details..........................',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          status == "pending"
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange.shade300),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.hourglass_empty,
                                color: Colors.orange, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Pending......',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon:
                          const Icon(Icons.delete_outline, color: Colors.grey),
                      onPressed: onDelete,
                    ),
                  ],
                )
              : Row(
                  children: [
                    if (showAcceptButton)
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: Button(
                            title: "Accept",
                            ontap: () {
                              showCustomOverlayMessage(
                                context,
                                message: "Request Accepted",
                                subMessage:
                                    "You can now view the project details.",
                              );
                            },
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            icon: Icons.check,
                          ),
                        ),
                      ),
                    if (showAcceptButton) const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50,
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
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
