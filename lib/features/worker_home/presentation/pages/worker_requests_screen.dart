import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/requests/presentation/manager/worker_request_cubit.dart';
import 'package:home_service/features/worker_home/presentation/widgets/request_card.dart';
import '../widgets/filter_tabs.dart';
import 'requestviewdetails.dart';

class WorkerRequestsScreen extends StatefulWidget {
  const WorkerRequestsScreen({Key? key}) : super(key: key);

  @override
  State<WorkerRequestsScreen> createState() => _WorkerRequestsScreenState();
}

class _WorkerRequestsScreenState extends State<WorkerRequestsScreen> {
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
    'Approve': 5,
    'Accepted': 1,
    'Completed': 4,
    'Rejected': 2,
    'Cancelled': 3,
  };

  @override
  void initState() {
    super.initState();
    context.read<WorkerRequestCubit>().fetchReceivedRequests();
  }

  void _onTabChanged(String tab) {
    setState(() {
      selectedTab = tab;
    });
    final statusCode = tabToStatusCode[tab];
    context
        .read<WorkerRequestCubit>()
        .fetchReceivedRequests(status: statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Received Requests',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<WorkerRequestCubit, WorkerRequestState>(
        listener: (context, state) {
          if (state is WorkerRequestAccepted ||
              state is WorkerRequestRejected) {
            final tabStatus = tabToStatusCode[selectedTab];
            context
                .read<WorkerRequestCubit>()
                .fetchReceivedRequests(status: tabStatus);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocBuilder<WorkerRequestCubit, WorkerRequestState>(
            builder: (context, state) {
              int pendingCount = 0;
              int approveCount = 0;
              int acceptedCount = 0;
              if (state is WorkerRequestsLoaded) {
                pendingCount =
                    state.requests.where((r) => r.statusCode == 0).length;
                approveCount =
                    state.requests.where((r) => r.statusCode == 5).length;
                acceptedCount =
                    state.requests.where((r) => r.statusCode == 1).length;
              }
              return Column(
                children: [
                  FilterTabs(
                    selectedTab: selectedTab,
                    onTabChanged: _onTabChanged,
                    tabCounts: {
                      'Pending': pendingCount,
                      // Add other counts as needed, e.g.:
                      'Approve': approveCount,
                      'Accepted': acceptedCount,
                    },
                    isWorkerView: true,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: BlocBuilder<WorkerRequestCubit, WorkerRequestState>(
                      builder: (context, state) {
                        if (state is WorkerRequestLoading) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.green));
                        } else if (state is WorkerRequestError) {
                          return Center(
                            child: Text('Error: ${state.message}',
                                style: const TextStyle(color: Colors.red)),
                          );
                        } else if (state is WorkerRequestsLoaded) {
                          final requests = state.requests;
                          if (requests.isEmpty) {
                            return Center(
                              child: Text(
                                'No ${selectedTab.toLowerCase()} requests found',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 16),
                              ),
                            );
                          }
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: requests.length,
                            itemBuilder: (context, index) {
                              final request = requests[index];
                              return WorkerRequestCard(
                                request: request,
                                statusCodeToName: statusCodeToName,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Requestviewdetails(
                                        request: request,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                        return const Center(
                            child: Text('No requests available'));
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
