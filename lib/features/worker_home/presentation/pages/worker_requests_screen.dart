import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/requests/presentation/manager/worker_request_cubit.dart';
import 'package:home_service/features/worker_home/presentation/widgets/request_card.dart';
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
  };

  final Map<String, int?> tabToStatusCode = {
    'All': null,
    'Pending': 0,
    'Accepted': 1,
    'Rejected': 2,
    'Cancelled': 3,
    'Completed': 4,
  };

  @override
  void initState() {
    super.initState();
    context.read<WorkerRequestCubit>().fetchReceivedRequests();
  }

  void _onTabChanged(String tab) {
    setState(() => selectedTab = tab);
    final statusCode = tabToStatusCode[tab];
    context.read<WorkerRequestCubit>().fetchReceivedRequests(status: statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Received Requests"), centerTitle: true),
      body: BlocConsumer<WorkerRequestCubit, WorkerRequestState>(
        listener: (context, state) {
          if (state is WorkerRequestAccepted || state is WorkerRequestRejected) {
            final statusCode = tabToStatusCode[selectedTab];
            context.read<WorkerRequestCubit>().fetchReceivedRequests(status: statusCode);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              _FilterTabs(
                selectedTab: selectedTab,
                onTabChanged: _onTabChanged,
              ),
              Expanded(
                child: () {
                  if (state is WorkerRequestLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WorkerRequestsLoaded) {
                    if (state.requests.isEmpty) {
                      return const Center(child: Text('No requests found'));
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.requests.length,
                      itemBuilder: (context, i) {
                        final req = state.requests[i];
                        return WorkerRequestCard(
                          request: req,
                          statusCodeToName: statusCodeToName,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Requestviewdetails(
                                  request: req,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is WorkerRequestError) {
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  return const SizedBox.shrink();
                }(),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Simple tabs (reusable)
class _FilterTabs extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;
  const _FilterTabs({required this.selectedTab, required this.onTabChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabs = ['All', 'Pending', 'Accepted', 'Rejected', 'Cancelled', 'Completed'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return GestureDetector(
            onTap: () => onTabChanged(tab),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
