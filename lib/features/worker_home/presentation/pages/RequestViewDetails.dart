import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/widgets/Button.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';
import 'package:home_service/features/requests/presentation/manager/worker_request_cubit.dart';

class Requestviewdetails extends StatelessWidget {
  final Request request;

  const Requestviewdetails({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use project image(s) from API, fallback if empty
    final List<String> images = request.projectImages.isNotEmpty
        ? request.projectImages
        : ['https://via.placeholder.com/400x300?text=No+Image'];

    // --- DYNAMIC: set colors & labels based on request.status ---
    Color statusColor;
    String statusLabel;
    switch (request.status.toLowerCase()) {
      case 'pending':
        statusColor = Colors.orange;
        statusLabel = 'Pending......';
        break;
      case 'accepted':
        statusColor = Colors.green;
        statusLabel = 'Accepted';
        break;
      case 'rejected':
      case 'cancelled':
        statusColor = Colors.red;
        statusLabel = 'Rejected / Cancelled';
        break;
      case 'completed':
        statusColor = Colors.blue;
        statusLabel = 'Completed';
        break;
      default:
        statusColor = Colors.grey;
        statusLabel = 'Unknown';
    }

    return BlocConsumer<WorkerRequestCubit, WorkerRequestState>(
      listener: (context, state) {
        if (state is WorkerRequestAccepted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Request accepted!")));
          Navigator.pop(context);
        } else if (state is WorkerRequestRejected) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Request rejected.")));
          Navigator.pop(context);
        } else if (state is WorkerRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final loading = state is WorkerRequestLoading;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Colors.green,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              request.projectName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section (Customer info from API if available)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          // If you have customer image url, use it here. Otherwise, fallback.
                          'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.green,
                              child: const Icon(Icons.person,
                                  color: Colors.white),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                               'Customer Name',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              request.service,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Request Info
                _infoCard(children: [
                  _infoRow(Icons.calendar_today,
                      'Request made ${request.date}'),
                  _infoRow(Icons.location_on, request.location),
                  _infoRow(Icons.phone, 'You can contact this customer.'),
                ]),
                const SizedBox(height: 16),

                // Job Info
                _infoCard(children: [
                  _buildDetailRow(
                      'Apartment type', request.apartmentType.isEmpty ? '-' : request.apartmentType),
                  const SizedBox(height: 16),
                  _buildDetailRow('Apartment size (meter)',
                      request.apartmentSize.isEmpty ? '-' : request.apartmentSize),
                  const SizedBox(height: 16),
                  _buildDetailRow('Preferred style',
                      request.preferredStyle.isEmpty ? '-' : request.preferredStyle),
                  const SizedBox(height: 16),
                  _buildDetailRow('Material quality',
                      request.materialQuality.isEmpty ? '-' : request.materialQuality),
                  const SizedBox(height: 16),
                  _buildDetailRow('Budget Range',
                      '${request.minBudget} EGP - ${request.maxBudget} EGP'),
                  const SizedBox(height: 16),
                  const Text(
                    'What are the details of your job application?',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    request.projectDetails.isEmpty ? '-' : request.projectDetails,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ]),
                const SizedBox(height: 16),

                // Photos
                _infoCard(children: [
                  const Text('Photos',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 70,
                          height: 70,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          child: Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ]),
                const SizedBox(height: 16),

                // Client Info (you can add more API info if you have)
                _infoCard(children: [
                  const Text('About the client',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  _infoRow(Icons.calendar_today, 'Registered 3 Years ago'),
                  _infoRow(Icons.work, '1 job has expired'),
                ]),
                const SizedBox(height: 24),

                // Buttons & Status Row
                Column(
                  children: [
                    // Accept: only if pending
                    if (request.status == 'pending') ...[
                      Button(
                        title: 'Accept',
                        icon: Icons.check,
                        ontap: loading
                            ? null
                            : () {
                                context
                                    .read<WorkerRequestCubit>()
                                    .acceptRequest(request.id);
                              },
                      ),
                      const SizedBox(height: 12),
                    ],

                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.grey),
                          onPressed: () {
                            // Optionally show a confirm dialog then call reject
                            if (!loading && request.status == 'pending') {
                              context
                                  .read<WorkerRequestCubit>()
                                  .rejectRequest(request.id);
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: statusColor),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.hourglass_empty,
                                    color: statusColor, size: 16),
                                const SizedBox(width: 6),
                                Text(
                                  statusLabel,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Cancel & Finish: only if accepted (show both)
                    if (request.status == 'accepted') ...[
                      Row(
                        children: [
                          Expanded(
                            child: Button(
                              title: 'Cancel',
                              icon: Icons.cancel,
                              backgroundColor: Colors.white,
                              textColor: Colors.red,
                              borderColor: Colors.red,
                              ontap: loading
                                  ? null
                                  : () {
                                      context
                                          .read<WorkerRequestCubit>()
                                          .rejectRequest(request.id);
                                    },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Button(
                              title: 'Finish',
                              icon: Icons.assignment_turned_in,
                              ontap: () {
                                // You may want to handle mark-completed here if the API supports it for worker
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]))),
      ],
    );
  }
}
