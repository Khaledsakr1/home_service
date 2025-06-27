import 'package:flutter/material.dart';

class Requestsscreen extends StatefulWidget {
  const Requestsscreen({Key? key}) : super(key: key);

  @override
  State<Requestsscreen> createState() => _RequestsscreenState();
}

class _RequestsscreenState extends State<Requestsscreen> {
  String selectedTab = 'Accepted';

  final List<Map<String, String>> requests = [
    {
      'projectName': 'Project Name',
      'service': 'Plumbing Pipe Repair',
      'date': 'March 17, 2025',
      'location': 'Ismailia ,el salaam',
      'status': 'pending',
    },
    {
      'projectName': 'Project Name',
      'service': 'Plumbing Pipe Repair',
      'date': 'March 17, 2025',
      'location': 'Ismailia ,el salaam',
      'status': 'accepted',
    },
    {
      'projectName': 'Project Name',
      'service': 'Electricity Installation',
      'date': 'March 20, 2025',
      'location': 'Cairo, Nasr City',
      'status': 'completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredRequests = selectedTab == 'All'
        ? requests
        : requests.where((req) => req['status'] == selectedTab.toLowerCase()).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Requests', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            buildFilterTabs(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredRequests.length,
                itemBuilder: (context, index) {
                  final req = filteredRequests[index];
                  return buildRequestCard(req);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterTabs() {
    final tabs = ['All', 'Pending', 'Accepted', 'Completed'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = tab;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildRequestCard(Map<String, String> req) {
    final status = req['status'];
    late Color statusColor;
    late IconData icon;

    switch (status) {
      case 'pending':
        statusColor = Colors.orange.shade300;
        icon = Icons.access_time;
        break;
      case 'accepted':
        statusColor = Colors.green;
        icon = Icons.check_circle_rounded;
        break;
      case 'completed':
        statusColor = Colors.blue;
        icon = Icons.done_all;
        break;
      default:
        statusColor = Colors.grey;
        icon = Icons.help;
    }

    final statusText = status![0].toUpperCase() + status.substring(1);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
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
          Text(req['projectName']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(req['service']!, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text("Request made ${req['date']!}", style: const TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.grey),
              const SizedBox(width: 4),
              Text(req['location']!, style: const TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: statusColor),
                const SizedBox(width: 6),
                Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
