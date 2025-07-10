import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/core/services/token_service.dart';
import 'package:home_service/features/chat/Presentation/Pages/chatscreen.dart';
import 'package:home_service/features/chat/Presentation/manager/chat_cubit.dart';
import 'package:home_service/features/chat/data/datasources/chat_signalr_service.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';
import 'package:home_service/features/worker_details/presentation/pages/service_view_details.dart.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:home_service/injection_container.dart' as di;

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

  Widget _buildImagePlaceholder({required bool isLoading}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade50,
            Colors.green.shade100,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.green,
                  strokeWidth: 2,
                ),
                const SizedBox(height: 16),
                Text(
                  'Loading image...',
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No Images Available',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Images will appear here when added',
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> projectImages = widget.request.projectImages.isNotEmpty
        ? widget.request.projectImages
        : ['placeholder'];

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
                          color: Colors.grey.shade100,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: widget.request.projectImages.isNotEmpty
                              ? Image.network(
                                  projectImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return _buildImagePlaceholder(
                                        isLoading: true);
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildImagePlaceholder(
                                        isLoading: false);
                                  },
                                )
                              : _buildImagePlaceholder(isLoading: false),
                        ),
                      );
                    },
                  ),
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

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Serviceviewdetails(
                                    workerId: widget.request.workerId,
                                    requestStatus: widget.request.status,
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

                  if (widget.request.status == 'pending' ||
                      widget.request.status == 'accepted' ||
                      widget.request.status == 'approve') ...[
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final token =
                                  await di.sl<TokenService>().getToken();
                              if (token == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Missing token')),
                                );
                                return;
                              }

                              final userData = JwtDecoder.decode(token);

                              final userId = userData.containsKey('workerId')
                                  ? userData['workerId']
                                  : userData.containsKey('customerId')
                                      ? userData['customerId']
                                      : userData.containsKey(
                                              'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier')
                                          ? int.tryParse(userData[
                                                  'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
                                              .toString())
                                          : null;

                              if (userId == null ||
                                  widget.request.id == null ||
                                  widget.request.workerId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Missing required chat info')),
                                );
                                return;
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    //create: (_) => di.sl<ChatCubit>(),
                                     create: (context) => ChatCubit(chatService: di.sl<ChatSignalRService>()),
                                    child: ChatScreen(
                                      userId: userId,
                                      requestId: widget.request.id!,
                                      receiverId: widget.request.workerId!,
                                    ),
                                  ),
                                ),
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
