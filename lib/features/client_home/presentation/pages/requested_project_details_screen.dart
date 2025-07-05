import 'package:flutter/material.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';
import 'package:home_service/features/worker_details/presentation/pages/service_view_details.dart.dart';

class RequestedProjectDetailsScreen extends StatefulWidget {
  final int projectId;
  final Request request;

  const RequestedProjectDetailsScreen({
    Key? key,
    required this.projectId,
    required this.request,
  }) : super(key: key);

  @override
  State<RequestedProjectDetailsScreen> createState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<RequestedProjectDetailsScreen> {
  PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    // Initialize here!
    final List<String> projectImages = widget.request.projectImages.isNotEmpty
        ? widget.request.projectImages
        : ['https://via.placeholder.com/400x300?text=No+Image'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Project Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Container(
              height: 250,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: projectImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(projectImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  // Navigation arrows ...
                  // (rest of carousel code unchanged)
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left,
                              color: Colors.green),
                          onPressed: _currentImageIndex > 0
                              ? () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chevron_right,
                              color: Colors.green),
                          onPressed: _currentImageIndex <
                                  projectImages.length - 1
                              ? () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                  // Page indicators ...
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        projectImages.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Project Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailItem('Project name', widget.request.projectName),
                  _buildDetailItem('Type of Service', widget.request.service),
                  _buildDetailItem(
                      'Apartment type', widget.request.apartmentType),
                  _buildDetailItem(
                      'Apartment size(meter)', widget.request.apartmentSize),
                  _buildDetailItem(
                      'Preferred style', widget.request.preferredStyle),
                  _buildDetailItem(
                      'Material quality', widget.request.materialQuality),
                  _buildDetailItem('Budget',
                      '${widget.request.minBudget} EGP - ${widget.request.maxBudget} EGP'),
                  _buildDetailItem('Location', widget.request.location),
                  _buildDetailItem('Details', widget.request.projectDetails),

                  const SizedBox(height: 32),
                  // Buttons...

                  // --- Always show the View Worker Profile button ---
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Go to worker profile, replace Serviceviewdetails with your actual worker profile page class
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Serviceviewdetails(
                                    workerId: widget.request.workerId,
                                    requestStatus: widget.request
                                        .status, // or .statusCode if you prefer int
                                    requestId: widget.request.id,
                                    formRequsted: true,
                                  ),
                                ));
                          },
                          icon: const Icon(Icons.account_circle,
                              color: Colors.white),
                          label: const Text('View Worker Profile'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // --- Only show message button for pending/accepted ---
                  if (widget.request.status == 'pending' ||
                      widget.request.status == 'accepted') ...[
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Implement your message logic here
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Messaging feature coming soon!')),
                              );
                            },
                            icon: const Icon(Icons.message_outlined,
                                color: Colors.green),
                            label: const Text('Message',
                                style: TextStyle(color: Colors.green)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.green),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
