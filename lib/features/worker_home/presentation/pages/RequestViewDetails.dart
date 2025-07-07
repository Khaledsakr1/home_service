import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/widgets/Button.dart';
import 'package:home_service/features/requests/domain/entities/request.dart';
import 'package:home_service/features/requests/presentation/manager/worker_request_cubit.dart';

class Requestviewdetails extends StatefulWidget {
  final Request request;

  const Requestviewdetails({Key? key, required this.request}) : super(key: key);

  @override
  State<Requestviewdetails> createState() => _RequestviewdetailsState();
}

class _RequestviewdetailsState extends State<Requestviewdetails> {
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _showPriceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.green.shade400,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Enter Your Price',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Budget Range: ${widget.request.minBudget} - ${widget.request.maxBudget} EGP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Your Price (EGP)',
                      hintText: 'Enter your offer price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.attach_money),
                      suffixText: 'EGP',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a price';
                      }
                      final price = double.tryParse(value);
                      if (price == null || price <= 0) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _priceController.clear();
                            Navigator.of(context).pop();
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.grey.shade300),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final price = double.parse(_priceController.text);
                              Navigator.of(context).pop();
                              context
                                  .read<WorkerRequestCubit>()
                                  .acceptRequest(widget.request.id, price);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Accept Request',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> images = widget.request.projectImages.isNotEmpty
        ? widget.request.projectImages
        : ['https://via.placeholder.com/400x300?text=No+Image'];

    Color statusColor;
    String statusLabel;
    switch (widget.request.status.toLowerCase()) {
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
      case 'approve':
        statusColor = Colors.grey;
        statusLabel = 'Approve';
        break;
      default:
        statusColor = Colors.grey;
        statusLabel = 'Unknown';
    }

    return BlocConsumer<WorkerRequestCubit, WorkerRequestState>(
      listener: (context, state) {
        if (state is WorkerRequestAccepted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Request accepted!")));
          Navigator.pop(context);
        } else if (state is WorkerRequestRejected) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Request rejected.")));
          Navigator.pop(context);
        } else if (state is WorkerRequestError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final loading = state is WorkerRequestLoading;

        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            // backgroundColor: Colors.green,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.green),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.request.projectName,
              style: const TextStyle(
                color: Colors.black,
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
                // Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Profile Section
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
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Image.network(
                          'https://via.placeholder.com/150',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.green,
                              child:
                                  const Icon(Icons.person, color: Colors.white),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.request.customerName,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.request.service,
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
                      'Request made ${widget.request.date}'),
                  _infoRow(Icons.location_on, widget.request.location),
                  _infoRow(Icons.phone, 'You can contact this customer.'),
                ]),
                const SizedBox(height: 16),

                // Job Info
                _infoCard(children: [
                  _buildDetailRow(
                      'Apartment type',
                      widget.request.apartmentType.isEmpty
                          ? '-'
                          : widget.request.apartmentType),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                      'Apartment size (meter)',
                      widget.request.apartmentSize.isEmpty
                          ? '-'
                          : widget.request.apartmentSize),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                      'Preferred style',
                      widget.request.preferredStyle.isEmpty
                          ? '-'
                          : widget.request.preferredStyle),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                      'Material quality',
                      widget.request.materialQuality.isEmpty
                          ? '-'
                          : widget.request.materialQuality),
                  const SizedBox(height: 16),
                  // Enhanced Budget Range with highlighting for pending requests
                  if (widget.request.status.toLowerCase() == 'pending')
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.attach_money,
                                  color: Colors.orange.shade600, size: 20),
                              const SizedBox(width: 8),
                              const Text(
                                'Budget Range',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${widget.request.minBudget} EGP - ${widget.request.maxBudget} EGP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Enter your price to accept this request',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    _buildDetailRow('Budget Range',
                        '${widget.request.minBudget} EGP - ${widget.request.maxBudget} EGP'),
                  const SizedBox(height: 16),
                  const Text(
                    'What are the details of your job application?',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.request.projectDetails.isEmpty
                        ? '-'
                        : widget.request.projectDetails,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ]),
                // Show final price for approve, accepted, and completed status
                // Show final price for approve, accepted, and completed status
                if (widget.request.status.toLowerCase() == 'approve' ||
                    widget.request.status.toLowerCase() == 'accepted' ||
                    widget.request.status.toLowerCase() == 'completed') ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: widget.request.status.toLowerCase() ==
                                'accepted'
                            ? [Colors.green.shade50, Colors.green.shade100]
                            : widget.request.status.toLowerCase() == 'completed'
                                ? [Colors.blue.shade50, Colors.blue.shade100]
                                : [
                                    Colors.grey.shade50,
                                    Colors.grey.shade100
                                  ], // approve
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: widget.request.status.toLowerCase() == 'accepted'
                            ? Colors.green.shade200
                            : widget.request.status.toLowerCase() == 'completed'
                                ? Colors.blue.shade200
                                : Colors.grey.shade300, // approve
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: widget.request.status.toLowerCase() ==
                                        'accepted'
                                    ? Colors.green.shade200
                                    : widget.request.status.toLowerCase() ==
                                            'completed'
                                        ? Colors.blue.shade200
                                        : Colors.grey.shade300, // approve
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.monetization_on_outlined,
                                color: widget.request.status.toLowerCase() ==
                                        'accepted'
                                    ? Colors.green.shade700
                                    : widget.request.status.toLowerCase() ==
                                            'completed'
                                        ? Colors.blue.shade700
                                        : Colors.grey.shade700, // approve
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Final Price',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '${widget.request.workerOfferedPrice?.toStringAsFixed(2) ?? "N/A"} EGP',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: widget.request.status.toLowerCase() ==
                                    'accepted'
                                ? Colors.green.shade700
                                : widget.request.status.toLowerCase() ==
                                        'completed'
                                    ? Colors.blue.shade700
                                    : Colors.grey.shade700, // approve
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.request.status.toLowerCase() == 'approve'
                              ? 'Waiting for client response'
                              : widget.request.status.toLowerCase() ==
                                      'accepted'
                                  ? 'Job in progress'
                                  : 'Job completed',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child:
                                    const Icon(Icons.image, color: Colors.grey),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ]),
                const SizedBox(height: 24),

                // Action Buttons
                // Action Buttons - Enhanced to show message button for approve, pending, accepted
                if (widget.request.status.toLowerCase() == 'pending')
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loading ? null : _showPriceDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Accept Request',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: loading
                              ? null
                              : () {
                                  context
                                      .read<WorkerRequestCubit>()
                                      .rejectRequest(widget.request.id);
                                },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Reject Request',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Add message button for pending
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
// Add message button for approve and accepted status
                else if (widget.request.status.toLowerCase() == 'approve' ||
                    widget.request.status.toLowerCase() == 'accepted')
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Messaging feature coming soon!')),
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
