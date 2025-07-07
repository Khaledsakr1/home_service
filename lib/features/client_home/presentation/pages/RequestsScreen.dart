import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/client_home/presentation/widgets/filter_tabs.dart';
import 'package:home_service/features/client_home/presentation/widgets/request_card.dart';
import 'package:home_service/features/requests/presentation/manager/request_cubit.dart';
import 'package:home_service/features/requests/presentation/manager/request_state.dart';

class Requestsscreen extends StatefulWidget {
  const Requestsscreen({Key? key}) : super(key: key);

  @override
  State<Requestsscreen> createState() => _RequestsscreenState();
}

class _RequestsscreenState extends State<Requestsscreen> {
  String selectedTab = 'All';

  final Map<int, String> statusCodeToName = {
    0: 'pending',
    1: 'accepted',
    2: 'rejected',
    3: 'cancelled',
    4: 'completed',
    5: 'approve',
  };

  final Map<String, int?> tabToStatusCode = {
    'All': null,
    'Pending': 0,
    'Accepted': 1,
    'Rejected': 2,
    'Cancelled': 3,
    'Completed': 4,
    'Approve': 5,
  };

  @override
  void initState() {
    super.initState();
    context.read<RequestCubit>().fetchCustomerRequests();
  }

  void _onTabChanged(String tab) {
    setState(() {
      selectedTab = tab;
    });
    final statusCode = tabToStatusCode[tab];
    context.read<RequestCubit>().fetchCustomerRequests(status: statusCode);
  }

  void _showModernCancelDialog(int requestId) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red.shade400,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Cancel Request',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Are you sure you want to cancel this request? This action cannot be undone.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey.shade300),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Keep Request',
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
                          Navigator.of(context).pop();
                          context.read<RequestCubit>().cancelRequest(requestId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Cancel Request',
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Requests', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<RequestCubit, RequestState>(
        listener: (context, state) {
          if (state is RequestCancelled || state is RequestSent || state is RequestApproved) {
            // Refresh the requests after cancelling or sending a request
            final tabStatus = tabToStatusCode[selectedTab];
            context.read<RequestCubit>().fetchCustomerRequests(status: tabStatus);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocBuilder<RequestCubit, RequestState>(
            builder: (context, state) {
              int approveCount = 0;
              if (state is RequestsLoaded) {
                approveCount = state.requests.where((r) => r.statusCode == 5).length;
              }
              return Column(
                children: [
                  FilterTabs(
                    selectedTab: selectedTab,
                    onTabChanged: _onTabChanged,
                    approveCount: approveCount,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: BlocBuilder<RequestCubit, RequestState>(
                      builder: (context, state) {
                        if (state is RequestLoading) {
                          // return const Center(child: CircularProgressIndicator(color: Colors.green));
                        } else if (state is RequestError) {
                          return Center(
                            child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)),
                          );
                        } else if (state is RequestsLoaded) {
                          final requests = state.requests;
                          if (requests.isEmpty) {
                            return Center(
                              child: Text(
                                'No ${selectedTab.toLowerCase()} requests found',
                                style: const TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: requests.length,
                            itemBuilder: (context, index) {
                              final request = requests[index];
                              return RequestCard(
                                request: request,
                                statusCodeToName: statusCodeToName,
                                onCancel: _showModernCancelDialog,
                              );
                            },
                          );
                        }
                        return const Center(child: Text('No requests available'));
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}