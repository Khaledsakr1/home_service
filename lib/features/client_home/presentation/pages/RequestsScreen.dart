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
    context.read<RequestCubit>().fetchCustomerRequests();
  }

  void _onTabChanged(String tab) {
    setState(() {
      selectedTab = tab;
    });
    final statusCode = tabToStatusCode[tab];
    context.read<RequestCubit>().fetchCustomerRequests(status: statusCode);
  }

  void _showCancelDialog(int requestId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Request'),
          content: const Text('Are you sure you want to cancel this request?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<RequestCubit>().cancelRequest(requestId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Yes, Cancel'),
            ),
          ],
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
        if (state is RequestCancelled || state is RequestSent) {
          // Refresh the requests after cancelling or sending a request
          final tabStatus = tabToStatusCode[selectedTab];
          context.read<RequestCubit>().fetchCustomerRequests(status: tabStatus);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            FilterTabs(
              selectedTab: selectedTab,
              onTabChanged: _onTabChanged,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<RequestCubit, RequestState>(
                builder: (context, state) {
                  if (state is RequestLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.green));
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
                          onCancel: _showCancelDialog,
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No requests available'));
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
